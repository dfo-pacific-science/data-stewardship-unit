# SPSR Data Dictionary Validator Functions

# This file defines a set of R functions used to compare submitted data dictionaries
# to the official SPSR reference vocabulary (hosted as JSON).

library(jsonlite)
library(dplyr)
library(stringdist)
library(readr)

# Load the reference vocabulary from a GitHub or local JSON file
load_vocab <- function(vocab_url) {
  vocab <- fromJSON(vocab_url, flatten = TRUE)
  return(vocab)
}

# Validate submitted terms against vocab
validate_terms <- function(submitted_df, vocab_df) {
  submitted_terms <- tolower(trimws(submitted_df$variable_name))
  vocab_terms <- tolower(trimws(vocab_df$variable_name))
  
  unmatched <- setdiff(submitted_terms, vocab_terms)
  matched <- intersect(submitted_terms, vocab_terms)
  
  return(list(
    matched = matched,
    unmatched = unmatched
  ))
}

# Suggest best match using string distance
# TODO: Improve using text2vec or similar for better performance
# Currently using Jaro-Winkler distance for fuzzy matching
# This function suggests the best match for each term in the submitted data dictionary
suggest_term_mapping <- function(submitted_df, vocab_df, max_dist = 3) {
  results <- data.frame(
    variable_name = submitted_df$variable_name,
    suggested_match = NA,
    distance = NA,
    stringsAsFactors = FALSE
  )
  
  for (i in seq_len(nrow(submitted_df))) {
    term <- tolower(trimws(submitted_df$variable_name[i]))
    distances <- stringdist(term, tolower(trimws(vocab_df$variable_name)), method = "jw")
    best <- which.min(distances)
    
    if (length(best) > 0 && distances[best] <= max_dist) {
      results$suggested_match[i] <- vocab_df$variable_name[best]
      results$distance[i] <- distances[best]
    }
  }
  return(results)
}

# Full validation wrapper
validate_data_dictionary <- function(submitted_path, vocab_url) {
  submitted_df <- read_csv(submitted_path, show_col_types = FALSE)
  vocab_df <- load_vocab(vocab_url)
  
  # Step 1: Direct match check
  match_result <- validate_terms(submitted_df, vocab_df)
  
  # Step 2: Fuzzy matching
  suggestions <- suggest_term_mapping(submitted_df, vocab_df)
  
  # Step 3: Merge with submission
  validated <- submitted_df %>%
    mutate(
      variable_name_lower = tolower(variable_name)
    ) %>%
    left_join(suggestions, by = "variable_name")
  
  return(list(
    matched_terms = match_result$matched,
    unmatched_terms = match_result$unmatched,
    suggestions = suggestions,
    validated_table = validated
  ))
}
