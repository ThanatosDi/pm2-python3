#!/usr/bin/env bash

#### halt script on error
set -xe

echo '##### Print docker version'
docker --version

echo '##### Print environment'
env | sort

#### Build the Docker Images
cp .env.example .env
sed -i -- "s/APP_CODE_PATH_HOST=..\//APP_CODE_PATH_HOST=.\//g" .env
sed -i -- "s/INSTALL_PM2=false/INSTALL_PM2=true/g" .env

cat .env
docker-compose build app
docker images
