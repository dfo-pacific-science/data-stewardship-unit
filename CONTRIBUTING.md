Welcome contributors to the DSU website! 
This document contains detailed instructions on working with the quarto repo and using Github Actions to the publish the site. 

# Requirements 
You must have a Github account and [Git](https://git-scm.com/) downloaded on your machine to make changes to this repository. 

# Cloning and Adding a Branch

In order to make changes to the site, you must clone the repository and create a branch. 

1. Clone the repository with git by running `git clone https://github.com/dfo-pacific-science/data-stewardship-unit.git` in terminal. 
2. Install the required dependencies: `R -e "install.packages('quarto')"`
3. Make a new branch using `git branch new-branch-name`. Please name the branch descriptively. 
3. Make your changes to the website and preview them by running `quarto render`. Each time any file is changed, you will need to run `quarto render` to see the changes locally.

# Contributing

You may push your changes via the new branch. After pushing, you may make a pull request to merge the branch to main. Merguing to main will save your changes to the website and trigger a deployment via github actions. Deployment instructions are located in the .github/workflows/publish.yml file.

Another team member review your pull request with site changes. They should render the changes on their local machine with `quarto render`. 

Check the deployment status after merging the new branch to main by looking at the Actions tab in Github. If succesful, a green checkmark will appear. It may take up to a few moments for the changes to be reflected on the site. 


# Resources
- [Quarto Website Documentation](https://quarto.org/docs/websites/)
- [Github Pages](https://quarto.org/docs/publishing/github-pages.html)
- [Rendering for CI](https://quarto.org/docs/publishing/ci.html#rendering-for-ci)
