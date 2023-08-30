%populate {
    object WiFi {
        object Radio {
{% for ( let Radio in BD.Radios ) : %}
{% if (Radio.OperatingFrequency == "5GHz") : %}
            object '{{Radio.Alias}}' {
                parameter STA_Mode = 1;
                parameter STASupported_Mode = 1;
            }
{% endif; endfor; %}
        }
    }
}
