{%+ if (rule.family): -%}
	meta nfproto {{ fw4.nfproto(rule.family) }} {%+ endif -%}
{%+ if (rule.devices_pos): -%}
	{{ (direction in ["output", "snat"])
		? "oifname" : "iifname" }} {{ fw4.set(rule.devices_pos) }} {%+ endif -%}
{%+ if (rule.devices_neg): -%}
	{{ (direction in ["output", "snat"])
		? "oifname" : "iifname"
	}} != {{ fw4.set(rule.devices_neg) }} {%+ endif -%}
{%+ if (rule.subnets_pos): -%}
	{{ fw4.ipproto(rule.family) }} {{
		(direction in ["output", "snat"]) ? "daddr" : "saddr"
	}} {{ fw4.set(rule.subnets_pos) }} {%+ endif -%}
{%+ if (rule.subnets_neg): -%}
	{{ fw4.ipproto(rule.family) }} {{
		(direction in ["output", "snat"]) ? "daddr" : "saddr"
	}} != {{ fw4.set(rule.subnets_neg) }} {%+ endif -%}
jump {{ direction }}_{{ zone.name }} comment "!fw4: Handle {{ zone.name }} {{
	fw4.nfproto(rule.family, true)
}} {{ direction }} traffic"
