# Shared helpers for ontology term table pages (R version)

# Load required packages (if not already loaded)
if (!requireNamespace("readr", quietly = TRUE)) {
  stop("Package 'readr' is required. Please install it with: install.packages('readr')")
}
if (!requireNamespace("jsonlite", quietly = TRUE)) {
  stop("Package 'jsonlite' is required. Please install it with: install.packages('jsonlite')")
}
if (!requireNamespace("reactable", quietly = TRUE)) {
  stop("Package 'reactable' is required. Please install it with: install.packages('reactable')")
}
if (!requireNamespace("htmltools", quietly = TRUE)) {
  stop("Package 'htmltools' is required. Please install it with: install.packages('htmltools')")
}
if (!requireNamespace("htmlwidgets", quietly = TRUE)) {
  stop("Package 'htmlwidgets' is required. Please install it with: install.packages('htmlwidgets')")
}

# Attach packages to search path
library(readr)
library(jsonlite)
library(reactable)
library(htmltools)
library(htmlwidgets)

#' Load CSV dataset and metadata
#'
#' @param csv_path Path to CSV file
#' @return List with 'data' (data.frame or NULL) and 'metadata' (list)
load_dataset <- function(csv_path) {
  meta_path <- sub("\\.csv$", ".meta.json", csv_path)

  # Load CSV if it exists
  data <- NULL
  if (file.exists(csv_path)) {
    data <- read_csv(csv_path, show_col_types = FALSE)
    # Replace NA with empty strings for consistency
    data[is.na(data)] <- ""
  }

  # Load metadata if it exists
  metadata <- list()
  if (file.exists(meta_path)) {
    metadata <- fromJSON(meta_path, simplifyVector = FALSE)
  }

  return(list(data = data, metadata = metadata))
}

#' Helper function for NULL coalescing
`%||%` <- function(x, y) if (is.null(x)) y else x

#' Render the ontology term table with reactable
#'
#' @param df Data frame with term data
#' @param theme_label Theme label for the table
#' @return reactable object
render_table <- function(df, theme_label = "") {
  if (is.null(df) || nrow(df) == 0) {
    return(NULL)
  }

  # Ensure all required columns exist (theme is handled by tabs, not displayed)
  required_cols <- c("term_name", "definition", "definition_source",
                     "related_terms", "canonical_uri", "widoco_link",
                     "definition_source_text", "definition_source_link")

  for (col in required_cols) {
    if (!col %in% names(df)) {
      df[[col]] <- ""
    }
  }

  # Replace NA with empty strings
  df[is.na(df)] <- ""

  # Create custom column definitions
  col_defs <- list(
    # Term Name
    term_name = colDef(
      name = "Term Name",
      minWidth = 100,
      resizable = TRUE
    ),

    # Definition - wider column
    definition = colDef(
      name = "Definition",
      minWidth = 300,
      resizable = TRUE
    ),

    # Definition Source - coalesced with preference: IRI/URL, then text citation
    definition_source = colDef(
      name = "Definition Source",
      minWidth = 200,
      resizable = TRUE,
      html = TRUE,
      cell = function(value, index) {
        row <- df[index, ]

        # Helper to clean and check if value is empty/invalid
        clean_value <- function(val) {
          if (is.null(val) || is.na(val) || val == "nan" || val == "none" || val == "") {
            return("")
          }
          return(as.character(val))
        }

        # Helper to check if value is a URL/IRI
        is_url_iri <- function(val) {
          val <- clean_value(val)
          if (val == "") return(FALSE)
          return(startsWith(val, "http://") || startsWith(val, "https://") ||
                 startsWith(val, "urn:") || startsWith(val, "doi:"))
        }

        # Helper to create link HTML
        make_link <- function(url) {
          return(HTML(paste0(
            '<a href="', htmlEscape(url, attribute = TRUE),
            '" target="_blank" rel="noopener" style="color: #446c8a;">',
            htmlEscape(url), '</a>'
          )))
        }

        source_link <- clean_value(row$definition_source_link)
        source_text <- clean_value(row$definition_source_text)
        source_raw <- clean_value(row$definition_source)

        # Preference: IRI/URL first (from source_link, then source_raw), then text citation
        if (is_url_iri(source_link)) {
          return(make_link(source_link))
        }
        if (is_url_iri(source_raw)) {
          return(make_link(source_raw))
        }

        # Fall back to text citation
        if (source_text != "") {
          return(HTML(htmlEscape(source_text)))
        }
        if (source_raw != "") {
          return(HTML(htmlEscape(source_raw)))
        }

        return(HTML('<span class="coming-soon">Not available</span>'))
      }
    ),

    # Related Terms - render as clickable links
    related_terms = colDef(
      name = "Related Terms",
      minWidth = 100,
      resizable = TRUE,
      html = TRUE,
      cell = function(value, index) {
        if (is.null(value) || is.na(value) || value == "" || value == "nan") {
          return(HTML('<span class="coming-soon">None</span>'))
        }

        # Parse related terms: format is "Term Name (relation) [URI]; Term Name2 (relation) [URI]"
        terms_str <- as.character(value)
        if (terms_str == "") {
          return(HTML('<span class="coming-soon">None</span>'))
        }

        # Split by semicolon to get individual terms
        term_parts <- strsplit(terms_str, "; ")[[1]]

        # Parse each term: "Term Name (relation) [URI]"
        links <- character(0)
        for (term_part in term_parts) {
          term_part <- trimws(term_part)
          if (term_part == "") next

          # Extract term name, relation, and URI using regex
          # Pattern: "Term Name (relation) [URI]"
          match <- regmatches(term_part, regexec("^(.+?)\\s+\\(([^)]+)\\)\\s+\\[(.+?)\\]$", term_part))[[1]]

          if (length(match) >= 4) {
            term_name <- match[2]
            relation <- match[3]
            uri <- match[4]

            # Create clickable link with data attributes
            link_html <- paste0(
              '<a href="#" ',
              'class="related-term-link" ',
              'data-term-name="', htmlEscape(term_name, attribute = TRUE), '" ',
              'data-term-uri="', htmlEscape(uri, attribute = TRUE), '" ',
              'style="color: #446c8a; text-decoration: none; margin-right: 0.5rem; display: inline-block;" ',
              'title="', htmlEscape(relation, attribute = TRUE), '">',
              htmlEscape(term_name),
              '</a>'
            )
            links <- c(links, link_html)
          } else {
            # Fallback: if parsing fails, just show the text
            links <- c(links, htmlEscape(term_part))
          }
        }

        if (length(links) == 0) {
          return(HTML('<span class="coming-soon">None</span>'))
        }

        return(HTML(paste(links, collapse = " ")))
      }
    ),

    # Term ID (formerly Canonical URI) - as hyperlink
    canonical_uri = colDef(
      name = "Term ID",
      minWidth = 200,
      resizable = TRUE,
      html = TRUE,
      cell = function(value, index) {
        if (is.null(value) || is.na(value) || value == "" || value == "nan") {
          return(HTML('<span class="coming-soon">Unavailable</span>'))
        }
        uri <- htmlEscape(value)
        return(HTML(paste0(
          '<a href="', htmlEscape(uri, attribute = TRUE),
          '" target="_blank" rel="noopener" style="color: #446c8a; font-family: monospace; font-size: 0.9em;">',
          uri, '</a>'
        )))
      }
    )
  )

  # Hide metadata columns that shouldn't be displayed
  col_defs$source_version <- colDef(show = FALSE)
  col_defs$source_timestamp <- colDef(show = FALSE)
  col_defs$query_checksum <- colDef(show = FALSE)
  col_defs$definition_source_text <- colDef(show = FALSE)
  col_defs$definition_source_link <- colDef(show = FALSE)
  col_defs$widoco_link <- colDef(show = FALSE)

  # Create reactable table
  # Use defaultColDef to ensure all columns are shown unless explicitly hidden
  table <- reactable(
    df,
    columns = col_defs,
    defaultColDef = colDef(
      minWidth = 100,
      resizable = TRUE,
      filterable = FALSE  # Disable filters under column headers
    ),
    resizable = TRUE,
    searchable = TRUE,
    filterable = FALSE,  # Disable global filtering
    defaultPageSize = 25,
    showPageSizeOptions = TRUE,
    pageSizeOptions = c(10, 25, 50, 100),
    theme = reactableTheme(
      headerStyle = list(
        backgroundColor = "#f8f9fa",
        borderBottom = "1px solid #dee2e6"
      ),
      stripedColor = "#f8f9fa"
    ),
    elementId = NULL  # unique widget IDs per panel
  )

  # Add CSS using onRender to avoid changing widget structure
  table <- htmlwidgets::onRender(
    table,
    HTML('
      function(el, x) {
        // Add CSS
        const style = document.createElement("style");
        style.textContent = `
          .coming-soon {
            color: #666;
            font-style: italic;
          }
        `;
        document.head.appendChild(style);
      }
    ')
  )

  # Return the table widget directly (not wrapped)
  return(table)
}
