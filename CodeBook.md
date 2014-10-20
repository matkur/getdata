Getting and Cleaning Data Project
=================================
Description
-----------
This is CodeBook.md -file for the submission of the course project for the Getting and Cleaning Data course (Coursera, Johns Hopkins, Course-ID: getdata-008 ). This file describes the variables, the data, and any transformations or work that was performed to clean up the source data.  
Data Set Information
--------------------
 A full description of the data used in this project can be found at  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones  
and the source data can be found at  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
### The Readme -file is included in the source data, and it tells as follows:   
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.  
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. More information is provided in 'features_info.txt' ?file in the source data.   

### For each record it is provided:

* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
* Triaxial Angular velocity from the gyroscope. 
* A 561-feature vector with time and frequency domain variables. 
* Its activity label. 
* An identifier of the subject who carried out the experiment.
  
Step 0: Data Acquisition
------------------------
The data is acquired automatically by the script. When the script is run, it always downloads the source data from the URL  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  and unzips it creating directory "UCI HAR Dataset" in the working directory. See Readme.md- file if you don't want to download the source file.  
The script uses reshape2 -library, and if it is not already installed, the script installs it. 
Step1. Merge the training and the test sets to create one data set.
-------------------------------------------------------------------
The following files are read into tables (data frames) in the R- script. Table names used in the script are in parenthesis:    
*	features.txt (features)
*	activity_labels.txt  (activityLabels)
*	subject_train.txt (subjectTrain)
*	x_train.txt (xTrain)
*	y_train.txt (yTrain)
*	subject_test.txt (subjectTest)
*	x_test.txt (xTest)
*	y_test.txt (yTest)
   
The column names in the xTrain and xTest tables are given from the features table and all the other tables are given descriptive column names. To the tables yTain and yTest are attached an extra column which contains the activity labels. In the script two tables are created from the source data, namely: 
* trainingData <- cbind(yTrain,subjectTrain,xTrain)
* testData <- cbind(yTest,subjectTest,xTest).
  
Finally only one table is created:
* finalData <-  rbind(trainingData,testData)  
  
Step 2. Extract only the measurements on the mean and standard deviation for each measurement.
----------------------------------------------------------------------------------------------
To select the columns from xTrain and xTest tables, I decided to take all the column names that include the strings "std" or "mean". For convenience, this step is done in script as a part of Step 1. 

Step 3. Use descriptive activity names to name the activities in the data set
-----------------------------------------------------------------------------
The column "activityID" is dropped from finalData. Activity labels  are attached in Step 1.

Step 4. Appropriately label the data set with descriptive activity names.
------------------------------------------------------------------------
Here I use gsub function for pattern replacement to clean up the data labels:   
* the strings "()" were dropped
* "std" were replaced by "StdDev"
* "mean" were replaced by "Mean""
* "t" in the beginning were replaced by "time"
* "f" in the beginning were replaced by "freq"

This means the following interpretation to the abbreviatons in the column names:  
* subjectId (the test persons id)
* activitylabel ( the activity performed)
* time [in the beginning]  (time domain signal)
* freq [in the beginning]  (frequency domain signal)
* Acc (Acceleration)
* Gyro (gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ)

Step 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.
------------------------------------------------------------------------------------------------------------------------
The finalData table was transformed to the tidyData table using melt- function and dcast function from the reshape2 -library. The result was written to the tidy_data.txt -file using "row.name=FALSE" -option.
