#Add two numbers together
add2 <-function(x,y){
    x+y
}

#Return all the numbers in vector x above a value of 10
above10 <-function(x){
    use <-x > 10
    x[use]
}

#Return all the numbers in vector x above a value of y (default is 10)
above <-function(x,y=10){
    use<-x>y
    x[use]
}

# Take the mean of columns in a dataframe
columnmean <- function(y, removeNA = TRUE){
    nc <- ncol(y) #Figure out the number of columns
    means <- numeric(nc) #Initialize with all zeros
    for (i in 1:nc){
        means[i]<-mean(y[,i], na.rm = removeNA)
    }
    means
}