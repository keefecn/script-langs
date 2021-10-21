#!/bin/bash

# hello-world
docker run  hello-world

# mysql
docker run --name keefe-mysql -p 3306:3306 -e  MYSQL_ROOT_PASSWORD=123456 -d mysql:latest

# redis
docker run --name keefe-redis -p 6379:6379 -v  /home/ai/docker/data:/data -d redis:3.2  redis-server --appendonly yes

# nginx
docker run --name keefe-nginx -p 8081:80 -d nginx

# tomcat
docker run --name keefe-tomcat -p 8080:8080 -d nginx
