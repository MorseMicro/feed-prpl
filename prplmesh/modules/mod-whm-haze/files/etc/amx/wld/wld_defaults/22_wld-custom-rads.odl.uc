%populate {
    object WiFi {
        object Radio {
{% for ( let Radio in BD.Radios ) : %}
{% if (Radio.OperatingFrequency == "6GHz") : %}
            object '{{Radio.Alias}}' {
                parameter Channel = 33;
                parameter RegulatoryDomain = "US";
            }
{% else %}
            object '{{Radio.Alias}}' {
                parameter RegulatoryDomain = "US";
            }
{% endif; endfor; %}
        }
    }
}
