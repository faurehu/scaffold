# Goals

# Quick start

- Copy the `.env.sample` file to `.env` and modify the values in it.
- `sh scripts/build_image.sh`
- `sh scripts/new_project.sh`
- `sh scripts/attach_project.sh`

# Development

`sh scripts/dev.sh`

## Adding new custom R functions

All custom R code is in `utils/Rcustom/R`. These functions are loaded when R starts, as per `.Rprofile`. Also on `utils/Rcustom/R` are functions that are called when R starts, such as `.onLoad` and `.onAttach`. Use `.onAttach` to set global variables.

## Adding dependencies

You need to add dependencies in two different places. First, in the `Dockerfile` so that the image installs these packages when building. Then, add it to the custom package's declared dependencies so that the libraries are loaded when R starts. Do so by editing the `utils/Rcustom/R/DESCRIPTION` file.

## Adding data

Data that is private and is relevant to the project goes to the `/$PROJECT_NAME/assets/data/project` subdirectory and everything else is in the directories in `/assets/project_template/data`. This way, everything that is added to `/assets/project_template/data` will be available to all new containers. On the other hand, data in the `/$PROJECT_NAME/assets/data/project` folder will not be accessible to future projects.

`project_template/assets/data/Description.md` should describe the files. It is very important that there is a reference to find information about source, timespan and variables.

## Project roadmap

- Prepare LaTeX documents
- Zotero
    - Cite papers from directory?
    - Bibtex? How to build it?
    - Paper management
    - https://forums.zotero.org/discussion/comment/461489#Comment_461489
    - https://www.zotero.org/support/attaching_files
- HPC
- Simulated data
- Power analysis
- Survey generation
- R functions for exporting graphs and tables.
- ggplot colors
- textlint https://textlint.github.io/docs/getting-started.html
- Include EDSL
- Implement tidymodels https://www.tidymodels.org/start/recipes/
- Try edsl https://docs.expectedparrot.com/en/latest/overview.html
- VSCode settings and extensions
    - R
    - Keyboard shortcuts
- Add LLM prompting (langflow, etc)
    - Pre-install python and packages
- Linters