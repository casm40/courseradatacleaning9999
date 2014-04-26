README file for Coursera Getting and Cleaning Data Course Assigment
===================================================================

Getting and Cleaning Data Week 3 Assignment
===========================================

This README file explains the dataset structure, then shows how the run_analysis.R script achieves each of the steps required. Note that the solution to step 2 comes after the solution to steps 3 and 4.

Dataset Structure
-----------------

The UCI-HAR-Dataset consists of the following files. The script assumes they are all in the UCI_HAR-Dataset folder in the working directory using the same structure as the download from the website (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip): 

The run_analysis.R script does the following:

Merges the training and the test sets to create one data set
------------------------------------------------------------

* The test/subject_test.txt has subjects numbered for all 2947 rows 
* The train/subject_train.txt has subjects numbered for all 7352 rows 
* The features.txt has variables x561, each consisting of measurements 
* The test/X_test.txt contains the test data 
* The train/X_test.txt contain the train data
* The train and test y_test.txt contain the activities data

### Load Data from files

This script loads data from the files into variables and datasets. This makes the components of the dataset available within R Studio.

### Get Headings

This extracts the variable headings, and strips the brackets from them.

### Create complete training and test data sets

This combines the data for the training and test sets with the appopriate subjects and activities.

### Merge Datasets

This merges the training and test data sets and adds the Subject and Activity labels to the first two columns.

Change subject and activity to factors with renaming of levels
--------------------------------------------------------------

This achieves steps 3 and 4 of the assignment by using activity_labels.txt to code the data.

-   Use descriptive activity names to name the activities in the data set
-   Appropriately label the data set with descriptive activity names.

It also changes Subject and Activity columns to factors for later analysis.

Select columns with means and standard divisions
------------------------------------------------
This extracts only the measurements on the mean and standard deviation for each measurement. The script selects all columns containing mean and std, and excludes those containing meanFreq.

Calculate column means by subject and activity
----------------------------------------------
This creates a second tidy data set with variable means for each activity and each subject.
It uses the split function to divide the dataset by Subject and Activity. ColumnMeans are then calculated using lapply. The dataset is tidied to a data frame for presentation



