library(stringr)
library(tidyverse)
library(purrr)


# day 2 pt1 

# day2 <- clipr::read_clip()
# base::save(day2, file = "day2_data.rda")


base::load("day2_data.rda")

data <- tibble::as_tibble(day2)

nrow(data)


is_sequential <- function(sequence) {
  sequence <- as.numeric(sequence)
  is_increasing <- all(diff(sequence) > 0)
  is_decreasing <- all(diff(sequence) < 0)

  if ((is_increasing || is_decreasing) &&
    all(abs(diff(sequence)) >= 1 & abs(diff(sequence)) <= 3)) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

# Apply purrr::map to check each sequence
flags <- map(data$value, function(seq) {
  sequence <- strsplit(seq, " ")[[1]]

  is_sequential(sequence)
})

# Use case_when to classify the sequences as "Sequential" or "Not Sequential"
data <- data %>%
  mutate(
    sequence_status = map_chr(flags, ~ case_when(
      .x == TRUE ~ "Safe",
      .x == FALSE ~ "Unsafe"
    ))
  )

data |>
  filter(sequence_status == "Safe") |>
  nrow()

# day2 <- clipr::read_clip()
# base::save(day2, file = "day2_data.rda")


base::load("day2_data.rda")

data <- tibble::as_tibble(day2)

nrow(data)


is_sequential <- function(sequence) {
  sequence <- as.numeric(sequence)
  is_increasing <- all(diff(sequence) > 0)
  is_decreasing <- all(diff(sequence) < 0)

  if ((is_increasing || is_decreasing) &&
    all(abs(diff(sequence)) >= 1 & abs(diff(sequence)) <= 3)) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

# Apply purrr::map to check each sequence
flags <- map(data$value, function(seq) {
  sequence <- strsplit(seq, " ")[[1]]

  is_sequential(sequence)
})

# Use case_when to classify the sequences as "Sequential" or "Not Sequential"
data <- data %>%
  mutate(
    sequence_status = map_chr(flags, ~ case_when(
      .x == TRUE ~ "Safe",
      .x == FALSE ~ "Unsafe"
    ))
  )

data |>
  filter(sequence_status == "Safe") |>
  nrow()






## day2 pt 2 completed 
# day2 <- clipr::read_clip()
# base::save(day2, file = "day2_data.rda")


base::load("day2_data.rda")

data <- tibble::as_tibble(day2)


check_sequence <- function(sequence) {
  # The condition to check for valid differences (no need to define it twice)
  check_condition <- function(seq) {
    all(abs(diff(seq)) >= 1 & abs(diff(seq)) <= 3)
  }
  
  # Check if sequence is increasing or decreasing
  is_valid_sequence <- function(seq) {
    is_increasing <- all(diff(seq) > 0)
    is_decreasing <- all(diff(seq) < 0)
    (is_increasing || is_decreasing) && check_condition(seq)
  }
  # Check if the original sequence or any modified sequence is valid
  if (is_valid_sequence(sequence) || any(map_lgl(1:length(sequence), ~is_valid_sequence(sequence[-.])))) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}


# Apply purrr::map to check each sequence
flags <- map(data$value, function(seq) {
  sequence <- as.numeric(strsplit(seq, " ")[[1]])

  check_sequence(sequence)
})

# Use case_when to classify the sequences as "Sequential" or "Not Sequential"
data <- data %>%
  mutate(
    sequence_status = map_chr(flags, ~ case_when(
      .x == TRUE ~ "Safe",
      .x == FALSE ~ "Unsafe"
    ))
  )

data |>
  filter(sequence_status == "Safe") |>
  nrow()
  
