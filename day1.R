library(tidyverse)
library(rstudioapi)
library(clipr)

# data reads 
# day1 <- clipr::read_clip_tbl()
# base::save(day1, file = "day1_data.rda")

base::load(file = "day1_data.rda")
head(day1)
