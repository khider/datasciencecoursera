## Part 3

setwd('/Volumes/Media HD/Documents/Coursera/datasciencecoursera/ProgrammingWithR/Week2')


#Write a function that takes a directory of data files and a
#threshold for complete cases and calculates the correlation 
#between sulfate and nitrate for monitor locations where the number
#of completely observed cases (on all variables) is greater than the
#threshold. The function should return a vector of correlations for 
#the monitors that meet the threshold requirement. If no monitors meet 
#the threshold requirement, then the function should return a numeric 
#vector of length 0.

directory = "specdata"
threshold = 400

corr <- function(directory, threshold=0){
    #Get the name of the files
    file_names <-dir(file.path(getwd(),directory))
    # Read the data into a dataframe
    data <- do.call(rbind,lapply( paste(getwd(),"/",directory,"/",file_names,sep=""),read.csv, header=TRUE))
    id <-1:max(data$ID)
    cr <- numeric(length(id))
    for (i in seq_along(id)){
        filterDt = data[data$ID %in% id[i],c("nitrate","sulfate")]
        filterDt = filterDt[complete.cases(filterDt), ]
        nobs <- nrow(filterDt)
        if (nobs>threshold){
            cr[i] <- cor(filterDt$nitrate, filterDt$sulfate)
        } else {
            cr[i] <-NA
        }
    }
    bad = is.na(cr)
    cr <- cr[!bad]
    cr
}

cr<-corr(directory,threshold)
