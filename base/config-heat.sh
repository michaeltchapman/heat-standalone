#!/bin/sh

set -e

#export HEAT_KEYSTONE_USER=${HEAT_KEYSTONE_USER:-heat}
export PUBLIC_IP=${API_PORT_8004_TCP_ADDR:-localhost}

export RABBIT_USER=${RABBIT_USER:-guest}
export RABBIT_PASSWORD=${RABBIT_PASSWORD:-guest}
export RABBITMQ_SERVICE_HOST=${RABBIT_PORT_5672_TCP_ADDR:-localhost}

crudini --set /etc/heat/heat.conf DEFAULT log_file \
    "/heat.log"

crudini --set /etc/heat/heat.conf DEFAULT use_stderr \
    true
crudini --set /etc/heat/heat.conf DEFAULT rpc_backend \
    heat.openstack.common.rpc.impl_kombu
crudini --set /etc/heat/heat.conf DEFAULT rabbit_host \
    ${RABBITMQ_SERVICE_HOST}
crudini --set /etc/heat/heat.conf DEFAULT rabbit_userid \
    ${RABBIT_USER}
crudini --set /etc/heat/heat.conf DEFAULT rabbit_password \
    ${RABBIT_PASSWORD}

crudini --set /etc/heat/heat.conf database connection \
   mysql://${HEAT_DB_USER}:${HEAT_DB_PASSWORD}@${MYSQL_PORT_3306_TCP_ADDR}/${HEAT_DB_NAME}

#crudini --set /etc/heat/heat.conf keystone_authtoken auth_protocol \
#    "${KEYSTONE_AUTH_PROTOCOL}"
#crudini --set /etc/heat/heat.conf keystone_authtoken auth_host \
#    "${KEYSTONE_PUBLIC_SERVICE_HOST}"
#crudini --set /etc/heat/heat.conf keystone_authtoken auth_port \
#    5000
crudini --set /etc/heat/heat.conf keystone_authtoken auth_uri \
    "${KEYSTONE_AUTH_URL}"

#crudini --set /etc/heat/heat.conf  keystone_authtoken admin_tenant_name \
#    "${TENANT}"
#crudini --set /etc/heat/heat.conf keystone_authtoken admin_user \
#    "${USER}"
#crudini --set /etc/heat/heat.conf keystone_authtoken admin_password \
#    "${PW}"


#crudini --set /etc/heat/heat.conf DEFAULT plugin_dirs \
#    /heat/contrib/heat_keystoneclient_v2

# Standalone magic!
crudini --set /etc/heat/heat.conf paste_deploy flavor \
    standalone

crudini --set /etc/heat/heat.conf DEFAULT deferred_auth \
    password

crudini --set /etc/heat/heat.conf DEFAULT keystone_backend \
    heat.engine.plugins.heat_keystoneclient_v2.client.KeystoneClientV2

crudini --set /etc/heat/heat.conf clients_heat url \
   "http://${PUBLIC_IP}:8004/v1/%(tenant_id)s"

crudini --set /etc/heat/heat.conf DEFAULT debug \
    true
