library(stringr)
library(here)

operators = c("+", "*")
data <- readLines(con <- file("day5.txt"))
sum = 0

for (i in 1:length(data)){
   if (i %% 10 == 0){
   message("Processing ",i, " of ", length(data))
   }
  given_answer = unlist(str_split(data[i], pattern = "[:]"))[1]
  problem = unlist(str_split(data[i], pattern = "[:][ ]"))[2]
  problem <- str_split_1(problem, pattern = " ")
  matrix <- data.frame(t(problem))
  matrix <- rbind(matrix, matrix)
  operator_matrix <- data.frame("holder" = c(1,2))
  for (j in 1:(ncol(matrix) - 1)){
    operator_matrix <- cbind(data.frame(operators), operator_matrix)
  }
  operator_matrix$holder <- NULL
  x <- order(c(1:ncol(matrix), 1:ncol(operator_matrix)))
  matrix <- cbind(matrix, operator_matrix)[,x]
  
  list <- list()
  for (row in 1:ncol(matrix)){
    list <- c(list,unique(matrix[row]))
  }
  matrix <- as.matrix(expand.grid(list))
  
  answers = c()
  for (k in 1:nrow(matrix)){
    if (matrix[k,2] == "+"){
      answer = as.numeric(matrix[k,1]) + as.numeric(matrix[k,3])
    }
    if (matrix[k,2] == "*"){
      answer = as.numeric(matrix[k,1]) * as.numeric(matrix[k,3])
    }
    if (ncol(matrix) > 4)
      for (l in seq(from = 4, to = ncol(matrix), by = 2)){
        if (matrix[k,l] == "+"){
          answer = answer + as.numeric(matrix[k,(l+1)])
        }
        if (matrix[k,l] == "*"){
          answer = answer * as.numeric(matrix[k,(l+1)])
        }
      }
    answers <- c(answers, answer)
  }
  matrix <- cbind(matrix, data.frame(answers))
  if (given_answer %in% matrix$answers){
    sum <- sum + as.numeric(given_answer)
  }
}

as.character(sum)
