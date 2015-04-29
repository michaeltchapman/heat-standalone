#!/bin/bash
set -e
set -x

. /config-heat.sh

exec /usr/bin/heat-api
