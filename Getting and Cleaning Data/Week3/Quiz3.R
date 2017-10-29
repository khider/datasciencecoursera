# Quiz3

library(jpeg)
library(data.table)
library(dplyr)
library(Hmisc)

setwd('/Volumes/Media HD/Documents/Coursera/datasciencecoursera/Getting and Cleaning Data/Week3')

# Question1
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "/Volumes/Media HD/Documents/Coursera/datasciencecoursera/Getting and Cleaning Data/Week3/ACS.csv", method='curl')
# Read the file
ACS = read.csv('ACS.csv')
agricultureLogical = ACS$ACR == 3 & ACS$AGS == 6
head(which(agricultureLogical), 3)

# Question2
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg','/Volumes/Media HD/Documents/Coursera/datasciencecoursera/Getting and Cleaning Data/Week3/image.jpg', mode='wb',method='curl')
img = readJPEG('image.jpg', native = TRUE)
quantile(img, probs = c(0.3, 0.8))

#Question3
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv','/Volumes/Media HD/Documents/Coursera/datasciencecoursera/Getting and Cleaning Data/Week3/GDP.csv', method='curl')
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv','/Volumes/Media HD/Documents/Coursera/datasciencecoursera/Getting and Cleaning Data/Week3/edu.csv',method='curl')
# Open the files
gdp = fread('GDP.csv', skip=4, nrows = 190, select = c(1, 2, 4, 5), col.names=c("CountryCode", "Rank", "Economy", "Total"))
edu = fread('edu.csv')
merge = merge(gdp, edu, by = 'CountryCode')

#question4
tapply(merge$Rank, merge$`Income Group`, mean)

#Question5
merge$RankGroups <- cut2(merge$Rank, g=5)
table(merge$RankGroups, merge$`Income Group`)
