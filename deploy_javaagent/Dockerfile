FROM frolvlad/alpine-java:jdk8-slim
MAINTAINER Michael
ENV TZ "Asia/Shanghai"
ENV LANG C.UTF-8
VOLUME /tmp

WORKDIR /app
ADD mall.war .
RUN jar -xvf mall.war

WORKDIR /app/WEB-INF
ENV JAVA_OPTS "-Xms256m -Xmx1024m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=512m -javaagent:jmx_prometheus_javaagent-0.16.1.jar=8081:config.yaml"
COPY config.yaml config.yaml
COPY jmx_prometheus_javaagent-0.16.1.jar jmx_prometheus_javaagent-0.16.1.jar

ENTRYPOINT java -cp /app $JAVA_OPTS org.springframework.boot.loader.WarLauncher

EXPOSE 28019 8081 1234

