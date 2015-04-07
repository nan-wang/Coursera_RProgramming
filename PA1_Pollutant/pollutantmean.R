pollutantmean <- function(directory, pollutant, id = 1:3) {
  ## Calculate the mean of the selected pollutant. 
    
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  num_cases <- 0
  sum <- 0
  for(each_id in id) {
    each_filename <- paste("./",directory,"/", formatC(each_id, width=3, flag="0"), ".csv", sep="")
    cur_data <- read.csv(each_filename)
    complete_flag <- complete.cases(cur_data[pollutant])
    complete_case <- cur_data[complete_flag,][pollutant]
    num_cases <- num_cases + nrow(complete_case[pollutant])
    if(nrow(complete_case[pollutant])>0){
      sum <- sum + sum(complete_case)
    }
  }
  sum / num_cases
}
