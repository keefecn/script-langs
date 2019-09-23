#!/bin/bash
# 创建数据目录，把当前目录的拥有者赋值给uid 1000
# 启动Jenkins容器 docker-compose up -d
mkdir ./data
chown -R 1000:1000 ./data