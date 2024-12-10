library(stringr)
library(tidyverse)

pattern <- "XMAS"

day4 <- clipr::read_clip()
base::save(day4, file = "day4_data.rda")


base::load("day4_data.rda")

found <- str_detect(day4, fixed(day4))

str(found)





new_data <- day4
mat <- as.matrix(day4)

flipped_vertically <- mat[nrow(mat):1, ]
print("Flipped vertically:")
print(flipped_vertically)

flipped_horizontally <- mat[, ncol(mat):1]
print("Flipped horizontally:")
print(flipped_horizontally)


# Reshape into a 4x4 matrix
mat <- matrix(mat, nrow = 4, byrow = TRUE)
print(mat1)


count <- str_count(flipped_horizontally, "XMAS")
print(count)

# Count occurrences of "XMAS" using gregexpr
matches <- gregexpr("XMAS", new_data, fixed = TRUE)
count <- sum(matches[[1]] != -1)
print(count) # Output: 2



library(stringr)
data <- day4
#turn data into a matrix
new_data <- data.frame()
for (i in 1:length(data)){
new_data <- rbind(new_data, str_split_1(data[i], pattern = ""))  
}

#initialize counter
counter = 0

#iterate through the matrix by row scanning for relevant strings - when encountered, add to counter
for (i in 1:nrow(new_data)){
  by_row <- paste(new_data[i,], collapse = "")
  counter <- str_count(by_row, pattern = "XMAS") + str_count(by_row, pattern = "SAMX") + counter
}
#iterate through the matrix by column scanning for relevant strings - when encountered, add to counter
for (i in 1:ncol(new_data)){
  by_col <- paste(new_data[,i], collapse = "")
  counter <- str_count(by_col, pattern = "XMAS") + str_count(by_col, pattern = "SAMX") + counter
}

#define a vector of valid indicies to scan because if diagonals at the edge of the matrix are used that contain fewer than 4 characters, R complains - this will constrain scans to only the diagonals of sufficient length
diag_vector = -136:136
#diag_vector = -6:6

#scan diagonals that run upper left to lower right
for (i in diag_vector){
  by_diag <- paste(new_data[col(new_data)+i==row(new_data)], collapse = "")
  counter <- str_count(by_diag, pattern = "XMAS") + str_count(by_diag, pattern = "SAMX") + counter
}

#define rotate function to turn matrix 90 degrees - so that lower left to upper right diagonals can be scanned
rotate <- function(x) t(apply(x, 2, rev))

#rotate data 90 degrees
rotated_data <- data.frame(rotate(new_data))

#scan diagonals that run lower left to upper right
for (i in diag_vector){
  by_diag <- paste(rotated_data[col(rotated_data)==row(rotated_data)+i], collapse = "")
  counter <- str_count(by_diag, pattern = "XMAS") + str_count(by_diag, pattern = "SAMX") + counter
}


k
#turn data into a matrix
new_data <- data.frame()
for (i in 1:length(data)){
new_data <- rbind(new_data, str_split_1(data[i], pattern = ""))  
}

#identify coordinates of "A" positions
a_positions <- data.frame(which(new_data == "A",arr.ind = TRUE))

#drop entries from first and last row because these can't work as "seed" positions
a_positions <- a_positions[a_positions$row > 1 & a_positions$row < nrow(new_data),]

#drop entries from first and last col because these can't work as "seed" positions
a_positions <- a_positions[a_positions$col > 1 & a_positions$col < ncol(new_data),]

#initialize upper left, lower left, upper right, and upper left positions
a_positions$upper_left <- "i"
a_positions$upper_right <- "love"
a_positions$lower_left <- "nada"
a_positions$lower_right <- "red"

#iterate through each "A" seed and fill in values from matrix
for (i in 1:nrow(a_positions)){
  temp <- a_positions[i,]
  a_positions[i,"upper_left"] <- new_data[temp$row-1, temp$col+1]
  a_positions[i,"upper_right"] <- new_data[temp$row-1, temp$col-1]
  a_positions[i,"lower_left"] <- new_data[temp$row+1, temp$col-1]
  a_positions[i,"lower_right"] <- new_data[temp$row+1, temp$col+1]
}

#collapse these fields into a single string for each seed
a_positions$collapsed_structure <- paste0(a_positions$upper_left, 
                                          a_positions$upper_right, 
                                          a_positions$lower_left, 
                                          a_positions$lower_right)

#define valid strings that correspond to valid XMAS positions
valid_positions <- c("SMMS",
                     "MMSS",
                     "SSMM",
                     "MSSM")

#filter to valid xmas positions
a_positions <- a_positions[a_positions$collapsed_structure %in% valid_positions,]

#the number of rows tells you how many xmas patterns there are
nrow(a_positions)
counter
