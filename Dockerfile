FROM openjdk:8
COPY .mvn /usr/src/demo/.mvn
COPY pom.xml mvnw* /usr/src/demo/
WORKDIR /usr/src/demo
RUN bash ./mvnw -q org.apache.maven.plugins:maven-dependency-plugin:3.0.0:resolve-plugins org.apache.maven.plugins:maven-dependency-plugin:3.0.0:go-offline
COPY . /usr/src/demo/
RUN bash ./mvnw package -Dmaven.test.skip=true

FROM openjdk:8
WORKDIR /root
COPY --from=0 /usr/src/demo/target/*.jar app.jar
CMD ["java", "-jar", "app.jar"]
