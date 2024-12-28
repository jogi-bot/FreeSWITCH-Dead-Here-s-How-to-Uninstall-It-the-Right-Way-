#!/bin/bash

# Uninstall FreeSWITCH script
# Use this script to remove FreeSWITCH from your system completely.

echo "Starting FreeSWITCH uninstallation..."

# Stop FreeSWITCH service
if systemctl is-active --quiet freeswitch; then
    echo "Stopping FreeSWITCH service..."
    systemctl stop freeswitch
    systemctl disable freeswitch
else
    echo "FreeSWITCH service is not running."
fi

# Remove FreeSWITCH binaries and libraries
echo "Removing FreeSWITCH files..."
rm -rf /usr/local/freeswitch
rm -f /usr/local/bin/fs_cli
rm -f /usr/local/lib/libfreeswitch*

# Remove configuration files
echo "Removing FreeSWITCH configuration files..."
rm -rf /etc/freeswitch

# Remove logs
echo "Removing FreeSWITCH logs..."
rm -rf /var/log/freeswitch

# Remove systemd service file
if [ -f /etc/systemd/system/freeswitch.service ]; then
    echo "Removing FreeSWITCH systemd service..."
    rm -f /etc/systemd/system/freeswitch.service
    systemctl daemon-reload
else
    echo "No FreeSWITCH systemd service file found."
fi

# Optionally remove user and group
if id "freeswitch" &>/dev/null; then
    echo "Removing FreeSWITCH user and group..."
    userdel -r freeswitch
    groupdel freeswitch
fi

# Clean up any remaining files
echo "Cleaning up remaining files..."
rm -rf /usr/src/freeswitch*

echo "FreeSWITCH uninstallation completed."
