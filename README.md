# Goals

This is a Docker image which makes any code easily reproducible in any machine with Docker installed. It contains many utility functions I use regularly and makes organizing results and producing presentations seamless.

# Features

## R development

The image build has all the packages I need in my projects. It also contains a custom made R package containing common functions. R is also set up with custom configurations such that it automatically loads the project's default data files.

## Scripts

There are many shell scripts made to deal with common tasks such as rendering LaTeX documents.

## Logseq

Logseq is a notetaking application and every project comes with fresh directory to start taking notes in a clean context. It also contains useful templates that provide guiding questions for when starting a new research project.

To take further advantage of this application, learn how to use outliners with [this small tutorial](https://www.youtube.com/watch?v=O413tVCseio) I made.

## Pandoc

You can use `sh ./scripts/pandoc.sh sample_memo` to see how the files in `$PROJECT_NAME/markdown/sample_memo` produce `sample_memo.pdf` in `$PROJECT_NAME/pdf`, but first, make sure to run the R code in `$PROJECT_NAME/R/sample_save.R` to produce the assets. Notice that there is a macro `\insertfigure` which only needs the name of the figure in `$PROJECT_NAME/assets/figures`. Similarly, `\input` will find your `.tex` tables in `$PROJECT_NAME/assets/tables`.

There is also `sh ./scripts/beamer.sh` and a corresponding sample directory. Unfortunately, pandoc's `--include-before-body` is not working so for now it does not have the same nice features as the memo template.

## HPC

After loading the container to the HPC, you can use `scripts/run_task.sh` to queue a R file onto the HPC. This will execute the code in `task.s` which, in turn, is fitted to start the R code of your choice. Look up SLURM docs to learn how to configure the batch so that it runs up to 100 processes in parallel.

## Base container features

This image is built on top of b-data's [jupyterlab-r-docker-stack](https://github.com/b-data/jupyterlab-r-docker-stack/tree/main), hence it also has other features such as launching jupyter and vscode servers which can be accessed to from the browser. This makes it easier to work on a given project from any computer even if they don't have one's preferred text editors and developer tools. The vscode server can also be attached to with a local vscode and it will have specified extensions installed.

# Quick start

If you are not familiar with Docker, just know that Docker is a virtual machine that abstracts all of the operative system's quirks. There are three main tasks that you will need to do when referring to Docker. First, make sure that you have cloned the repository onto your own computer and that you have Docker running. Also, make sure to copy the `.env.sample` file to `.env` and modify the values in it.

## Build

The Docker image needs to be built. This will instruct Docker to follow the instructions on the Dockerfile and then freeze this virtual computer in a given state, it then turns this virtual computer off.

You can call `sh scripts/build_image.sh` to build the image and it should take about 10 minutes.

## Run

When you are done building a Docker image, there is no virtual computer running in the background. You now need to start a new project.

You can call `sh scripts/new_project.sh` to launch a new project.

This will create a new project and leave the computer running in the background. This means that it will be consuming your computer's resources even if you are not using it. To stop (restart) it you can call `docker stop (start) $PROJECT_NAME`.

Notice that a directory in the `mounts` directory has been created. This directory is synchronized between the container and your local computer, so you can use your text editor to make changes to the directory files with your text editor. Do not try to run the code in it in your local environment though, the necessary programs and packages are installed in the container.

## Attach

If the container is running you can now execute code in it. There are two main ways you can do this: you can either use the terminal (e.g. iTerm) or attach VSCode.

### Terminal

Call `sh scripts/attach_project.sh` and the terminal will enter the `/home/$NB_USER/workings` directory of the container. It is important that you call R from here so that all the boilerplate code works.

### VSCode

First, update your VSCode's settings by pressing "Cmd + `" and then searching for the "Docker > Commands: Attach" option (use the search bar). Open the json file and change the command to:

```
${containerCommand} exec -it --user {{USERNAME}} -w /home/{{USERNAME}}/working ${containerId} /bin/zsh
```

Make sure that you replace `{{USERNAME}}` with the `NB_USER` value in your `.env` file.

Then, you can use VSCode's command palette (`Cmd + Shift + p`) to find the attach command. Alternatively, you can find the container on the Docker view in the sidebar and right click on it to find the option to attach.

## R

When you launch R, it will automatically:
1. Load data:
    - it checks for `custom_workspace.RData` and loads if it exists. 
    - it also checks for csv files in `assets/data/project/` to load into the `df` or `df_list` variables.
2. Set global variables (e.g. `data_path`).
3. Load custom package functions. These are all in `utils/Rcustom/R`.

It will also automatically save the session in `custom_workspace.RData` before terminating.

## Project configuration

Here are a few things you might want to do everytime you start a new project:
- Copy the `.env.sample` file to `.env` and modify the values in it.
- Run `p10k configure` from an attached container to set up your terminal and ensure it uses the appropriate fonts.

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