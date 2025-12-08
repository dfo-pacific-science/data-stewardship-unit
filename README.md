# FADS Documentation Hub Site

This website serves as a resource for Fisheries and Oceans Canada employees working in the Pacific Region Science Branch, providing support for their data stewardship and management responsibilities.

## Project Structure

This repository has some the following files and directories of note:

- `_quarto.yml`: The configuration file for the Quarto package.
- `index.qmd`: The home page of the website.
- `images/`: holds logos and images for the site 
- `README.md`: Documentation for the project.
- `CONTRIBUTING.md`: Instructions for contributing to the website. 
- `.github`: Files for Github Actions workflows

## Getting Started

To run the website locally, follow these steps in the terminal:

> Tip: If you use Nix/devenv, run `devenv shell` to get the pinned toolchain (R, Python, Quarto, Node) without extra local installs.

1. Clone the repository with git by running `git clone https://github.com/dfo-pacific-science/data-stewardship-unit.git` in terminal. 
2. Install Quarto: `R -e "install.packages('quarto')"` or follow [Quarto installation instructions](https://quarto.org/docs/get-started/)
3. Install required R packages: `R -e "install.packages(c('reactable', 'readr', 'jsonlite', 'htmltools', 'htmlwidgets', 'yaml'))"`
4. Set up pre-commit hooks (optional but recommended): 
   - Install pre-commit: `pip install pre-commit` or `brew install pre-commit`
   - Install hooks: `pre-commit install`
5. Preview the website by running `quarto preview` or build with `quarto render`
6. To publish the site, merge commits to the main branch. For information on publishing, refer to the contribution information below.

**Note:** The website must be built locally. CSV validation happens automatically via pre-commit hooks before commits. GitHub Actions only renders and publishes the Quarto website.

## Ontology term tables workflow

- Generate term tables in the sibling `dfo-salmon-ontology` repo (uses draft themes; `USE_DRAFT_THEMES=true python scripts/extract-term-tables.py` or `make publish-and-extract` there).
- Sync outputs into this repo from the ontology repo using `scripts/sync_term_tables_to_dsu.sh` (run in the ontology repo, pointing to this repo’s `data/ontology` path).
- This repo does **not** regenerate tables; pre-commit here only validates the CSV/meta files already synced.
- To run validation manually here: `nix run nixpkgs#pre-commit -- run --all-files` inside `devenv shell`.

## Contributing

If you would like to contribute to this project, please follow the guidelines in [CONTRIBUTING.md](CONTRIBUTING.md).

## License

This project is licensed under the [CC BY 4.0 License](https://creativecommons.org/licenses/by/4.0/).
