{ pkgs, ... }:

{
  # ---------------------------
  # Python env: core tools
  # ---------------------------
  languages.python = {
    enable = true;
    package = pkgs.python3;
    venv = {
      enable = true;
      requirements = ''
        pandas
        rdflib
        pre-commit
      '';
    };
  };

  # ---------------------------
  # R env: core packages
  # (project-specific / long-tail via renv)
  # ---------------------------
  languages.r = {
    enable = true;
  };

  # ---------------------------
  # CLI tools available in shell
  # ---------------------------
  packages = with pkgs; [
    git
    quarto
    gh
    jq
    nodejs_22
    # R wrapper with core packages
    (rWrapper.override {
      packages = with rPackages; [
        readr
        jsonlite
        yaml
        dplyr
        tidyr
        tibble
        purrr
      ];
    })
  ];

  # ---------------------------
  # Environment variables
  # ---------------------------
  env = {
    # Set R library path if needed
    R_LIBS_USER = "$DEVENV_PROFILE/lib/R/library";
  };

  # ---------------------------
  # Shell hook
  # ---------------------------
  enterShell = ''
    echo "Data Stewardship Unit Development Environment"
    echo "==========================================="
    echo "R version: $(R --version | head -n 1)"
    echo "Quarto version: $(quarto --version)"
    echo "Python version: $(python --version)"
    echo "Node version: $(node --version)"
    echo ""
    echo "R core packages from Nix:"
    echo "  - readr, jsonlite, yaml, dplyr, tidyr, tibble, purrr"
    echo ""
    echo "For project-specific / long-tail R packages, use {renv}:"
    echo "  - In R: renv::init()      # once per project"
    echo "  - Then: renv::restore()   # on new machines"
    echo ""
    echo "To set up pre-commit hooks:"
    echo "  pre-commit install"
    echo ""
    echo "To preview the Quarto site:"
    echo "  quarto preview"
    echo ""
  '';

}
