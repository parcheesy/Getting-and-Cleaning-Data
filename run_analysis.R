#################################################
##FILE: "run_analysis.R"
##TITLE: "Coursera Getting and Cleaning Data Course Project"
##NAME: "Praveen Rudraraju"

##DESCRIPTION: 
## 1) Merges the training and the test sets to create one data set.
## 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3) Uses descriptive activity names to name the activities in the data set
## 4) Appropriately labels the data set with descriptive variable names. 
## 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##################################################
# Import dplyr package for subsetting data and tidyr package for creating tidy data set.
library(dplyr)
library(tidyr)
library(stringr)

###### 1. Merge the test and training sets into one data set. 

# Set working directory to location of UCI Har Dataset
setwd("./UCI Har Dataset")

# Read in data
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")
subjects_test <- read.table("test/subject_test.txt")
activities_test <- read.table("test/y_test.txt")
testdata <- read.table("test/X_test.txt", fill=TRUE)
subjects_train <- read.table("train/subject_train.txt")
activities_train <- read.table("train/y_train.txt")
traindata <- read.table("train/X_train.txt", fill=TRUE)

# Add activities and subjects to data sets
testdata <- cbind(subjects_test, activities_test, testdata)
traindata <- cbind(subjects_train, activities_train, traindata)

# Name variables
colnames(testdata) <- c("subject", "activityID", as.character(features[,2]))
colnames(traindata) <- colnames(testdata)

# Merge test and train subjects, activities, and data into one data set.
alldata <- rbind(testdata, traindata)

###### 2. Extract only the measurements on the mean and standard deviation for each measurement.

# Create logical vector of variable names indicating subject, activityID, mean, or standard deviation but not mean frequency
meanstd <- (grepl("mean", colnames(alldata)) | grepl("std", colnames(alldata)) | grepl("subject", colnames(alldata)) | grepl("activity", colnames(alldata))) & !grepl("Freq", colnames(alldata))

# Subset data set to include only columns indicated by logical vector
alldata <- alldata[,meanstd]

###### 3. Use descriptive activity names to name the activities in the data set.
alldata <- mutate(alldata, activityID = factor(activityID, levels=activity_labels[,1], labels=activity_labels[,2]))

###### 4. Label the data set with descriptive variable names.
colnames(alldata)[2] <- "activity"
colnames(alldata) <- sub("^t", "time", colnames(alldata))
colnames(alldata) <- sub("^f", "freq", colnames(alldata))
colnames(alldata) <- sub("\\(\\)", "", colnames(alldata))
colnames(alldata) <- sub("BodyBody", "Body", colnames(alldata))

###### 5. Create second tidy data set with average of each variable for each subject and activity.

# Calculate mean of each variable by subject and activity
tdydata <- group_by(alldata, subject, activity)
tdydata <- summarise_each(tdydata, funs(mean(., na.rm=TRUE)))

# Define functions to aid in tidying data set to deal with different formats of variable names

remove_axis <- function(x) {
        if (grepl("-.$", x)) {
                sub("-.$", "", x)
        } else {
                x
        }
}

extract_axis <- function(x) {
        last <- str_extract(x, ".$")
        if (last=="X" || last=="Y" || last=="Z") {
                last
        } else {
        NA
        }
}

# Tidy the data set by isolating one variable to each column.
tdydata <- gather(tdydata, label, averagevalue, -subject, -activity)
tdydata <- mutate(tdydata, label=as.character(label))
tdydata <- separate(tdydata, label, c("domain", "label"), 4)
tdydata <- mutate(tdydata, axis=unlist(lapply(label, extract_axis)))
tdydata <- mutate(tdydata, label=unlist(lapply(label, remove_axis)))
tdydata <- separate(tdydata, label, c("signal", "measurement"))
tdydata <- mutate(tdydata, domain=as.factor(domain), signal=as.factor(signal), measurement=as.factor(measurement), axis=as.factor(axis))
tdydata <- select(tdydata, subject, activity, domain, signal, measurement, axis, averagevalue)

# Write tidy data set to file
write.table(tdydata, "../tidyDataSet.txt", sep="\t", row.names=FALSE)

