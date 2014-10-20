Getting and Cleaning Data Project
=================================
Readme.md -file for the submission of the course project for the Getting and Cleaning Data course (Coursera, Johns Hopkins, Course-ID: getdata-008 ). This file describes how the script run_analysis.R works.  
Overview
The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis.  A full description of the data used in this project can be found at  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
and the source data can be found at  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip .

The problem was to create one R script called run_analysis.R that does the following. 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Running the Script
The script run_analysis.R is self-contained.
 It loads the source data from its origin and unzips it to the working directory. If it doesn?t succeed the script prints out "The dataset.zip file is not extracted. The script has stopped." and the script stops. If you don?t want to load the source data from the web, you can comment the lines in the script between comment lines ?## Download begins? and ?## Download ends? 
The script uses "reshape2" ?library, and it will be installed if it does not exist.
The tidy data will be written into the file tidy_data.txt, and it is located in the working directory.
 

Project Summary
===============
The following is a summary description of the project instructions
You should create one R script called run_analysis.R that does the following. 
1.	
Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
3.	Uses descriptive activity names to name the activities in the data set

4.	Appropriately labels the data set with descriptive variable names. 

5.	From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 These 5 steps can be traced in the script with comments and it has also Step 0 where the files and libraries are loaded.

Additional Information
======================
CodeBook.md ?file describes the variables, the data, and any transformations or work that was performed to clean up the data.

