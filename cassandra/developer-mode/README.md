# cassandra dev-mode

## Overview
Uses a docker compose file and instructions borrowed from https://hub.docker.com/_/cassandra with minor tweaks to the naming to start a single
 containerized cassandra server instance
 
This is only suitable for development
  
 <br>
 <br>
 
## Instructions
 
#### Start the server
Navigate to the directory with the compose file and run:  
`docker-compose up -d`

This will start the containers based on the compose file configuration in detached mode.
  
 
#### Open a new shell and monitor all running docker containers (Optional)
open a new shell and run:  
`watch --interval 5 docker ps`

Monitor logs from the container with:  
`docker-compose logs -f` exit with ctrl+c


#### Connect to Cassandra with cqlsh (Cassandra Query Language Shell)

"The following command starts another Cassandra container instance and runs cqlsh (Cassandra Query Language Shell) against your original Cassandra container, allowing you to execute CQL statements against your database instance:"

`docker run -it --network cassandra-net --rm cassandra cqlsh some-cassandra`

_Note: For the alternative approach, remove the `docker exec -it kafka` prefix from each commands_

To create a topic named quick-test-topic with 1 initial partition that will not be replicated beyond the 1st broker, run:  
`docker exec -it kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server kafka:9092 --create --topic quick-test-topic --partitions 1 --replication-factor 1`

To list topics, run:  
`docker exec -it kafka /opt/kafka/bin/kafka-topics.sh --bootstrap-server kafka:9092 --list`

To get details on a particular topic, replace the topic name with the desired topic in the following command:  
`docker exec -it kafka /opt/kafka/bin/kafka-topics.sh --describe --bootstrap-server kafka:9092 --topic quick-test-topic`

Start a consumer to receive our test message we will send on quick-test-topic:  
`docker exec -it kafka /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server kafka:9092 --topic quick-test-topic`

Start a producer we can use to send a test message by running:  
`docker exec -it kafka /opt/kafka/bin/kafka-console-producer.sh --broker-list kafka:9092 --topic quick-test-topic`

#### Stopping and Cleanup 
To stop the containers but keep any data and topics you've created run:  
`docker-compose down`

To remove any data in the volume e.g. your topics and messages add the "-v" argument:  
`docker-compose down -v`

Bring things back up the same way we did at the start.
