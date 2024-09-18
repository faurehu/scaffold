FROM glcr.b-data.ch/jupyterlab/r/verse

USER root

ARG NB_USER
ENV NB_USER=${NB_USER}

ARG DEV_MODE
ENV DEV_MODE=${DEV_MODE}

ARG PROJECT_NAME
ENV PROJECT_NAME=${PROJECT_NAME}

COPY . /home/$NB_USER/working
WORKDIR /home/$NB_USER/working

COPY .gitconfig /home/$NB_USER/.gitconfig

RUN mv bin/* /usr/local/bin && \
    mv ./.zshrc ../.zshrc && \
    rm -rf bin

RUN if [ -z "$DEV_MODE" ]; then \
    R -e "install.packages(c( \
        'fixest', \
        'lmtest', \
        'marginaleffects', \
        'patchwork', \
        'reshape2', \
        'sandwich', \
        'stargazer', \
        'simstudy'))"; \
    fi

USER $NB_USER

ENV ZSH_DISABLE_COMPFIX="true"
ENV HOME=/home/$NB_USER