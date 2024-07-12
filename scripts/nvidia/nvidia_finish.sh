#!/usr/bin/env bash
# Author Joshua Ross
# Purpose: Finishing touches to nvidia_install.
# created on 05-02-2024
######################

# functions
function disable_nouveau() {
echo "blacklist nouveau" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
echo 'omit_drivers+=" nouveau "' | sudo tee /etc/dracut.conf.d/blacklist-nouveau.conf
sudo dracut --regenerate-all --force
sudo depmod -a 
}

# check if driver was isntalled
nvidia-smi

# black list nouveau drivers
echo "Disabling nouveau drivers..."
disable_nouveau
