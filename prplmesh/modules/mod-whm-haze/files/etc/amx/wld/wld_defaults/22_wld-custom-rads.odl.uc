%populate {
    object WiFi {
        object Radio {
{% for ( let Radio in BD.Radios ) : %}
{% if (Radio.OperatingFrequency == "6GHz") : %}
            object '{{Radio.Alias}}' {
                parameter Channel = 33;
                parameter RegulatoryDomain = "US";
                parameter BeaconPeriod=100;
                parameter DTIMPeriod=3;
                parameter RxBeamformingCapsEnabled = "DEFAULT";
                parameter TxBeamformingCapsEnabled = "DEFAULT";
                parameter MCS = -1;
                parameter ProbeRequestNotify = "AlwaysRSSI";
                parameter ProbeRequestAggregationTimer = 1000;
                parameter OperatingStandards = "auto";
                parameter AutoBandwidthSelectMode="MaxAvailable";
                parameter OperatingChannelBandwidth="160MHz";
                parameter STA_Mode = 1;
                parameter STASupported_Mode = 1;
                object MACConfig {
                    parameter LocalGuestMacOffset = 65536;
                }
            }
{% else %}
            object '{{Radio.Alias}}' {
                parameter RegulatoryDomain = "US";
            }
{% endif; endfor; %}
        }
    }
}
