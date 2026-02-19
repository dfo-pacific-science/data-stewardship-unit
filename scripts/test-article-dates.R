source("scripts/article_dates.R")
assert_true <- function(x, msg) if (!isTRUE(x)) stop(msg, call. = FALSE)

git <- function(args, wd, env = character()) {
  old <- getwd(); on.exit(setwd(old), add = TRUE); setwd(wd)
  res <- system2("git", args = args, stdout = TRUE, stderr = TRUE, env = env)
  if (!is.null(attr(res, "status")) && attr(res, "status") != 0) stop(paste(res, collapse = "\n"), call. = FALSE)
}

td <- tempfile("article-dates-test-"); dir.create(td, recursive = TRUE)
git(c("init"), td); git(c("config","user.email","test@example.com"), td); git(c("config","user.name","Test"), td)
dir.create(file.path(td, "how_to_guides"), recursive = TRUE)

f_meta <- file.path(td, "how_to_guides", "has-meta.qmd")
writeLines(c("---","title: Meta Date","date: 2024-01-02","---","# Meta"), f_meta)
git(c("add","."), td); git(c("commit","-m","add-meta"), td, env=c("GIT_AUTHOR_DATE=2024-05-01T00:00:00Z","GIT_COMMITTER_DATE=2024-05-01T00:00:00Z"))
d_meta <- resolve_article_dates(f_meta, root = td)
assert_true(as.character(d_meta$published_date)=="2024-01-02", "metadata date should win")

f_git <- file.path(td, "how_to_guides", "git-only.qmd")
writeLines(c("---","title: Git Date","---","first"), f_git)
git(c("add","."), td); git(c("commit","-m","add-git"), td, env=c("GIT_AUTHOR_DATE=2023-01-10T00:00:00Z","GIT_COMMITTER_DATE=2023-01-10T00:00:00Z"))
writeLines(c("---","title: Git Date","---","first","second"), f_git)
git(c("add","."), td); git(c("commit","-m","update-git"), td, env=c("GIT_AUTHOR_DATE=2025-01-10T00:00:00Z","GIT_COMMITTER_DATE=2025-01-10T00:00:00Z"))

d_git <- resolve_article_dates(f_git, root = td)
assert_true(as.character(d_git$published_date)=="2023-01-10", "git first add should be used")
assert_true(as.character(d_git$updated_date)=="2025-01-10", "updated should be latest git touch")

entries <- collect_article_entries(dirs=c("how_to_guides"), root=td)
assert_true(entries$title[1]=="Git Date", "ordering should prioritize updated desc")
cat("All article date tests passed.\n")
