#Quiz4
setwd('/Volumes/Media HD/Documents/Coursera/datasciencecoursera/Getting and Cleaning Data/Week4')

library(data.table)

#Question1
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv','/Volumes/Media HD/Documents/Coursera/datasciencecoursera/Getting and Cleaning Data/Week4/ACS.csv',method='curl')
data <-read.csv('ACS.csv')
strsplit(names(data), split = "wgtp")[123]

#Question2
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv','/Volumes/Media HD/Documents/Coursera/datasciencecoursera/Getting and Cleaning Data/Week4/GDP.csv',method='curl')
GDP<-read.csv('GDP.csv')
cleanComma<-gsub(",","",GDP[,5])
mean(as.numeric(cleanComma[1:215]),na.rm = TRUE)

#Question4
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv','/Volumes/Media HD/Documents/Coursera/datasciencecoursera/Getting and Cleaning Data/Week4/edu.csv',method='curl')
edu <-read.csv('edu.csv')
setnames(GDP, c("X", "X.1", "X.3", "X.4"), c("CountryCode", "rankingGDP", "Long.Name", "gdp"))
data <- merge(GDP, edu, by = "CountryCode")
table(grepl("june", tolower(data$Special.Notes)), grepl("fiscal year end", tolower(data$Special.Notes)))[4]

#Question5
library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

length(grep("^2012",sampleTimes))

library(lubridate)
sampleTimes[grep("^2012",sampleTimes)]
sum(weekdays(as.Date(sampleTimes[grep("^2012",sampleTimes)]))=="Monday")

