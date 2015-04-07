test_function <- function(output, target_output) {
    if(output == target_output) print("passed.")  
}

options(warn=-1)

# source('best.R')
# output <- best("TX", "heart attack")
# target_output <- "CYPRESS FAIRBANKS MEDICAL CENTER"
# test_function(output, target_output)
# output <- best("TX", "heart failure")
# target_output <- "FORT DUNCAN MEDICAL CENTER"
# test_function(output, target_output)
# output <- best("MD", "heart attack")
# target_output <- "JOHNS HOPKINS HOSPITAL, THE"
# test_function(output, target_output)
# output <- best("MD", "pneumonia")
# target_output <- "GREATER BALTIMORE MEDICAL CENTER"
# test_function(output, target_output)

source("rankhospital.R")
output <- rankhospital("TX", "heart failure", 4)
target_output <- "DETAR HOSPITAL NAVARRO"
test_function(output, target_output)
output <- rankhospital("MD", "heart attack", "worst")
target_output <- "HARFORD MEMORIAL HOSPITAL"
test_function(output, target_output)
# output <- rankhospital("MN", "heart attack", 5000)
# target_output <- NA
test_function(output, target_output)

source("rankall.R")
head(rankall("heart attack", 20), 10)
tail(rankall("pneumonia", "worst"), 3)