
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
2. 通过sql语句 newbee_mall_db_v2_schema.sql， 导入mysql基础数据
3. 在application.properties中配置数据库的IP, 端口, 用户名, 密码

## 编译命令
mvn clean install

## 启动命令
mvn spring-boot:run