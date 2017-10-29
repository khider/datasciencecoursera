#Course Project: Getting and Cleaning Data

##Table of contents
* [Project Overview](#overview)
* [Study Design](#design)
* [Creating the dataset](#dataset)
* [Files](#file)
* [Requirements](#req)

##<a name="overview"> Project Overview </a>

One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.

This project focuses on data collected from the accelerometers from the Samsung Galaxy S smartphone as an example of how data can be retrieved, transformed, and cleaned for further analysis.

##<a name = 'design'>Study Design</a>

The source data for this project was the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The data were originally collected as follows:
>The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

>The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

This project merges the training and test data into a single dataset, on which the following analysis was performed:
1. Extract only the measurements on the mean and standard deviation for each measurement
2. Change the name of the activities to more descriptive annotations
3. Label the dataset with descriptive variable names
4. Create a second, independent tidy dataset with the average of each variable for each activity and each subject.

##<a name="dataset"> Creating the dataset </a>
The R script `run_analysis.R` does the following
1. Downloads and unzips the data from [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
2. Reads the data
3. Merges the  training and the test sets to create one data set.
4. Extracts only the measurements on the mean and standard deviation for each measurement.
5. Uses descriptive activity names to name the activities in the data set
6. Appropriately labels the data set with descriptive variable names.
7 From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
7. Writes the new dataset into a file entitled `tidy_data.txt`

##<a name = 'file'>Files</a>
* `README.me` presents an overview of the project
* `tidy-data.txt` contains the data set, which was obtained from [this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and cleaned up for use with `run_analysis.R`
* `run_analysis.R` contains the R script that was used to create the dataset.
* `CodeBook.m` contains a description of the dataset (data, variable, and transformation used to generate the data)

##<a name = 'req'>Requirements</a>
* The `dplyr` library
