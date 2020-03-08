# kafka dev-mode

## Overview
Uses a docker compose file and instructions borrowed almost entirely from https://dev.to/thegroo/one-to-run-them-all-1mg6 with a few corrections
 and tweaks to start a single cluster
 zookeeper and
 kafka server. The docker compose file in use is the confluent variation from the above mentioned article and has been copied and renamed
  idiomatically to _docker-compose.yml_
 
 This kafka setup will allow non-existing topics to be created automatically when published to or consumed from.
 <br>
 <br>
 <br>
 ## Instructions
 
#### Start ZK and Kafka containers
Navigate to the directory with the compose file and run:
`docker-compose up -d`

This will start the containers based on the compose file configuration in detached mode.

<br>
 
#### Open a new shell and monitor all running docker containers (Optional)
open a new shell and run: 
`watch --interval 5 docker ps`

<br>

#### Monitor logs from the container with:
`docker-compose logs -f` exit with ctrl+c

<br>

#### Test kafka by sending some messages

Topics are pre-configured in the kafka image be created automatically but we'll create them anyway for this test.

Alternatively, you can connect to the kafka container and remove the docker prefix from all commands by first running: `docker exec -it kafka /bin/bash`
Use the kafka support scripts for things like creating topics and producing/consuming test messages.

To create a topic named quick-test-topic with 1 initial partition that will not be replicated beyond the 1st broker, run: 
`docker exec -it kafka kafka-topics --zookeeper zookeeper:2181 --create --topic quick-test-topic --partitions 1 --replication-factor 1`

To list topics, run: `docker exec -it kafka kafka-topics --zookeeper zookeeper:2181 --list`

To get details on a particular topic, replace the topic name with the desired topic in the following command:
`docker exec -it kafka kafka-topics --describe --zookeeper zookeeper:2181 --topic quick-test-topic`

Start a consumer to receive our test message we will send on quick-test-topic
`docker exec -it kafka kafka-console-consumer --bootstrap-server kafka:9092 --topic quick-test-topic`

Start a producer we can use to send a test message by running:
`kafka-console-producer --broker-list kafka:9092 --topic client`

#### Stopping and Cleanup 
To stop the containers but keep any data and topics you've created run:
`docker-compose down`

To remove any data in the volume e.g. your topics and messages add the "-v" argument:
`docker-compose down -v`

Bring things back up the same way we did at the start.
