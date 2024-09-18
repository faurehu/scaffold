#!/bin/bash
export $(cat .env | xargs)
docker build --build-arg NB_USER=$NB_USER --no-cache -t scaffold:latest .