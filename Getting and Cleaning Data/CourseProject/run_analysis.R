########################################################################################
#
# File Name: run_analysis.R
# 
# Function: Using data collected from the accelerometers from the Samsung Galaxy S 
#   smartphone, work with the data and make a clean data set, outputting the
#   resulting tidy data to a file named "tidy_data.txt".
#   See README.md for details.
#  
# Author: D. Khider
#
# Date: 10/29/17
########################################################################################

library(dplyr)

#######################################################################################
# Step 1: Download and unzip the data
#######################################################################################
# Set the variable name 
zipUrl<-'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
zipFile<-'UCI_HAR_Dataset.zip'

# If the file is not in the directory, download it
if (!file.exists(zipFile)) {
    download.file(zipUrl, zipFile, mode = "wb")
}

# unzip zip file containing data if data directory doesn't already exist
dataPath <- "UCI HAR Dataset"
if (!file.exists(dataPath)) {
    unzip(zipFile)
}

#######################################################################################
# Step 2: Read the data
#######################################################################################

# Training dataset
trainSubjects<-read.table(file.path(dataPath, "train", "subject_train.txt"))
trainValues<-read.table(file.path(dataPath, "train", "X_train.txt"))
trainActivity<-read.table(file.path(dataPath, "train", "y_train.txt"))

# Test dataset
testSubjects <- read.table(file.path(dataPath, "test", "subject_test.txt"))
testValues <- read.table(file.path(dataPath, "test", "X_test.txt"))
testActivity <- read.table(file.path(dataPath, "test", "y_test.txt"))

#Read features.txt
features <- read.table(file.path(dataPath, "features.txt"), as.is = TRUE)

#Read activity_labels.txt
activities <- read.table(file.path(dataPath, "activity_labels.txt"))
colnames(activities) <- c("activityId", "activityLabel")

#######################################################################################
# Step 3: Merge the training and test datasets
#######################################################################################

# concatenate individual data tables to make single data table
data <- rbind(
    cbind(trainSubjects, trainValues, trainActivity),
    cbind(testSubjects, testValues, testActivity)
)

# Assign colummn names
colnames(data) <- c("subject", features[, 2], "activity")

#######################################################################################
# Step 4: Extracts only the measurements on the mean and standard deviation 
# for each measurement.
#######################################################################################

# determine columns of data set to keep based on column name...
keep <- grepl("subject|activity|mean|std", colnames(data))

# ... and keep data in these columns only
data <- data[,keep]

#######################################################################################
# Step 5: Use descriptive activity names to name the activities in the data set
#######################################################################################

# replace activity values with named factor levels
data$activity <- factor(data$activity, 
                                 levels = activities[, 1], labels = activities[, 2])

#######################################################################################
# Step 6: Appropriately label the data set with descriptive variable names
#######################################################################################

# get column names
Cols <- colnames(data)

# remove special characters
Cols <- gsub("[\\(\\)-]", "", Cols)

# expand abbreviations and clean up names
Cols <- gsub("^f", "frequencyDomain", Cols)
Cols <- gsub("^t", "timeDomain", Cols)
Cols <- gsub("Acc", "Accelerometer", Cols)
Cols <- gsub("Gyro", "Gyroscope", Cols)
Cols <- gsub("Mag", "Magnitude", Cols)
Cols <- gsub("Freq", "Frequency", Cols)
Cols <- gsub("mean", "Mean", Cols)
Cols <- gsub("std", "StandardDeviation", Cols)

# correct typo
Cols <- gsub("BodyBody", "Body", Cols)

# use new labels as column names
colnames(data) <- Cols

##############################################################################
# Step 7 - Create a second, independent tidy set with the average of each
#          variable for each activity and each subject
##############################################################################

# group by subject and activity and summarise using mean
dataMeans <- data %>% 
    group_by(subject, activity) %>%
    summarise_each(funs(mean))

# output to file "tidy_data.txt"
write.table(dataMeans, "tidy_data.txt", row.names = FALSE, 
            quote = FALSE)
