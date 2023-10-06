# Get the values of the UCI parameters
enable=$(uci get prplmesh.config.enable)
management_mode=$(uci get prplmesh.config.management_mode)
operational=$(uci get prplmesh.config.operational)

# Check the conditions
if [ "$enable" -eq 1 ] && [ "$management_mode" = "Multi-AP-Agent" ] && [ "$operational" -eq 0 ]; then
    # Restart the prplmesh service
    echo "Agent is not operational $operational, hence restart prplmesh service"
    service prplmesh restart
fi
