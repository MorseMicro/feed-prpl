#!/usr/bin/ucode

import { connect } from "ubus";
import { cursor } from 'uci';
import { open } from "fs";

const TOPO_QUERY_CMD = "/opt/prplmesh/bin/beerocks_cli -c \"bml_trigger_topology_discovery ";
const PRPL_MESH_AGENT_CONF = "/opt/prplmesh/config/beerocks_agent.conf";

// Reference taken from prplmesh-topology.js in morse-feed repo.
function unpackKey(d, k, v) {
    let parts = split(k, ".");
    let firstKey = parts[0];
    let remainingKey = "";

    if (length(k) > length(firstKey)) {
        remainingKey = substr(k, length(firstKey) + 1);
    }

    isNumber = (match(firstKey, "^[0-9]+$") != null);
    if (isNumber) {
        firstKey = int(firstKey) - 1;
    }

    if (isNumber != type(d) == "array") {
        warn("error", "Unexpected data when parsing key: " + k + " value: " + v);
        return;
    }

    if (remainingKey == "") {
        if (type(v) == "string") {
            if (exists(d, firstKey) ) {
                warn("Overwriting - invalid structure " + firstKey + " for key " + k);
            }
            d[firstKey] = v;
        } else {
            if (!exists(d, firstKey) ) {
                d[firstKey] = {};
            }
            for (prop in v) {
                d[firstKey][prop] = v[prop];
            }
        }
    } else {
        if ( !exists(d, firstKey)) {
            // If the remaining key begins with digits and a dot, use an array; otherwise, an object.
            if (match(remainingKey, "^[0-9]+\\.") != null) {
                d[firstKey] = [];
            } else {
                d[firstKey] = {};
            }
        }
        unpackKey(d[firstKey], remainingKey, v);
    }
};

// Reference taken from prplmesh-topology.js in morse-feed repo.
function unpackDataModel(data) {
    outputData = {};
    inputData = [];

    for (key in data) {
        push(inputData, [key, data[key]]);
    }

    sort(inputData, (a, b) => length(b[0]) - length(a[0]) );

    //print(inputData);
    for (entry in inputData) {
        if (entry[1]) {
            unpackKey(outputData, entry[0], entry[1]);
        }
    }
    return outputData;
};

function get_wifi_data_elements(bus) {
    const json_output = bus.call("Device", "_get", { depth: "7" });
    if (!json_output) {
        warn(`Unable to get to data element tree: ${ubus.error()}\n`);
        return null;
    }

    return unpackDataModel(json_output);
}

function trigger_topology_query(device_id) {
    let cmd = TOPO_QUERY_CMD + device_id + "\" &";

    const ret = system(cmd);
    if (ret != 0) {
        warn("Error triggering topology query to " + devices[id].ID + "\n");
    }
}

function is_backhaul_info_missing(device) {
    // return true when Dm is available but the BackhaulMACAddress is not populated
    if (device && device.MultiAPDevice && device.MultiAPDevice.Backhaul) {
        bh_mac = device.MultiAPDevice.Backhaul.BackhaulMACAddress;
        if (bh_mac == null || bh_mac == "" || bh_mac == "00:00:00:00:00")
            return true;
    }
    return false;
}

function is_local_agent(bridge_mac, device_id) {
    if (bridge_mac === device_id) {
        return true;
    }
    return false;
}

function get_prplmesh_bridge_mac(bus) {
    let conf = open(PRPL_MESH_AGENT_CONF, "r");
    if (!conf) {
        warn("Unable to open " + PRPL_MESH_AGENT_CONF);
        return false;
    }

    let br_name = null;
    while ((line = rtrim(conf.read("line"), "\n")) != null) {
        let val = split(line, "=", 2);
        if (!val[0]) {
            continue;
        }

        if (val[0] == "bridge_iface") {
            if (val[1]) {
                br_name = val[1];
            }
            break;
        }
    }
    conf.close();

    if (br_name) {
        br_data = bus.call("network.device", "status" , {name : br_name});
        if (br_data && br_data.macaddr)
            return br_data.macaddr;
    }
    return null;
}

function refresh_easymesh_topology(bus, data) {
    if (data == null)
        return;

    let local_agent_mac = get_prplmesh_bridge_mac(bus);

    const devices = data?.Device?.WiFi?.DataElements?.Network?.Device;
    for (let id in devices) {
        let device = devices[id];

        if (device && device.ID && is_local_agent(local_agent_mac, device.ID)) {
            continue;
        }

        if (is_backhaul_info_missing(device)) {
            trigger_topology_query(device.ID);
        }
    }
}

function is_controller_operational() {
    const uci_ctx = cursor();
    let enable = uci_ctx.get('prplmesh', 'config', 'enable');
    let management_mode = uci_ctx.get('prplmesh', 'config', 'management_mode');
    let operational = uci_ctx.get('prplmesh', 'config', 'operational');
    let ret = false;
    if ((enable == "1" && management_mode == "Multi-AP-Controller-and-Agent" && operational == "1")) {
        ret = true;
    }
    return ret;
}

const uci_ctx = cursor();
let enable = uci_ctx.get('prplmesh', 'config', 'enable');
let management_mode = uci_ctx.get('prplmesh', 'config', 'management_mode');
let operational = uci_ctx.get('prplmesh', 'config', 'operational');

if ((enable == "1" && management_mode == "Multi-AP-Controller-and-Agent" && operational == "1")) {
    const bus = connect();
    if (!bus) {
        warn(`Unable to connect to ubus: ${ubus.error()}\n`);
        return;
    }

    // APP-3936 : There are cases (during onboarding), where the backhaul info of extenders
    // are missing in prplmesh data elements. This fix will trigger topology query
    // to exetenders for which we need topology info.
    refresh_easymesh_topology(bus, get_wifi_data_elements(bus));

    bus.disconnect();
}

// See APP-1922 for the reason behind the prplmesh restart.
if ((enable == "1" && management_mode == "Multi-AP-Agent" && operational == "0")) {
    system(["service", "prplmesh", "restart"]);
}
