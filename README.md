# Goals

# Quick start

- Copy the `.env.sample` file to `.env` and modify the values in it.
- `sh scripts/build_image.sh`
- `sh scripts/new_project.sh`
- `sh scripts/attach_project.sh`

# Project configuration

Here are a few things you might want to do everytime you start a new project:
- Copy the `.env.sample` file to `.env` and modify the values in it.
- Run `p10k configure` from an attached container to set up your terminal and ensure it uses the appropriate fonts.

# Features

## Pandoc

You can use `sh ./scripts/pandoc.sh sample_memo` to see how the files in `$PROJECT_NAME/markdown/sample_memo` produce `sample_memo.pdf` in `$PROJECT_NAME/pdf`, but first, make sure to run the R code in `$PROJECT_NAME/R/sample_save.R` to produce the assets. Notice that there is a macro `\insertfigure` which only needs the name of the figure in `$PROJECT_NAME/assets/figures`. Similarly, `\input` will find your `.tex` tables in `$PROJECT_NAME/assets/tables`.

There is also `sh ./scripts/beamer.sh` and a corresponding sample directory. Unfortunately, pandoc's `--include-before-body` is not working so for now it does not have the same nice features as the memo template.

## HPC

After loading the container to the HPC, you can use `scripts/run_task.sh` to queue a R file onto the HPC. This will execute the code in `task.s` which, in turn, is fitted to start the R code of your choice. Look up SLURM docs to learn how to configure the batch so that it runs up to 100 processes in parallel.

# Development

Call `sh scripts/dev.sh` to quickly start a fresh new container with the image and see the changes made in Dockerfile or other configuration files.

## Adding new custom R functions

All custom R code is in `utils/Rcustom/R`. These functions are loaded when R starts, as per `.Rprofile`. Also on `utils/Rcustom/R` are functions that are called when R starts, such as `.onLoad` and `.onAttach`. Use `.onAttach` to set global variables.

## Adding dependencies

You need to add dependencies in two different places. First, in the `Dockerfile` so that the image installs these packages when building. Then, add it to the custom package's declared dependencies so that the libraries are loaded when R starts. Do so by editing the `utils/Rcustom/R/DESCRIPTION` file.

## Version control

There are two repository configurations in this directory. The first one corresponds to the scaffold project, which manages the reusable code and configurations for each new project. The second git repository is for each new project that is instantiated. Hence, be mindful of what changes you are staging and committing and to which repository.

When making changes to the scaffold project, use git from the root directory. If you do it from another directory there is a chance you will be making changes to the vanilla repository.

Containers do not have a reference to the scaffold repository, so it is safe to use git from any directory. You can call git from the attached shell of a docker container in the `/home/$NB_USER/working/$PROJECT_NAME` directory.

## Project roadmap

- Survey generation: https://docs.expectedparrot.com/en/latest/overview.html
- Global settings and themes for ggplot and stargazer
- Move home directory to project?
    - Would alter R and pandoc script paths but make more sense
- Jupyter notebooks
- tidymodels: https://www.tidymodels.org/start/recipes/
- VSCode settings and extensions
    - R
    - Keyboard shortcuts
- Linters
    - textlint https://textlint.github.io/docs/getting-started.html