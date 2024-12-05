library(stringr)
library(tidyverse)


# day2 <- clipr::read_clip()
# base::save(day2, file = "day2_data.rda")


base::load("day2_data.rda")

data <- tibble::as_tibble(day2)

head(data)


is_sequential <- function(sequence) {
  sequence <- as.numeric(sequence)
  is_increasing <- all(diff(sequence))
  is_decreasing <- all(diff(sequence))

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
  filter(sequence_status == "Safe")
