#!/bin/bash

cd /docker-webserver/
docker-compose -f webserver.yml -f mariadb.yml -f mongodb.yml down
docker-compose -f webserver.yml -f mariadb.yml -f mongodb.yml up -d
docker ps