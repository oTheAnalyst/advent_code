library(tidyverse)
library(stringr)
library(clipr)
library(purrr)
library(dplyr)

dplyr::col_bind

# day1 <- clipr::read_clip()
# base::save(day1, file = "day1_data.rda")

# load data
base::load(file = "day1_data.rda")

# part 1
day1 <- stringr::str_split(day1, pattern = "  ")
day1 <- data.frame(base::t(base::data.frame(day1)))
day1 <- data.frame(cbind(sort(day1$X1, decreasing = TRUE), sort(day1$X2, decreasing = TRUE)))
day1$diff <- abs(as.numeric(day1[,1]) - as.numeric(day1[,2]))
sum(day1$diff)
str(day1)

base::load(file = "day1_data.rda")

# part 2
day1 <- stringr::str_split(day1, pattern = "   ")
day1 <- data.frame(base::t(base::data.frame(day1)))
query <- as.numeric(day1$X1)
table <- data.frame(table(as.numeric(day1$X2)))

total = 0
for (i in 1:length(query)){
  number <- query[i]
  if (nrow(table[table$Var1 == number, ] ) > 0) {
    total <- total + (number * table[table$Var1 == number,]$Freq)
  }
}

total
