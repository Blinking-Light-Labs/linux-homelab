#!/bin/usr/env bash
# Author: Joshua Ross
# Purpose: Proxmox Cluster Cleanup 

# Stop services
systemctl stop pve-cluster
systemctl stop corosync

# List pmxcfs processes
pmxcfs -l

# Remove corosync configuration file
rm /etc/pve/corosync.conf

# Remove corosync configuration directory contents
rm -r /etc/corosync/*

# Kill pmxcfs processes
killall pmxcfs

# Start pve-cluster service
systemctl start pve-cluster