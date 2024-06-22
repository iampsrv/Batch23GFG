# Stage 1: Build the application using the official Maven Docker image
FROM maven:3.8.4-openjdk-17-slim AS build
WORKDIR /app
# Copy the Maven project files into the image
COPY pom.xml .
COPY src ./src
# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Create the final Docker image using a slim Java runtime
FROM openjdk:17.0.1-jdk-slim
WORKDIR /app
# Copy the JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]
