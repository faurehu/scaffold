!include-header ./${PROJECT_NAME}/markdown/${PANDOC_FOLDER}/header.yaml

\graphicspath{{./${PROJECT_NAME}/assets/figures/}}

\makeatletter
\def\input@path{{./${PROJECT_NAME}/assets/tables/}}
\makeatother

!include ./${PROJECT_NAME}/markdown/${PANDOC_FOLDER}/body.md
