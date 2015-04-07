rankall <- function(outcome, num = "best") {
    ## Read outcome data
    filename <- "../ProgAssignment3-data/outcome-of-care-measures.csv"
    raw_input <- read.csv(filename, colClass='character')
    ## Check that state and outcome are valid
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

    ### build state_list
    state_list <- raw_input$State
    state_list <- unique(state_list)
    state_list <- state_list[order(state_list)]
    name_list <- state_list
    for(i in 1:length(state_list)) {
        state <- state_list[i]
        ### remove the NA
        raw_input[, selected_col] <- as.numeric(raw_input[, selected_col])
        valid_flags <- complete.cases(raw_input[, selected_col])
        valid_list <- raw_input[valid_flags,]
        if(nrow(valid_list) == 0) {
            result <- NA
        }
        else {
            ### select the state
            state_flags <- (valid_list$State == state)
            valid_list <- valid_list[state_flags,]
            ### sort the data frame
            if(num == 'worst') {
                ordered_idx <- order(valid_list[, selected_col], valid_list$Hospital.Name,
                                     decreasing = TRUE)
            }
            else {
                ordered_idx <- order(valid_list[, selected_col], valid_list$Hospital.Name)
            }
            valid_list <- valid_list[ordered_idx,]
            ## Return hospital name in that state with the given rank
            ## 30-day death rate
            max_num <- nrow(valid_list)
            if(num == 'best' | num == 'worst') {
                selected_num <- 1
            }
            else {
                selected_num <- as.numeric(num)
            }
            if(selected_num < 1 | selected_num > max_num) {
                result <- NA
            }
            else {
                result <- valid_list[selected_num, ]$Hospital.Name        
            }
        }
        name_list[i] <- result
    }
    result <- cbind(name_list, state_list)
    row.names(result) <- state_list
    colnames(result) <- c("hospital", "state")
    data.frame(result)
}
## Check that state and outcome are valid
## For each state, find the hospital of the given rank
## Return a data frame with the hospital names and the
## (abbreviated) state name