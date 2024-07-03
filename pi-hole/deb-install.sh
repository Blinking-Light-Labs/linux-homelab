#!/bin/bash
# Author: Joshua Ross
# Github: https://github.com/ross-jm
# Purpose: Ultimate Pi-Hole script.

# Install Pi-Hole
curl -sSL https://install.pi-hole.net | bash

### Unbound Install ### 

# Install unbound
sudo apt install unbound

# grab root hints
wget https://www.internic.net/domain/named.root -qO- | sudo tee /var/lib/unbound/root.hints

# Copy config over
cp pi-hole.conf /etc/unbound/unbound.conf.d/pi-hole.conf

# Test Unbound
sudo service unbound restart
dig pi-hole.net @127.0.0.1 -p 5335

# Incrase edns packet size
echo 'edns-packet-max=1232' | sudo tee -a /etc/dnsmasq.d/99-edns.conf

# Second Test
dig fail01.dnssec.works @127.0.0.1 -p 5335
dig dnssec.works @127.0.0.1 -p 5335

# Disable the Service
systemctl is-active unbound-resolvconf.service
sudo systemctl disable --now unbound-resolvconf.service

# Disable the file resolvconf_resolvers.conf
sudo sed -Ei 's/^unbound_conf=/#unbound_conf=/' /etc/resolvconf.conf
sudo rm /etc/unbound/unbound.conf.d/resolvconf_resolvers.conf

# Restart Service
sudo service unbound restart

### Whitelist Install ###

# Clone the repo
cd /opt/ || exit
sudo git clone https://github.com/anudeepND/whitelist.git

# Make the script to run the script at 1AM on the last day of the week
echo '0 1 * * */7     root    /opt/whitelist/scripts/whitelist.py' | sudo tee -a /etc/crontab

# First time run
sudo python3 whitelist/scripts/whitelist.py


