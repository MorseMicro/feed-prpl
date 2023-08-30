%populate {
    object WiFi {
{% let BssId = 0 %}
{% for ( let Itf in BD.Interfaces ) : if ( Itf.Type == "wireless" ) : %}
{% BssId++ %}
{% endif; endfor; %}
{% RadioIndex = BDfn.getRadioIndex("5GHz"); if (RadioIndex >= 0) : %}
{% BssId++ %}
        object SSID {
            instance add ({{BssId}}, "ep5g0") {
                parameter LowerLayers = "Device.WiFi.Radio.{{RadioIndex + 1}}.";
            }
        }
        object EndPoint {
            instance add ("ep5g0") {
                parameter SSIDReference = "Device.WiFi.SSID.{{BssId}}.";
                parameter Enable = 0;
                parameter BridgeInterface = "{{BD.Bridges.Lan.Name}}";
                parameter MultiAPEnable = 1;
                object WPS {
                    parameter Enable = 1;
                    parameter ConfigMethodsEnabled = "PhysicalPushButton,VirtualPushButton,VirtualDisplay,PIN";
                }
            }
        }
{% endif %}
    }
}
