#!/bin/sh
set -e
set -x

./config-heat.sh

mysql -h ${MYSQL_PORT_3306_TCP_ADDR} -u root -p${DB_ROOT_PASSWORD} mysql <<EOF
CREATE DATABASE IF NOT EXISTS ${HEAT_DB_NAME} DEFAULT CHARACTER SET utf8;
GRANT ALL PRIVILEGES ON ${HEAT_DB_NAME}.* TO
    '${HEAT_DB_USER}'@'%' IDENTIFIED BY '${HEAT_DB_PASSWORD}'
EOF

/usr/bin/heat-manage db_sync

exec /usr/bin/heat-engine
