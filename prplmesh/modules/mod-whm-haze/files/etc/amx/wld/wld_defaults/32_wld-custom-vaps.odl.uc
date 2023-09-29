%populate {
    object WiFi {
        object AccessPoint {
{% for ( let Itf in BD.Interfaces ) : if ( Itf.Type == "wireless" ) : %}
{% if (Itf.OperatingFrequency == "6GHz") : %}
            instance add ("{{Itf.Alias}}") {
                parameter RetryLimit = 3;
                parameter WMMEnable = 1;
                parameter UAPSDEnable = 0;
                parameter MCEnable = 0;
                parameter IEEE80211kEnabled = 0;
                parameter WDSEnable = 1;
                parameter MBOEnable = 0;
                parameter MultiAPType = "FronthaulBSS";
                parameter ApRole = "Off";
                parameter SSIDAdvertisementEnabled = 1;
                object Security {
                    parameter WEPKey = "123456789ABCD";
                    parameter PreSharedKey = "";
                    parameter OWETransitionInterface = "";
                    parameter SAEPassphrase = "password";
                    parameter EncryptionMode = "Default";
                    parameter SHA256Enable = 0;
                    parameter RadiusServerIPAddr = "";
                    parameter RadiusServerPort = 1812;
                    parameter RadiusSecret = "";
                    parameter RadiusDefaultSessionTimeout = 0;
                    parameter RadiusNASIdentifier = "";
                    parameter RadiusCalledStationId = "";
                    parameter RadiusChargeableUserId = 0;
                 }
                object DriverConfig {
                    parameter BssMaxIdlePeriod = -1;
                }
            }
{% endif %}
{% endif; endfor; %}
        }
    }
}
