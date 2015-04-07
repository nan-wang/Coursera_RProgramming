corr <- function(directory, threshold = 0) {
  ## Calculate the correlation between sulfate and nitrate from the records of
  ## each sensor.
    
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  id <- 1:3
  count <- 1
  result <- numeric()
  for(each_id in id) {
    each_filename <- paste("./",directory,"/", formatC(each_id, width=3, flag="0"), ".csv", sep="")
    cur_data <- read.csv(each_filename)
    complete_flag <- complete.cases(cur_data)
    complete_case <- cur_data[complete_flag,]
    num_cases <- nrow(complete_case)
    if(num_cases > threshold) {
      cur_cor <- cor(complete_case$sulfate, complete_case$nitrate)
      result[count] <- cur_cor
      count <- count + 1 
    }
  }
  result
}