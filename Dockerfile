FROM openjdk:17
COPY App.java .
RUN javac App.java
CMD ["java", "App"]

