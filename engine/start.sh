#!/bin/sh
set -e
set -x

./config-heat.sh

mysql -h ${MYSQL_PORT_3306_TCP_ADDR} -u root -p${DB_ROOT_PW} mysql -e " \
CREATE DATABASE IF NOT EXISTS heat; \
GRANT ALL PRIVILEGES ON heat.* TO \
    'heat'@'%' IDENTIFIED BY '${HEAT_DB_PASSWORD}'"

/usr/bin/heat-manage db_sync

exec /usr/bin/heat-engine
