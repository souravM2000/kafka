# Use a base image with Java installed
FROM openjdk:11-jre-slim

# Install necessary tools
RUN apt-get update && \
    apt-get install -y wget netcat

# Set environment variables for Kafka and Zookeeper
ENV KAFKA_VERSION=3.8.0 \
    SCALA_VERSION=2.13 \
    KAFKA_HOME=/opt/kafka \
    ZOOKEEPER_PORT=2181 \
    KAFKA_PORT=9092

# Download and extract Kafka
RUN wget https://downloads.apache.org/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
    tar -xzf kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz && \
    mv kafka_${SCALA_VERSION}-${KAFKA_VERSION} ${KAFKA_HOME} && \
    rm kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz

# Copy configuration files
COPY server.properties ${KAFKA_HOME}/config/
COPY zookeeper.properties ${KAFKA_HOME}/config/

# Copy start script
COPY start-kafka-zookeeper.sh /usr/bin/

# Expose the necessary ports
EXPOSE 9092

# Start Kafka and Zookeeper
CMD ["start-kafka-zookeeper.sh"]
