FROM openjdk:11-jre-slim
EXPOSE 9010
RUN mkdir /app
COPY build/libs/*.jar /app/recovereds-0.0.1-SNAPSHOT.jar
ENV JAVA_OPTS="-XX:+UseContainerSupport -Djava.security.egd=file:/dev/./urandom"
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar /app/recovereds-0.0.1-SNAPSHOT.jar"]




