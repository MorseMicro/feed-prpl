#!/bin/sh

source /lib/functions/system.sh

if [[ -f "/etc/env.d/00_environment_mfg.sh" ]]; then
    exit 0
fi

if [ -f "/proc/environment/ethaddr" ]; then
    BASEMACADDRESS=$(cat /proc/environment/ethaddr)
elif uci -q get network.lan.macaddr; then
    BASEMACADDRESS=$(uci get network.lan.macaddr)
elif grep -q ethaddr /proc/cmdline; then
    BASEMACADDRESS=$(awk 'BEGIN{RS=" ";FS="="} $1 == "ethaddr" {print $2}' /proc/cmdline)
else
    for i in 1 2 3 ; do
        ADDR=$(cat /sys/class/net/br-lan/address)
        if [ -n "$ADDR" ] ; then
            BASEMACADDRESS=$ADDR
            break;
        fi
        sleep 1
    done
fi

# Persistent MANUFACTUREROUI and SERIALNUMBER are needed for TR-069 compliance
# If no source provides a MAC, generate a random one to use as serial
if [ -z $BASEMACADDRESS ]; then
    dummy_mac_path="/etc/config/macaddr_generated" 
    # Check if a MAC has already been generated
    if [ -f "$dummy_mac_path" ]; then
        DUMMYMAC=$(cat "$dummy_mac_path")
    else
        DUMMYMAC=$(macaddr_random | tr '[a-z]' '[A-Z]')
        echo "$DUMMYMAC" > "$dummy_mac_path"
    fi
fi

MANUFACTURER=$(awk -F',' '{print $1}' /tmp/sysinfo/board_name)
PRODUCTCLASS=$(awk -F',' '{print $2}' /tmp/sysinfo/board_name)
MODELNAME=$(cat /tmp/sysinfo/model)
HARDWAREVERSION=$(awk '$1 ~ /DISTRIB_TARGET/' /etc/openwrt_release | cut -d "'" -f2 | cut -d "'" -f1)

if [ -n "$BASEMACADDRESS" ]; then
    MANUFACTUREROUI=$(echo $BASEMACADDRESS | tr -d ':' | head -c 6 | tr '[a-z]' '[A-Z]')
    SERIALNUMBER=SN$(echo $BASEMACADDRESS | tr -d ':')
else
    MANUFACTUREROUI=$(echo $DUMMYMAC | tr -d ':' | head -c 6 | tr '[a-z]' '[A-Z]')
    SERIALNUMBER=SN$(echo $DUMMYMAC | tr -d ':')
fi

echo "export BASEMACADDRESS=\"$BASEMACADDRESS\"" >> /var/etc/environment
echo "export MANUFACTURER=\"$MANUFACTURER\"" >> /var/etc/environment
echo "export PRODUCTCLASS=\"$PRODUCTCLASS\"" >> /var/etc/environment
echo "export HARDWAREVERSION=\"$HARDWAREVERSION\"" >> /var/etc/environment
echo "export MANUFACTUREROUI=\"$MANUFACTUREROUI\"" >> /var/etc/environment
echo "export SERIALNUMBER=\"$SERIALNUMBER\"" >> /var/etc/environment
