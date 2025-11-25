#!/usr/bin/env Rscript
# Validate ontology term table artifacts prior to rendering the site.

# Load required packages
library(readr)
library(jsonlite)

# Expected files configuration
EXPECTED_FILES <- list(
  "stock-assessment-terms" = list(
    csv = "data/ontology/release/artifacts/term-tables/stock-assessment-terms.csv"
  ),
  "genetics-terms" = list(
    csv = "data/ontology/release/artifacts/term-tables/genetics-terms.csv"
  ),
  "legislation-terms" = list(
    csv = "data/ontology/release/artifacts/term-tables/legislation-terms.csv"
  ),
  "benchmarks-terms" = list(
    csv = "data/ontology/release/artifacts/term-tables/benchmarks-terms.csv"
  ),
  "hatchery-enhancement-terms" = list(
    csv = "data/ontology/release/artifacts/term-tables/hatchery-enhancement-terms.csv"
  )
)

REQUIRED_COLUMNS <- c(
  "term_name",
  "definition",
  "definition_source",
  "definition_source_text",
  "definition_source_link",
  "related_terms",
  "canonical_uri",
  "widoco_link",
  "source_version",
  "source_timestamp",
  "query_checksum"
)

# Get project root (where script is run from)
get_project_root <- function() {
  # Check for QUARTO_PROJECT_DIR environment variable
  project_root <- Sys.getenv("QUARTO_PROJECT_DIR", unset = "")
  if (project_root != "" && file.exists(file.path(project_root, "_quarto.yml"))) {
    return(project_root)
  }
  
  # Fallback: walk up from current directory to find _quarto.yml
  current <- getwd()
  while (current != dirname(current)) {
    if (file.exists(file.path(current, "_quarto.yml"))) {
      return(current)
    }
    current <- dirname(current)
  }
  
  # If not found, use current directory
  return(getwd())
}

validate_csv <- function(csv_path) {
  # Check CSV header and canonical URI coverage
  errors <- character(0)
  
  if (!file.exists(csv_path)) {
    errors <- c(errors, paste0("Missing CSV file: ", csv_path))
    return(errors)
  }
  
  # Read CSV
  df <- tryCatch(
    {
      read_csv(csv_path, show_col_types = FALSE)
    },
    error = function(e) {
      errors <<- c(errors, paste0(csv_path, ": failed to read CSV (", e$message, ")"))
      return(NULL)
    }
  )
  
  if (is.null(df)) {
    return(errors)
  }
  
  # Check for required columns
  missing_columns <- setdiff(REQUIRED_COLUMNS, names(df))
  if (length(missing_columns) > 0) {
    errors <- c(errors, paste0(
      csv_path, ": missing required columns ", 
      paste(missing_columns, collapse = ", ")
    ))
    return(errors)
  }
  
  # Check row count
  row_count <- nrow(df)
  if (row_count == 0) {
    errors <- c(errors, paste0(csv_path, ": file is empty"))
  }
  
  # Check for missing canonical URIs
  missing_uri_rows <- sum(is.na(df$canonical_uri) | df$canonical_uri == "" | is.null(df$canonical_uri))
  if (missing_uri_rows > 0) {
    errors <- c(errors, paste0(
      csv_path, ": ", missing_uri_rows, " rows missing canonical_uri"
    ))
  }
  
  return(errors)
}

validate_meta <- function(csv_path) {
  # Ensure metadata JSON exists and contains key fields
  errors <- character(0)
  
  meta_path <- sub("\\.csv$", ".meta.json", csv_path)
  
  if (!file.exists(meta_path)) {
    errors <- c(errors, paste0("Missing metadata file alongside ", basename(csv_path)))
    return(errors)
  }
  
  # Read JSON metadata
  payload <- tryCatch(
    {
      fromJSON(meta_path, simplifyVector = FALSE)
    },
    error = function(e) {
      errors <<- c(errors, paste0(meta_path, ": invalid JSON (", e$message, ")"))
      return(NULL)
    }
  )
  
  if (is.null(payload)) {
    return(errors)
  }
  
  # Check for required fields
  required_fields <- c("source_version", "source_timestamp", "query_checksum")
  for (field in required_fields) {
    if (is.null(payload[[field]]) || payload[[field]] == "") {
      errors <- c(errors, paste0(meta_path, ": missing ", field))
    }
  }
  
  return(errors)
}

main <- function() {
  project_root <- get_project_root()
  all_errors <- character(0)
  
  for (theme in names(EXPECTED_FILES)) {
    csv_path <- file.path(project_root, EXPECTED_FILES[[theme]]$csv)
    all_errors <- c(all_errors, validate_csv(csv_path))
    all_errors <- c(all_errors, validate_meta(csv_path))
  }
  
  if (length(all_errors) > 0) {
    cat("Validation failed:\n", file = stderr())
    for (message in all_errors) {
      cat(" - ", message, "\n", file = stderr(), sep = "")
    }
    quit(status = 1)
  }
  
  cat("Ontology term tables validated successfully.\n")
  quit(status = 0)
}

# Run main function
main()

