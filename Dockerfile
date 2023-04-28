#FROM openjdk:11-jre-slim
#EXPOSE 9010
#RUN mkdir /app
#COPY build/libs/*.jar /app/recovereds-0.0.1-SNAPSHOT.jar
#ENV JAVA_OPTS="-XX:+UseContainerSupport -Djava.security.egd=file:/dev/./urandom"
#ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar /app/recovereds-0.0.1-SNAPSHOT.jar"]


FROM openjdk:11-jdk-slim AS build
COPY --chown=gradle:gradle . /app/src
WORKDIR /app/src
RUN ./gradlew clean build --no-daemon -i

FROM openjdk:11-jre-slim

EXPOSE 8080

RUN mkdir /app

COPY --from=build /app/src/build/libs/*.jar /app/app.jar

ENTRYPOINT ["java", "-XX:+UnlockExperimentalVMOptions", "-XX:+UseCGroupMemoryLimitForHeap", "-Djava.security.egd=file:/dev/./urandom","-jar","/app/app.jar"]



