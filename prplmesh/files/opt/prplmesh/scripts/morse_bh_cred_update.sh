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

                # WPS only supports WPA2/WPA-Personal and WPA2/WPA-Enterprise security modes.

                # If a Multi-AP Agent backhaul STA supports SAE and the configured credentials
                # comprise a WPA2-Personal passphrase and the Multi-AP Agent discovers an AP
                # that is advertising the backhaul SSID and an SAE AKM, the Multi-AP Agent shall
                # attempt SAE authentication with the AP (instead of WPA2-Personal) using the
                # configured passphrase.
                # In this case the key-mgmt is set as "WPA-PSK SAE"

                key_mgmt*)
                    encryption=`echo "$line" | cut -d'=' -f 2`
                    if [ "$encryption" = "WPA-PSK SAE" ]; then
                            encryption="sae-mixed"
                    elif [ "$encryption" = "WPA-PSK" ]; then
                            encryption="psk"
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
