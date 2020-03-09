# kafka dev-mode

## Overview
Uses a docker compose file and instructions borrowed almost entirely from https://dev.to/thegroo/one-to-run-them-all-1mg6 with a few tweaks to start a single cluster zookeeper and
 kafka server. The docker compose file in use is the wurstmeister variation from the above mentioned article and has been copied and renamed
 
 This kafka setup may not allow non-existing topics to be created automatically when published to or consumed from. Instructions for creating
  topics are further below.
  
 <br>
 <br>
 
## Instructions
 
#### Start ZK and Kafka containers
Navigate to the directory with the compose file and run:  
`docker-compose up -d`

This will start the containers based on the compose file configuration in detached mode.
  
 
#### Open a new shell and monitor all running docker containers (Optional)
open a new shell and run:  
`watch --interval 5 docker ps`

Monitor logs from the container with:  
`docker-compose logs -f` exit with ctrl+c


#### Test kafka by sending some messages

Topics may be pre-configured in the kafka image be created automatically but we'll create them anyway for this test.  
Use the kafka support scripts for things like creating topics and producing/consuming test messages.

We will run them from the ubuntu host via docker in the examples, but you can connect to the kafka container and run them directly from there if you choose. To take this alternative approach, connect to the container by running:  
`docker exec -it kafka /bin/bash`

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
`docker exec -it kafka /opt/kafka/bin/kafka-console-producer.sh --broker-list localhost:9092 --topic client`

#### Stopping and Cleanup 
To stop the containers but keep any data and topics you've created run:  
`docker-compose down`

To remove any data in the volume e.g. your topics and messages add the "-v" argument:  
`docker-compose down -v`

Bring things back up the same way we did at the start.
