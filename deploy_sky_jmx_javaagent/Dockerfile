FROM frolvlad/alpine-java:jdk8-slim
MAINTAINER Michael
ENV TZ "Asia/Shanghai"
ENV LANG C.UTF-8
VOLUME /tmp

WORKDIR /app
ADD mall.war .
COPY skywalking-agent skywalking-agent
RUN jar -xvf mall.war

WORKDIR /app/WEB-INF
COPY config.yaml config.yaml
COPY jmx_prometheus_javaagent-0.16.1.jar jmx_prometheus_javaagent-0.16.1.jar
ENV JAVA_OPTS "-Xms256m -Xmx1024m -XX:MetaspaceSize=128m -XX:MaxMetaspaceSize=512m \
     -javaagent:/app/skywalking-agent/skywalking-agent.jar \
     -javaagent:jmx_prometheus_javaagent-0.16.1.jar=8081:config.yaml \
     -Dskywalking.agent.service_name=mallskywalking -Dskywalking.collector.backend_service=oap_addr:11800"

ENTRYPOINT java -cp /app $JAVA_OPTS org.springframework.boot.loader.WarLauncher

EXPOSE 28019 8081

