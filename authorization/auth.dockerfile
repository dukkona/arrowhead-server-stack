# Alpine Linux with OpenJDK JRE
FROM openjdk:8-jre-alpine
# copy WAR into image
COPY ./target/ /arrowhead/authorization/
#COPY /var/jenkins home/workspace/test/authorization/target/authorization-4.0.jar /
# run application with this command line 
