#!/bin/sh

source /lib/functions/system.sh
source /var/etc/environment

if [[ -f "/etc/env.d/01_calculate_mac_adresses_from_basemacaddress.sh" ]]; then
    exit 0
fi

for i in $(seq 1 7); do
    if [ -z $BASEMACADDRESS ]; then
        mac=""
    else
        mac=$(macaddr_add $BASEMACADDRESS $i)
        mac=$(echo "$mac" | tr '[a-z]' '[A-Z]')
    fi 
    echo "export BASEMACADDRESS_PLUS_$i=\"$mac\"" >> /var/etc/environment
done
