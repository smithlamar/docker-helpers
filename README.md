# docker-helpers
Useful scripts primarily for local development and prototyping with docker and utilities like kafka, cassandra, etc that can be containerized.
Not intended to be productionalized. Mostly every helper here is compiled/borrowed from somewhere else e.g. blogs or official docs. Credit is given
 where it's
 due.
 
 Many of these helpers are useful together but are generally not dependent on each other. E.g. if you already have docker, you wont need the docker
  install helper but you can still use the kafka docker-compose steps to run kafka and zookeeper.

### Available helpers:

1. Bootstrap a new Ubuntu install with Docker and Docker Compose. See: docker-helpers/docker-installation/README.md (on github: GITHUB_LINK_HERE)

2. Run Kafka in developer mode via docker compose. See: docker-helpers/kafka/developer-mode/README.md (on github: GITHUB_LINK_HERE)

