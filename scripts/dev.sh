#!/bin/bash
# This assumes it's being ran from the project's root.
# I.e. not from the scripts directory, run as sh scripts/dev.sh

export $(cat .env | xargs)

docker build \
    --build-arg PROJECT_NAME=$PROJECT_NAME \
    --build-arg NB_USER=$NB_USER \
    --build-arg DEV_MODE=T \
    --build-arg PANDOC_VERSION=3.5.0 \
    --no-cache \
    -t scaffold:latest \
    .

if [ "$(docker ps -aq -f name=$PROJECT_NAME)" ]; then
    docker stop $PROJECT_NAME
    docker rm $PROJECT_NAME
fi

if [ -d "./mounts/$PROJECT_NAME" ]; then
    rm -rf ./mounts/$PROJECT_NAME
    mkdir ./mounts/$PROJECT_NAME
    cp -r project_template/* ./mounts/$PROJECT_NAME/
    cp .gitconfig ./mounts/$PROJECT_NAME/.gitconfig
    cd ./mounts/$PROJECT_NAME
    git init --initial-branch=main
    cd ../..
fi

docker run -d \
    -u root \
    --name $PROJECT_NAME \
    -p 8888:8888 \
    -v ./mounts/$PROJECT_NAME:/home/$NB_USER/working/$PROJECT_NAME \
    -e NB_USER=$NB_USER \
    -e NB_GROUP=staff \
    -e CHOWN_HOME=yes \
    -e CHOWN_HOME_OPTS='-R' \
    -e GRANT_SUDO=yes \
    -e JUPYTER_DOCKER_STACKS_QUIET \
    scaffold:latest

sleep 1

docker exec -it --user $NB_USER -w /home/$NB_USER/working $PROJECT_NAME /bin/zsh