# Step 1: Use a Maven image to build the application
FROM maven:3.8.7-eclipse-temurin-17 AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the Maven configuration files and the source code into the container
COPY pom.xml .
COPY src ./src

# Run Maven to build the application
RUN mvn clean package -DskipTests

# Step 2: Use a lightweight Java image for running the application
FROM eclipse-temurin:17-jre-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the application's port (change as per your application)
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "app.jar"]

