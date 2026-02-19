suppressPackageStartupMessages(library(yaml))
`%||%` <- function(a, b) if (is.null(a) || is.na(a) || identical(a, "")) b else a

read_front_matter <- function(path) {
  lines <- readLines(path, warn = FALSE)
  if (length(lines) < 2 || lines[1] != "---") return(list())
  end <- which(lines[-1] == "---")
  if (!length(end)) return(list())
  tryCatch(yaml::yaml.load(paste(lines[2:end[1]], collapse = "\n")), error = function(...) list())
}

as_date_safe <- function(x) {
  if (is.null(x) || length(x) == 0) return(as.Date(NA))
  suppressWarnings(as.Date(as.character(x[1])))
}

first_non_na_date <- function(values) {
  for (v in values) {
    d <- as_date_safe(v)
    if (!is.na(d)) return(d)
  }
  as.Date(NA)
}

relative_path <- function(path, root = ".") {
  path_abs <- normalizePath(path, winslash = "/", mustWork = FALSE)
  root_abs <- normalizePath(root, winslash = "/", mustWork = FALSE)
  prefix <- paste0(root_abs, "/")
  if (startsWith(path_abs, prefix)) sub(prefix, "", path_abs, fixed = TRUE) else sub("^\\./", "", path)
}

run_git_lines <- function(args, root = ".") {
  old <- getwd(); on.exit(setwd(old), add = TRUE); setwd(root)
  out <- tryCatch(system2("git", args = args, stdout = TRUE, stderr = FALSE), error = function(e) character())
  out[nzchar(out)]
}

git_oldest_commit_date <- function(path, root = ".", first_add_only = FALSE) {
  rel <- relative_path(path, root)
  args <- c("log", if (first_add_only) "--diff-filter=A", "--follow", "--format=%aI", "--", rel)
  lines <- run_git_lines(args, root)
  if (!length(lines)) return(as.Date(NA))
  as_date_safe(tail(lines, 1))
}

git_latest_commit_date <- function(path, root = ".") {
  rel <- relative_path(path, root)
  lines <- run_git_lines(c("log", "--follow", "--format=%aI", "-n", "1", "--", rel), root)
  if (!length(lines)) return(as.Date(NA))
  as_date_safe(lines[1])
}

metadata_published_date <- function(meta) first_non_na_date(list(meta$published_date, meta$`published-date`, meta$date, meta$pubdate, meta$publish_date))
metadata_updated_date <- function(meta) first_non_na_date(list(meta$updated_date, meta$`updated-date`, meta$`date-modified`, meta$`last-modified`, meta$modified, meta$last_updated))

resolve_article_dates <- function(path, meta = NULL, root = ".") {
  if (is.null(meta)) meta <- read_front_matter(path)
  fi <- file.info(path)
  candidates <- list(metadata_published_date(meta), git_oldest_commit_date(path, root, TRUE), git_oldest_commit_date(path, root, FALSE), as.Date(fi$ctime), as.Date(fi$mtime))
  labels <- c("metadata", "git_first_add", "git_earliest_touch", "filesystem_ctime", "filesystem_mtime")
  published_date <- as.Date(NA); published_source <- "unknown"
  for (i in seq_along(candidates)) if (!is.na(candidates[[i]])) { published_date <- candidates[[i]]; published_source <- labels[[i]]; break }

  ucands <- list(metadata_updated_date(meta), git_latest_commit_date(path, root), as.Date(fi$mtime))
  ulabels <- c("metadata", "git_latest_touch", "filesystem_mtime")
  updated_date <- as.Date(NA); updated_source <- "unknown"
  for (i in seq_along(ucands)) if (!is.na(ucands[[i]])) { updated_date <- ucands[[i]]; updated_source <- ulabels[[i]]; break }

  list(published_date = published_date, updated_date = updated_date, published_source = published_source, updated_source = updated_source)
}

path_type <- function(path) {
  if (grepl("^how_to_guides/", path)) return("How-to")
  if (grepl("^reference_info/", path)) return("Reference")
  if (grepl("^tutorials/", path)) return("Tutorial")
  if (grepl("^deep_dives/", path)) return("Deep dive")
  if (grepl("^cookbook/", path)) return("Cookbook")
  if (grepl("^blog/", path)) return("News")
  "Guide"
}

read_time_min <- function(path) {
  txt <- paste(readLines(path, warn = FALSE), collapse = "\n")
  words <- strsplit(gsub("(?s)```.*?```", "", txt, perl = TRUE), "[[:space:]]+")[[1]]
  max(1, round(length(words[words != ""]) / 220))
}

collect_article_entries <- function(dirs = c("how_to_guides", "reference_info", "tutorials", "deep_dives", "cookbook", "blog"), root = ".") {
  files <- unlist(lapply(dirs, function(d) if (dir.exists(file.path(root, d))) list.files(file.path(root, d), pattern = "\\.qmd$", recursive = TRUE, full.names = TRUE) else character()))
  entries <- lapply(files, function(f) {
    rel <- relative_path(f, root)
    meta <- read_front_matter(f)
    d <- resolve_article_dates(f, meta, root)
    list(path = rel, href = gsub("\\.qmd$", ".html", rel), title = meta$title %||% tools::toTitleCase(gsub("-", " ", tools::file_path_sans_ext(basename(f)))), type = path_type(rel), published_date = d$published_date, updated_date = d$updated_date, published_source = d$published_source, updated_source = d$updated_source, read_time = read_time_min(f))
  })
  df <- do.call(rbind, lapply(entries, as.data.frame, stringsAsFactors = FALSE))
  df$published_date <- as.Date(df$published_date); df$updated_date <- as.Date(df$updated_date)
  df <- df[order(df$updated_date, df$published_date, decreasing = TRUE), ]
  rownames(df) <- NULL
  df
}
