## Getting and Cleaning Data Codebook

### Description of Codebook
This codebook provides additional information describing the data, variables, and transformations performed to clean up the data.

## Experiment and Data Description
A full description of the data can be found at: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The raw data can be obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

When unzipped the data will be found in the directory "UCI HAR Dataset".

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Note: features are normalized and bounded within [-1,1].

## Variables Descriptions
The final tidy data set contains the following variables:
+ "subject" - An integer value corresponding to a subject 1-30. The values are drawn from the files "UCI HAR Dataset/test/subject_test.txt" and "UCI HAR Dataset/train/subject_train.txt" corresponding to the test and training data respectively.
+ "activity" - A factor corresponding to an activity performed. The values are drawn from the files "UCI HAR Dataset/test/y_test.txt" and "UCI HAR Dataset/train/y_train.txt" corresponding to the test and training data respectively. A key relating the integer values found in the data files to the literal activity names is found in "UCI HAR Dataset/activity_labels.txt".
+ "domain" - A factor corresponding to either the 'time' domain or the 'frequency' domain. The values are drawn from the rawvariable names provided in "UCI HAR Dataset/features.txt" and described in "UCI HAR Dataset/features_info.txt".
+ "signal" - A factor corresponding to the signal from which the observation is obtained. The values are drawn from the raw variable names provided in "UCI HAR Dataset/features.txt" and described in "UCI HAR Dataset/features_info.txt".
+ "measurement" - A factor corresponding to either a "mean" or "standard deviation" measurement. The values are drawn from the raw variable names provided in "UCI HAR Dataset/features.txt" and described in "UCI HAR Dataset/features_info.txt".
+ "axis" - A factor corresponding to either the "X", "Y", or "Z" axis along which the observation was made. Some observations have no associated axis value because the measurement, such as a magnitude measurement, is inherently directionless. The values are drawn from the raw variables names provided in "UCI HAR Dataset/features.txt" and described in "UCI HAR Dataset/features_info.txt".
+ "value" - A numeric value representing the average of all observations made in the raw data corresponding to the subject, activity, domain, signal, measurement, and axis. The values are calculated from the raw data values provided in "UCI HAR Dataset/test/X_test.txt" and "UCI HAR Dataset/test/X_train.txt" corresponding to the test and training data respectively.

## Transformations Performed
The following transformations were performed to produce the final tidy data set:

1. Merge the training and the test sets to create one data set.
        +Read in all data
        +Add activities and subjects to the data sets in "UCI HAR Dataset/test/X_test.txt" and "UCI HAR Dataset/train/X_train.txt"
        +Add names to variables from "UCI HAR Dataset/features.txt"
        +Merge test and train data sets into one data set

2. Extract only the measurements on the mean and standard deviation for each measurement. 
        +Create a logical vector of column names indicating subject, activity, mean, or standard deviation, but not mean frequency
        +Subset the data set to include only columns in logical vector
        
3. Use descriptive activity names from "UCI HAR Dataset/activity_labels.txt" to name the activities in the data set
        
4. Appropriately label the data set with descriptive variable names. 

5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
        +Calculate mean of each variable by subject and activity
        +Define functions to aid in tidying data set to deal with different formats of variable names
        +Tidy data set by isolating one variable to each column.

