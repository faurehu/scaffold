#!/bin/bash
export $(cat .env | xargs)
docker exec -it --user $NB_USER -w /home/$NB_USER/working $PROJECT_NAME /bin/zsh