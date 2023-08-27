#!/usr/bin/env bash

# 启动默认docker container命令： ./deploy_docker.sh
# 启动自定义docker container命令： ./deploy_docker.sh <your container name> <your export port>
# 需要自定义配置如下参数
# export oap_addr=???
# export container_mysql=???
# export mysql_user=???
# export mysql_pwd=???

# Docker container 命名
if [ -n "$1" ] ;then
  export docker_container_name=$1
else
  export docker_container_name=mallapi
fi

if [ -n "$2" ] ;then
  export export_port=$2
else
  export export_port=28019
fi

export docker_image_name="${docker_container_name}_img_${export_port}"

echo "Docker image: $docker_image_name"
echo "Docker container name : $docker_container_name"
echo "Docker container port: $export_port"

## Maven 编译
export pwd=`pwd`
rm -f mall.war
cd ..
mvn clean install -Dmaven.test.skip=true

## Maven 打包
mvn clean package spring-boot:repackage -Dmaven.test.skip=true -U

cp target/mall.war $pwd

## 停止/删除 现有的Docker container
docker stop $docker_container_name
docker rm $docker_container_name
docker rmi $docker_image_name

## 生成新的docker image
cd $pwd
pwd

# 配置 OAP IP地址
# 需要提前在环境变量中配置 oap_addr 变量 oap server ip 地址 *必须设置参数
export os_type=`uname`
if [[ "${os_type}" == "Darwin" ]]; then
    sed -i "" "s/oap_addr/$oap_addr/g" Dockerfile
else
    sed -i "s/oap_addr/$oap_addr/g" Dockerfile
fi

docker build -t $docker_image_name .

## 启动新的docker image 暴露端口 28019
## 需要事先启动mysql docker 容器，将其名称赋值给环境变量 container_mysql *必须设置参数
## 请在环境变量中配置如下信息：
## - mysql_user: mysql 数据库用户名 *必须设置参数
## - mysql_pwd: mysql 数据库密码 *必须设置参数
docker run -d --name $docker_container_name -p $export_port:28019 -p 8081:8081 --link $container_mysql:db \
  -e mysql_host=db -e mysql_port=3306 -e mysql_user=$mysql_user -e mysql_pwd=$mysql_pwd \
  -e server_port=28019 -e app_name=mallapi \
 $docker_image_name