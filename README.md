## Getting and Cleaning Data Course Project

## Description

This repository contains materials for submission of a course project in the Coursera Getting and Cleaning Data course. The purpose of the project is to demonstrate the ability to collect, work with and clean a data set.

## Raw Data
The data for this project is from the UCI Machine Learning Repository. It consists of data from the accelerometers of Samsung Galaxy S smartphones as individuals in the study perform a variety of activities. A full description of the data is available at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data used for this project can be obtained at: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## Contents of Repository
This repository contains the following:
+CodeBook.md : describes the variables, data, and transformations performed to clean up the data
+read_analysis.R: script that creates a tidy data set outputs it to a file named "tidyDataSet.txt"

## Important Notes About Script
In order for the script "read_analysis.R" to properly access the raw data it should share a directory with the extracted data directory "UCI Har Dataset". Otherwise the script must be altered to set the working directory to the location of "UCI Har Dataset".

## Description of Script
The script "read_analysis.R" performs the following:
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
