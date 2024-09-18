#!/bin/bash
export $(cat .env | xargs)

if [ ! -d "./mounts/$PROJECT_NAME" ]; then
    mkdir ./mounts/$PROJECT_NAME
    cp -r project_template/* ./mounts/$PROJECT_NAME/
fi

docker run -d \
    -u root \
    --name $PROJECT_NAME \
    -p 8888:8888 \
    -v ./mounts/$PROJECT_NAME:/home/$NB_USER/working/project \
    -e NB_USER=$NB_USER \
    -e NB_GROUP=staff \
    -e CHOWN_HOME=yes \
    -e CHOWN_HOME_OPTS='-R' \
    -e GRANT_SUDO=yes \
    scaffold:latest