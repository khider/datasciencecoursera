# Cleaning anf Getting Data
# Quiz1

setwd('/Volumes/Media HD/Documents/Coursera/datasciencecoursera/Getting and Cleaning Data/Week1')

# Download the data from the web
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv','surveydata.csv',method='curl')

#read it
data = read.csv('surveydata.csv')
length(data$VAL[!is.na(data$VAL) & data$VAL==24])

# Get the data from Natural Gas Acquisition program
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx','Gasdata.xlsx',method='curl')
library(xlsx)
data<-read.xlsx('Gasdata.xlsx', sheetIndex=1)
dat<-read.xlsx('Gasdata.xlsx', sheetIndex=1,rowIndex=18:23,colIndex=7:15)

#xml file
library(XML)
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml','restaurants.xml',method='curl')
doc<-xmlTreeParse('restaurants.xml',useInternalNodes = TRUE)
rootNode <-xmlRoot(doc)
zipcode <- xpathSApply(rootNode,"//zipcode",xmlValue)
length(zipcode[zipcode==21231])

# Idaho data
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv','Idaho.csv',method='curl')
library(data.table)
DT <- fread(input="Idaho.csv", sep=",")
system.time(DT[,mean(pwgtp15),by=SEX])
system.time(rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2])
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
system.time(mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15))


