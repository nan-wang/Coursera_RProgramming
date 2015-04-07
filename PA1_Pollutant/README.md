To use the files,

```{r}
	source("complete.R")
	source("corr.R")
	source("pollutantmean.R")
	num_complete <- complete("./specdata")
	correlation_coef <- corr("./specdata")
	mean_sulfate <- pollutantmean("./specdata", "sulfate")
	mean_nitrate <- pollutantmean("./specdata", "nitrate")
```
