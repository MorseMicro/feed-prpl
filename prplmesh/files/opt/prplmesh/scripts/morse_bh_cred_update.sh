#!/bin/sh

. /lib/functions.sh

conf_file=/var/run/wpa_supplicant-$1.conf
if [ ! -e "$conf_file" ]; then
        logger -t "prplmesh" -p daemon.crit "Config file $conf_file does not exist."
        exit 1
fi

case $2 in
    CONNECTED)
        while read -r line
        do
            case "$line" in
                ssid*)
                    ssid=`echo "$line" | cut -d'"' -f 2`
                ;;
                psk*)
                    psk=`echo "$line" | cut -d'"' -f 2`
                ;;
                #List of acceptable key management protocols; one or more of:
                #WPA-PSK (WPA pre-shared key)
                #WPA-EAP (WPA using EAP authentication),
                #IEEE8021X (IEEE 802.1x using EAP authentication and, optionally, dynamically generated WEP keys),
                #NONE (plaintext or static WEP keys).
                #If not set this defaults to "WPA-PSK WPA-EAP".

                #Currently MorseMicro supports only WPA-PSK authentication for Backhaul connection by default and it is not configurable

                key_mgmt*)
                    encryption=`echo "$line" | cut -d'=' -f 2`
                    if [ "$encryption" = "WPA-PSK" ]; then
                            encryption="psk"
                    elif [ "$encryption" = "NONE" ]; then
                            encryption="none"
                    else
                            encryption="wpa2"
                    fi
                ;;
                *)
                ;;
            esac

        done < $conf_file

        set_wireless_credentials() {

            local section=$1
            local mode

            config_get mode "$section" "mode"
            if [ "$mode" == "sta" ]; then
                uci set wireless.$section.ssid=$ssid
                uci set wireless.$section.key=$psk
                uci set wireless.$section.encryption=$encryption
                uci commit
            fi
        }

        config_load wireless
        config_foreach set_wireless_credentials wifi-iface
        ;;
    DISCONNECTED)
        ;;
esac
