FROM maven:3.6-jdk-11-slim as build
WORKDIR /home/app

COPY pom.xml /home/app
RUN mvn dependency:resolve
COPY src /home/app/src
RUN mvn -f /home/app/pom.xml package


FROM openjdk:11
COPY --from=build /home/app/target/camel-master-k8s-1.0-SNAPSHOT.jar /usr/local/lib/app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/app.jar"]