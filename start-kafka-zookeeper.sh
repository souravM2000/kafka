#!/bin/bash

# Start Zookeeper
$KAFKA_HOME/bin/zookeeper-server-start.sh $KAFKA_HOME/config/zookeeper.properties &

# Wait for Zookeeper to start
while ! nc -z localhost 2181; do
  sleep 1
done

# Start Kafka
$KAFKA_HOME/bin/kafka-server-start.sh $KAFKA_HOME/config/server.properties
