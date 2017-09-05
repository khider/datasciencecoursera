# Set the WG for this exercise.
setwd('/Volumes/Media HD/Documents/Coursera/datasciencecoursera/ProgrammingWithR/Week2')

## Part 1:
# Write a function named 'pollutantmean' that calculates the 
# mean of a pollutant (sulfate or nitrate) across a specified
# list of monitors. The function 'pollutantmean' takes three 
# arguments: 'directory', 'pollutant', and 'id'. 
# Given a vector monitor ID numbers, 'pollutantmean' reads 
# that monitors' particulate matter data from the 
#directory specified in the 'directory' argument and 
#returns the mean of the pollutant across all of the monitors, 
#ignoring any missing values coded as NA. 

## 'directory is a character vector of lemgth 1 indicating the 
## location of the CSV files.

## 'pollutant' is a character vector of length 1 indicating the name
## of the pollutant for wich we will calculate the mean; either "sulfate"
## or "nitrate"

## 'id' is an integer vector indicating the monitor ID numbers to be used

## return the mean of the pollutant across all monitors list 
## in the 'id' vector (ignoring NA values)

pollutantmean <-function(directory, pollutant, id = 1:332){

## Read the data into a dataframe
#Get the name of the files
file_names <-dir(file.path(getwd(),directory))
# Read the data into a dataframe
data <- do.call(rbind,lapply( paste(getwd(),"/",directory,"/",file_names,sep=""),read.csv, header=TRUE))

## Filter by ID
filterDt = data[data$ID %in% id,]

## Calculate the mean
means = mean(filterDt[[pollutant]], na.rm = TRUE)
means
}