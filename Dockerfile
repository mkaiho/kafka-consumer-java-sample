FROM openjdk:13-buster AS builder 

WORKDIR /home/app/kafka-consumer-java-sample

COPY gradle gradle
COPY settings.gradle settings.gradle
COPY gradlew gradlew
COPY build.gradle build.gradle
COPY src src

RUN ./gradlew build

FROM openjdk:13-slim-buster

WORKDIR /home/app/kafka-consumer-java-sample

COPY --from=builder \
  /home/app/kafka-consumer-java-sample/build/libs/kafka-consumer-java-sample-0.0.1-SNAPSHOT.jar \
  /home/app/kafka-consumer-java-sample/build/libs/kafka-consumer-java-sample-0.0.1-SNAPSHOT.jar

CMD ["java", "-jar", "./build/libs/kafka-consumer-java-sample-0.0.1-SNAPSHOT.jar"]