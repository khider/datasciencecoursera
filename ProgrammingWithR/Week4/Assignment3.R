## Week4 Assignment

# Move working directory

## Part1: PLot the 30-day mortality rates for heart attack
setwd('/Volumes/Media HD/Documents/Coursera/datasciencecoursera/ProgrammingWithR/Week4')
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
#head(outcome)

# Histogram of the 30-day death rates from heart attack
outcome[, 11] <- as.numeric(outcome[, 11])
hist(outcome[,11])

## PART2: Finding the best hospital in a state

state ="TX"
outcomeName = "heart attack"

best<-function(state, outcomeName){
    #Read outcome data
    outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    #Check that state and outcome are valid
    if (!state %in% outcome[,7]){
        stop("invalid state")
    }
    
    if (!outcomeName %in% c("heart attack","heart failure","pneumonia")){
        stop("invalid outcome")
    }
    
    # Return hospital name in that state with lowest 30-day death
    # filter by state
    filterState = outcome[outcome$State %in% state,]
    
    
    # Find the 
    if (outcomeName == "heart attack"){
        filterState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <-suppressWarnings(as.numeric(filterState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
        filterNA <- filterState[!(is.na(filterState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)),]
        rank = filterNA[order(filterNA$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, filterNA$Hospital.Name),]
    }
    if (outcomeName == "heart failure"){
        filterState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure <-suppressWarnings(as.numeric(filterState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
        filterNA <- filterState[!(is.na(filterState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)),]
        rank = filterNA[order(filterNA$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, filterNA$Hospital.Name),]
    }
    if (outcomeName == "pneumonia"){
        filterState$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <-suppressWarnings(as.numeric(filterState$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
        filterNA <- filterState[!(is.na(filterState$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)),]
        rank = filterNA[order(filterNA$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, filterNA$Hospital.Name),]
    }
    hospital <-rank$Hospital.Name[1]
    hospital
}

## PART3: Ranking hospitals by outcome in a state
rankhospital <- function(state, outcomeName,num="best"){
    #Read outcome data
    outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    #Check that state and outcome are valid
    if (!state %in% outcome[,7]){
        stop("invalid state")
    }
    
    if (!outcomeName %in% c("heart attack","heart failure","pneumonia")){
        stop("invalid outcome")
    }
    
    # Return hospital name in that state with lowest 30-day death
    # filter by state
    filterState = outcome[outcome$State %in% state,]
    
    
    # Find the 
    if (outcomeName == "heart attack"){
        filterState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <-suppressWarnings(as.numeric(filterState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
        filterNA <- filterState[!(is.na(filterState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)),]
        rank = filterNA[order(filterNA$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, filterNA$Hospital.Name),]
    } else if (outcomeName == "heart failure"){
        filterState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure <-suppressWarnings(as.numeric(filterState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
        filterNA <- filterState[!(is.na(filterState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)),]
        rank = filterNA[order(filterNA$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, filterNA$Hospital.Name),]
    } else if (outcomeName == "pneumonia"){
        filterState$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <-suppressWarnings(as.numeric(filterState$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
        filterNA <- filterState[!(is.na(filterState$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)),]
        rank = filterNA[order(filterNA$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, filterNA$Hospital.Name),]
    }
    
    if (num=="best"){
        hospital <-rank$Hospital.Name[1]
    } else if (num=="worst"){
        hospital <-rank$Hospital.Name[nrow(rank)]
    } else{
        if (num>nrow(rank)){
            hospital <-NA
        } else{hospital <-rank$Hospital.Name[num]}
    }
    hospital
}

##PART 4: RankAll function

rankall <- function(outcomeName, num = "best"){
    #Read outcome data
    outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    # Check that outcome is valid
    if (!outcomeName %in% c("heart attack","heart failure","pneumonia")){
        stop("invalid outcome")
    }
    # Find unique entries for state
    state <- unique(outcome$State)
    state = sort(state)
    
    for (i in seq_along(state)){
        filterState = outcome[outcome$State %in% state[i],]
        if (outcomeName == "heart attack"){
            filterState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack <-suppressWarnings(as.numeric(filterState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
            filterNA <- filterState[!(is.na(filterState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack)),]
            rank = filterNA[order(filterNA$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, filterNA$Hospital.Name),]
        } else if (outcomeName == "heart failure"){
            filterState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure <-suppressWarnings(as.numeric(filterState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
            filterNA <- filterState[!(is.na(filterState$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure)),]
            rank = filterNA[order(filterNA$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, filterNA$Hospital.Name),]
        } else if (outcomeName == "pneumonia"){
            filterState$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia <-suppressWarnings(as.numeric(filterState$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
            filterNA <- filterState[!(is.na(filterState$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)),]
            rank = filterNA[order(filterNA$Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, filterNA$Hospital.Name),]
        }
        
        if (num=="best"){
            hospital[i] <-rank$Hospital.Name[1]
        } else if (num=="worst"){
            hospital[i] <-rank$Hospital.Name[nrow(rank)]
        } else{
            if (num>nrow(rank)){
                hospital[i] <-NA
            } else{hospital[i] <-rank$Hospital.Name[num]}
        }
    }
    
    output <-data.frame(state=state, hospitalName = hospital)
    output
}


