library(tidyverse)
library(rstudioapi)
library(clipr)

 data reads 
day1 <- clipr::read_clip()
 base::save(day1, file = "day1_data.rda")

base::load(file = "day1_data.rda")
head(day1)


colnames(day1)
 str(day1)

data <- str_split(data, pattern = "   ")

library(stringr)
data <- str_split(data, pattern = "   ")
data <- data.frame(t(data.frame(data)))
data <- data.frame(cbind(sort(data$X1, decreasing = TRUE), sort(data$X2, decreasing = TRUE)))
data$diff <- abs(as.numeric(data[,1]) - as.numeric(data[,2]))
sum(data$diff))
