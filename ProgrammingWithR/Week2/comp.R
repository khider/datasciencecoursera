# Set the WG for this exercise.
setwd('/Volumes/Media HD/Documents/Coursera/datasciencecoursera/ProgrammingWithR/Week2')

## Part 2:
# Write a function that reads a directory full of files and reports
# the number of completely observed cases in each data file. 
# The function should return a data frame where the first column is the 
# name of the file and the second column is the number of complete cases.

comp <-function(directory,id=1:332){
    
    #Get the name of the files
    file_names <-dir(file.path(getwd(),directory))
    # Read the data into a dataframe
    data <- do.call(rbind,lapply( paste(getwd(),"/",directory,"/",file_names,sep=""),read.csv, header=TRUE))
    nobs <-numeric(length(id))
    for (i in seq_along(id)){
        ## Filter by ID
        filterDt = data[data$ID %in% id[i],c("nitrate","sulfate")]
        ## Figure out the number of obs 
        filterDt = filterDt[complete.cases(filterDt), ]
        nobs[i] <- nrow(filterDt)
    }
    # Put the dataframe together
    out = data.frame(id = id, nobs = nobs)
    out
}
