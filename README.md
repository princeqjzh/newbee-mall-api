
##简介

newbee-mall 项目是一套电商系统，基于 Spring Boot 2.X 和 Vue 以及相关技术栈开发。前台商城系统包含首页门户、商品分类、新品上线、首页轮播、商品推荐、商品搜索、商品展示、购物车、订单结算、订单流程、个人订单管理、会员中心、帮助中心等模块。 后台管理系统包含数据面板、轮播图管理、商品管理、订单管理、会员管理、分类管理、设置等模块。

本仓库中的源码为新蜂商城前后端分离版本的后端 API 项目，技术栈为 Spring Boot，主要面向服务端开发人员

原始工程位置： https://github.com/newbee-ltd/newbee-mall-api

## 项目运行环境
- MySQL
- Java
- Maven

## 配置内容
1. 创建数据库 newbee_mall_db_v2
2. 通过sql语句 newbee_mall_init.sql， 导入mysql基础数据
3. 数据库配置方法
    - 直接改代码方式：在application.properties中配置数据库的IP, 端口, 用户名, 密码
    - 环境变量方式， 请在环境变量中配置如下参数：
         - mysql_host: mysql 数据库hostname 或者 IP
         - mysql_port: mysql 数据库端口号
         - mysql_user: mysql 数据库用户名
         - mysql_port: mysql 数据库密码
         - server_port: 服务运行端口
         - app_name: 服务名称
            
    
## 编译命令
mvn clean install

## 启动命令
mvn spring-boot:run

## Swagger接口文档
http://localhost:<server_port>/swagger-ui.html

## Docker 部署
- 依赖条件：需要在相同的宿主机上启动MySQL的Docker容器，并将其命名为prod_mysql，启动命令参考如下：
  docker run -d --name prod_mysql -v /<your path>/.mysql_prod:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 -p 3306:3306 mysql:latest
  
- 将基础数据通过 newbee_mall_init.sql 导入mysql数据库
  
- 在Docker宿主机配置如下环境变量：
  - mysql_user: mysql 数据库用户名
  - mysql_pwd: mysql 数据库密码
   
- Docker 镜像生成与启动脚本： deploy_docker.sh