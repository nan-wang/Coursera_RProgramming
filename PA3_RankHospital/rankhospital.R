rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    filename <- "./data/outcome-of-care-measures.csv"
    raw_input <- read.csv(filename, colClass='character')
    ## Check that state and outcome are valid
    if(! (state %in% raw_input$State)) {
        stop("invalid state")
    }
    if(outcome=='heart attack'){
        selected_col <- 11
    }
    else if(outcome=='heart failure'){
        selected_col <- 17
    }
    else if(outcome=='pneumonia'){
        selected_col <- 23
    }
    else {
        stop("invalid outcome")        
    }
    
    ### remove the NA
    raw_input[, selected_col] <- as.numeric(raw_input[, selected_col])
    valid_flags <- complete.cases(raw_input[, selected_col])
    valid_list <- raw_input[valid_flags,]
    ### select the state
    state_flags <- (valid_list$State == state)
    valid_list <- valid_list[state_flags,]
    ### sort the data frame
    ordered_idx <- order(valid_list[, selected_col], valid_list$Hospital.Name)
    valid_list <- valid_list[ordered_idx,]
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    max_num <- nrow(valid_list)
    if(num == 'best') {
        num <- 1
    }
    else if(num == 'worst') {
        num <- max_num
    }
    else {
        num <- as.numeric(num)
    }
    if(num < 1 | num > max_num) {
        result <- NA
    }
    else {
        result <- valid_list[num, ]$Hospital.Name        
    }
    result
}
## Check that state and outcome are valid
