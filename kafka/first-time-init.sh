#!/bin/bash

set -e
set -u

networkName="kafka-net"
zk_service_name="zookeeper"

docker network create -d overlay --attachable $networkName

docker service create --network $networkName --name=$zk
