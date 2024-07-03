#!/usr/bin/env bash
# Author Joshua Ross
# Github: https://github.com/ross-jm
# Purpose: Tool To Easily Mount Shares to LXC.

# Function for colors.
print_teal() {
    echo -e "\e[36m$1\e[0m"
}

# Function to read and validate the MountPoint number
read_mountpoint_number() {
    while true; do
        print_teal "Enter MountPoint number:"
        read -r mountpoint_number

        # Check if the input is a valid number
        if [[ $mountpoint_number =~ ^[0-9]+$ ]]; then
            mountpoint_id="mp$mountpoint_number"
            echo "Valid MountPoint ID: $mountpoint_id"
            break
        else
            echo "Invalid input. Please enter a valid number."
        fi
    done
}

# Function to read and validate the LXC ID
read_lxc_id() {
    while true; do
        print_teal "Enter LXC ID:"
        read -r LXC_ID

        # Check if the input is a valid number
        if [[ $LXC_ID =~ ^[0-9]+$ ]]; then
            echo "Valid LXC ID: $LXC_ID"
            break
        else
            echo "Invalid input. Please enter a valid number."
        fi
    done
}

# list containers
pct list

# Read LXC ID and MountPoint number
read_lxc_id
read_mountpoint_number

# Enter target and source paths
print_teal "Enter Target Path:" 
read -r TARGETPATH

print_teal "Enter Source Path:" 
read -r SOURCEPATH

# Set the mount point for the LXC
pct set "$LXC_ID" -$mountpoint_id "$TARGETPATH,mp=$SOURCEPATH"
