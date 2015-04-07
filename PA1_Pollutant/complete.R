complete <- function(directory, id = 1:3) {
  ## Read the number of complete (valid) records of pollutant in each CSV file.
    
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  result <- data.frame(id, 0)
  colnames(result) <- c('id', 'nobs')
  count <- 1
  for(each_id in id) {
    each_filename <- paste("./",directory,"/", formatC(each_id, width=3, flag="0"), ".csv", sep="")
    cur_data <- read.csv(each_filename)
    # check which rows do not have missing values.
    complete_flag <- complete.cases(cur_data)
    complete_case <- cur_data[complete_flag,]
    result[count, 2] <- nrow(complete_case)
    count <- count + 1 
  }
  result
}