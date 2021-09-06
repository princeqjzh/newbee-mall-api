FROM frolvlad/alpine-java:jdk8-slim
MAINTAINER Michael
ENV TZ "Asia/Shanghai"
ENV LANG C.UTF-8
VOLUME /tmp

WORKDIR /app
ADD target/mall.war .
RUN jar -xvf mall.war

WORKDIR /app/WEB-INF
ENV JAVA_OPTS "-Xms256m -Xmx1024m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=512m"

ENTRYPOINT java -cp /app $JAVA_OPTS org.springframework.boot.loader.WarLauncher

EXPOSE 28019

