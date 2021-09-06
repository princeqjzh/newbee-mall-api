#!/usr/bin/env bash

export docker_image_name=mallapi_img
export docker_container_name=mallapi

## Maven 编译
mvn clean install -Dmaven.test.skip=true

## Maven 打包
mvn clean package spring-boot:repackage -Dmaven.test.skip=true -U

## 停止/删除 现有的Docker container
docker stop $docker_container_name
docker rm $docker_container_name
docker rmi $docker_image_name

## 生成新的docker image
docker build -t $docker_image_name .

## 启动新的docker image 暴露端口 28019
## 需要事先启动mysql docker 容器，将其命名为prod_mysql
## 请在环境变量中配置如下信息：
## - mysql_port: mysql 数据库端口号
## - mysql_user: mysql 数据库用户名
## - mysql_pwd: mysql 数据库密码
docker run -d --name $docker_container_name -p 28019:28019 --link prod_mysql:db \
  -e mysql_host=db -e mysql_port=$mysql_port -e mysql_user=$mysql_user -e mysql_pwd=$mysql_pwd \
 $docker_image_name