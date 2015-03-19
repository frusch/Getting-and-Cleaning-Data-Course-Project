library(dplyr)

## download zip to the temporary file, unzip and read the data, delete temporary file
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp <- tempfile()
download.file(fileurl, temp)
features <- read.table(unzip(temp, "UCI HAR Dataset/features.txt"),
                       sep = "")
activity_labels <- read.table(unzip(temp, "UCI HAR Dataset/activity_labels.txt"),
                              sep = "")
subject_train <- read.table(unzip(temp, "UCI HAR Dataset/train/subject_train.txt"),
                            sep = "")
X_train <- read.table(unzip(temp, "UCI HAR Dataset/train/X_train.txt"),
                      sep = "")
Y_train <- read.table(unzip(temp, "UCI HAR Dataset/train/y_train.txt"),
                      sep = "")
Y_test <- read.table(unzip(temp, "UCI HAR Dataset/test/y_test.txt"), 
                     sep = "")
X_test <- read.table(unzip(temp, "UCI HAR Dataset/test/X_test.txt"),
                     sep = "")
subject_test <- read.table(unzip(temp, "UCI HAR Dataset/test/subject_test.txt"),
                           sep = "")
unlink(temp)

## Extracts only the measurements on the mean and standard deviation for each measurement.
mean_variables <- as.character(features[grep("mean()", features$V2), 2])
mean_variables_num <- features[grep("mean()", features$V2), 1]
std_variables_num <- features[grep("std()", features$V2), 1]
std_variables <- as.character(features[grep("std()", features$V2), 2])
meanstd_variables <- c(mean_variables, std_variables)
meanstd_variables_num <- c(mean_variables_num, std_variables_num)
X <- rbind(select(X_train, meanstd_variables_num), 
           select(X_test, meanstd_variables_num)) ## merge train and test sets with only the necessary measurements
names(X) <- meanstd_variables
Y <- rbind(Y_train, 
           Y_test) ## merge labels from train and test sets
names(Y) <- "Activity"
subject <- rbind(subject_train, 
                 subject_test) ## merge subject ids frim train and test sets
names(subject) <- "Subject_id"
merged_data <- cbind(subject, Y, X) ## merge all data
merged_data <- merge(activity_labels, merged_data, by.y = "Activity", by.x = "V1") ## decode activity variable
merged_data <- select(merged_data, -V1)
names(merged_data)[1] <- "Activity"
features_average <- aggregate(. ~ Activity + Subject_id, data = merged_data, mean) ## calculate average of each variable for each activity and each subject
names(features_average) <- gsub("[()]", "", names(features_average)) ## remove () from variable names
write.table(features_average, "features_average.txt", row.name=FALSE) ## create txt file in working directory
