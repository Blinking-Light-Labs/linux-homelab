#!/usr/bin/env bash
# Author Joshua Ross
# Purpose: script to install nvidia druves on RHEL Systems.
# created on 05-02-2024
######################

# Functions
function enable_epel() {
sudo dnf config-manager --set-enabled crb
sudo dnf makecache
sudo dnf install -y epel-release
sudo dnf upgrade
sudo dnf update
}

function install_nvidia() {
sudo dnf config-manager --add-repo https://developer.download.nvidia.com/compute/cuda/repos/rhel9/x86_64/cuda-rhel9.repo
sudo dnf makecache
sudo dnf module install nvidia-driver 
sudo dnf -y  install freeglut-devel libX11-devel libXi-devel libXmu-devel make mesa-libGLU-devel freeimage-devel glfw-devel
}

function disable_nouveau() {
echo "blacklist nouveau" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf
echo 'omit_drivers+=" nouveau "' | sudo tee /etc/dracut.conf.d/blacklist-nouveau.conf
sudo dracut --regenerate-all --force
sudo depmod -a 
}

#install epel and nvidia drivers
echo "Enabling EPEL repo and installing Nvidia drivers..."
enable_epel && install_nvidia

# Reboot Server
reboot

