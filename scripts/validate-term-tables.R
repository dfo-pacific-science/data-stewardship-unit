#!/usr/bin/env Rscript
# Validate ontology term table artifacts prior to rendering the site.

# Load required packages
library(readr)
library(jsonlite)

# Try to load yaml package for reading themes.yml
if (requireNamespace("yaml", quietly = TRUE)) {
  library(yaml)
  USE_YAML <- TRUE
} else {
  USE_YAML <- FALSE
  warning("Package 'yaml' not available, using hardcoded theme list")
}

# Function to load expected files from themes.yml dynamically
load_expected_files_from_config <- function(project_root) {
  themes_yml_path <- file.path(project_root, "data/ontology/scripts/config/themes.yml")
  term_tables_dir <- file.path(project_root, "data/ontology/release/artifacts/term-tables")

  expected <- list()

  # Prefer themes.yml to define expected tables
  if (USE_YAML && file.exists(themes_yml_path)) {
    themes_config <- tryCatch({
      read_yaml(themes_yml_path)
    }, error = function(e) {
      warning("Failed to read themes.yml: ", e$message)
      NULL
    })

    if (!is.null(themes_config) && !is.null(themes_config$themes)) {
      for (theme in themes_config$themes) {
        csv_filename <- if (is.null(theme$output_csv)) paste0(theme$id, ".csv") else theme$output_csv
        theme_id <- sub("\\.csv$", "", csv_filename)
        expected[[theme_id]] <- list(
          csv = file.path("data/ontology/release/artifacts/term-tables", csv_filename)
        )
      }
    }
  }

  # Fallback: discover CSVs present in artifacts (no hardcoded legacy list)
  if (length(expected) == 0) {
    csv_files <- list.files(term_tables_dir, pattern = "\\.csv$", full.names = TRUE)
    if (length(csv_files) == 0) {
      stop("No term tables found. Sync artifacts from the dfo-salmon-ontology repo.")
    }
    for (csv_path in csv_files) {
      theme_id <- sub("\\.csv$", "", basename(csv_path))
      expected[[theme_id]] <- list(
        csv = file.path("data/ontology/release/artifacts/term-tables", basename(csv_path))
      )
    }
  }

  return(expected)
}

# Expected files configuration (will be loaded dynamically in main())
EXPECTED_FILES <- NULL

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

  # Load expected files dynamically from themes.yml
  EXPECTED_FILES <<- load_expected_files_from_config(project_root)

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
