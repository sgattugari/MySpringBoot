FROM openjdk:8-alpine
ADD target/lab-spring-boot-0.1.0.jar app.jar
RUN sh -c 'touch /app.jar'
ENV JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -jar"
ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS /app.jar" ]
