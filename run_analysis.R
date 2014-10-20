# You should create one R script called run_analysis.R that does the following. 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.

## Step 0: download the data set

# Clean up workspace and load library needed for this script
rm(list=ls())

# Make sure that we have reshape2 -library
if(!require("reshape2")){
    print("trying to install reshape2")
    install.packages("reshape2")
    if(require("reshape2")){
        print("reshape2 is now installed and loaded")
    } else {
        stop("could not install reshape2. The script has stopped.")
    }
}


# download the zip-file to your current directory and unzip the file

if(!file.exists("dataset.zip")){
    download.file(url='https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip' ,destfile="dataset.zip")
}

# If you already have the dataset you want to use, then you can comment the next line
unzip("dataset.zip")

if(!file.exists("UCI HAR Dataset")){
    stop("The dataset.zip file is not extracted. The script has stopped.")
}

## Step 1: Merges the training and the test sets to create one data set.

# Read in the common files
features     = read.table('./UCI HAR Dataset/features.txt')[,2] #load features.txt (later column names)
activityLabels = read.table('./UCI HAR Dataset/activity_labels.txt')[,2] #load activity_labels.txt

# Read the train files
subjectTrain = read.table('./UCI HAR Dataset/train/subject_train.txt') #load subject_train.txt
xTrain       = read.table('./UCI HAR Dataset/train/x_train.txt') #load x_train.txt
yTrain       = read.table('./UCI HAR Dataset/train/y_train.txt') #load y_train.txt

# Read the test files
subjectTest <- read.table('./UCI HAR Dataset/test/subject_test.txt') #load subject_test.txt
xTest <- read.table('./UCI HAR Dataset/test/X_test.txt') #load x_test.txt
yTest <- read.table('./UCI HAR Dataset/test/y_test.txt') #load y_test.txt

# Assigin column names for the data sets
names(activityLabels) <- c('activityLabel')

names(subjectTrain) <- "subjectId"
names(subjectTest)  <- "subjectId"

names(xTrain) <- features
names(xTest)  <- features

# add column activityLabel to yTrain and yTest datasets corresponding to the activityId
yTrain[,2] <- activityLabels[yTrain[,1]]
yTest[,2]  <- activityLabels[yTest[,1]]

# add he column names
names(yTrain) <- c("activityID", "activityLabel")
names(yTest)  <- c("activityID", "activityLabel")



needed_features <- grepl("mean|std", features)

# select only the needed columns from xTrain and xTest tables ( this is actually part of step 2)


# Leave only the needed columns in xTrain and xTest -tables (columns with "mean" or "std" in their names.)
xTrain <- xTrain[,needed_features]
xTest <- xTest[,needed_features]

# finally merge the test and train data sets

# create the complete train data set  by merging xTrain, yTrain, and subjectTrain
trainingData <- cbind(yTrain,subjectTrain,xTrain) 

# Create the complete test set by merging the xTest, yTest, and subjectTest data
testData <- cbind(yTest,subjectTest,xTest)

# merge the two data sets

finalData <-  rbind(trainingData,testData)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# This step was already perfomed is step 1: leave only the needed columns in xTrain and xTest -tables (columns with "mean" or "std" in their names.) 



## 3. Uses descriptive activity names to name the activities in the data set
# activity labels where added to the tables yTrain and yTest is step 1: add column activityLabel to yTrain and yTest datasets corresponding to the activityId
# drop the activityID columns
finalData <- subset( finalData, select = -activityID )

# 4. Appropriately labels the data set with descriptive variable names. 
cNames  = names(finalData)
for (i in 1:length(cNames)) 
{
    cNames[i] = gsub("\\()","",cNames[i])
    cNames[i] = gsub("-std","StdDev",cNames[i])
    cNames[i] = gsub("-mean","Mean",cNames[i])
    cNames[i] = gsub("^(t)","time",cNames[i])
    cNames[i] = gsub("^(f)","freq",cNames[i])
    cNames[i] = gsub("Acc","Acceleration",cNames[i])
    cNames[i] = gsub("BodyBody","Body",cNames[i])
}
names(finalData)<-cNames


# tidy data:
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable
## for each activity and each subject.


# transform the finalData to a long format (meltData)
idLabels   = c("subjectId", "activityLabel")
columnLabels = setdiff(colnames(finalData), idLabels)
meltData      = melt(finalData, id = idLabels, measure.vars = columnLabels)

#cast takes long-format data and casts it into wide-format data
tidyData   = dcast(meltData, subjectId + activityLabel ~ variable, mean)


write.table(tidyData, file = "./tidy_data.txt", row.name=FALSE)
