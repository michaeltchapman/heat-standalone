#!/usr/bin/env bash

set -x

yum install -y epel-release
yum update -y

yum install -y expect docker docker-registry git crudini

DB_ROOT_PW=$(mkpasswd)

docker pull rabbitmq
docker pull mysql
docker pull michchap/heatapi
docker pull michchap/heatengine

docker run --name db -e MYSQL_ROOT_PASSWORD=$DB_ROOT_PW -d mysql
docker run --name mq -e RABBITMQ_NODENAME=mq -d rabbitmq

PARAMS="-e HEAT_KEYSTONE_USER=$OS_USERNAME \
        -e KEYSTONE_AUTH_URL=$OS_AUTH_URL \
        -e USER=$OS_USERNAME \
        -e PW=$OS_PASSWORD \
        -e TENANT=$OS_TENANT_NAME
"
docker run    --name engine --link mq:rabbit --link db:mysql $PARAMS -tid michchap/heatengine
docker run -p 0.0.0.0:8004:8004 --name api    --link mq:rabbit --link db:mysql  $PARAMS -tid michchap/heatapi
