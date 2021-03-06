############################
### Base for build image ###
############################
FROM maven:latest AS build

MAINTAINER Felix Klauke <info@felix-klauke.de>

######################
### Copy all files ###
######################
COPY . .

################
### Build it ###
################
RUN mvn clean install package

########################
### Base for runtime ###
########################
FROM openjdk:8 AS runtime

WORKDIR /opt/app

COPY --from=build target/cardea-server.jar /opt/app/server.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "server.jar" ]

