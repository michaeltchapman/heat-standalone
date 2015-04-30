#!/usr/bin/env bash

##########################
# SET YOUR AUTH URL HERE #
##########################

OS_AUTH_URL=https://us-texas-2.cloud.cisco.com:5000/v2.0

############################

yum install -y epel-release
yum update -y

yum install -y expect docker docker-registry git crudini

DB_ROOT_PW=rootdbpass

HEAT_DB_NAME=heat
HEAT_DB_USER=heat
HEAT_DB_PASSWORD=heatdbpass

docker pull rabbitmq
docker pull mysql
docker pull michchap/heatapi
docker pull michchap/heatengine

docker run --name db -e MYSQL_ROOT_PASSWORD=$DB_ROOT_PW -d mysql
docker run --name mq -e RABBITMQ_NODENAME=mq -d rabbitmq
sleep 10;
PARAMS="-e HEAT_KEYSTONE_USER=$OS_USERNAME \
        -e KEYSTONE_AUTH_URL=$OS_AUTH_URL \
        -e USER=$OS_USERNAME \
        -e PW=$OS_PASSWORD \
        -e TENANT=$OS_TENANT_NAME
        -e DB_ROOT_PW=$DB_ROOT_PW
        -e HEAT_DB_NAME=$HEAT_DB_NAME
        -e HEAT_DB_USER=$HEAT_DB_USER
        -e HEAT_DB_PASSWORD=$HEAT_DB_PASSWORD
"
docker run    --name engine --link mq:rabbit --link db:mysql $PARAMS -tid michchap/heatengine
sleep 5;
docker run -p 0.0.0.0:8004:8004 --name api    --link mq:rabbit --link db:mysql  $PARAMS -tid michchap/heatapi
