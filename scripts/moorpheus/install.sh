#!/bin/bash
# =============================================================================
# Script Name: install.sh
# Author: Joshua Ross
# Purpose: Installing Morpheus CE on Linux Servers
# Date: 08/23/2024
# =============================================================================

# ===========================Variables & Functions=============================
dnf_update() {
  sudo dnf check-update
  sudo dnf upgrade -y
}

deb_update() {
  sudo apt update
  sudo apt upgrade -y
}

VERSION='7.0.3-2'
BASE_URL="https://downloads.morpheusdata.com/files/morpheus-appliance"
RPM_APPLIANCE_FILE="morpheus-appliance-${VERSION}.el8.x86_64.rpm"
RPM_APPLIANCE_URL="${BASE_URL}-${VERSION}.el8.x86_64.rpm"
DEB_APPLIANCE_FILE="morpheus-appliance-${VERSION}.deb"
DEB_APPLIANCE_URL="${BASE_URL}-${VERSION}.deb"


# =================================Install=====================================

rpm_install() {
  # Update host system
  dnf_update

  # Download the RPM file
  echo "Downloading from: $RPM_APPLIANCE_URL"
  wget $RPM_APPLIANCE_URL

  # Verify the checksum (replace the checksum with the correct one)
  echo "Verifying checksum..."
  EXPECTED_CHECKSUM="9bf02e06dff6a4ee1f703035f055c04097a95ca51f0ba90c9efe234ad36eccb9"
  DOWNLOADED_CHECKSUM=$(sha256sum "$RPM_APPLIANCE_FILE" | awk '{print $1}')

  if [ "$EXPECTED_CHECKSUM" = "$DOWNLOADED_CHECKSUM" ]; then
      echo "Checksum verified. Installing the RPM..."
      sudo rpm -ihv "$RPM_APPLIANCE_FILE"
  else
      echo "Checksum verification failed. Aborting installation."
      exit 1
  fi
}

deb_install() {
  # Update host system
  deb_update

  # Download the DEB file
  echo "Downloading from: $DEB_APPLIANCE_URL"
  wget $DEB_APPLIANCE_URL

  # Verify the checksum (replace the checksum with the correct one)
  echo "Verifying checksum..."
  EXPECTED_CHECKSUM="30b4c404e45f61c0a191076349477fdd31891883dddec7b0414483cf2f6aa04d"
  DOWNLOADED_CHECKSUM=$(sha256sum "$DEB_APPLIANCE_FILE" | awk '{print $1}')

  if [ "$EXPECTED_CHECKSUM" = "$DOWNLOADED_CHECKSUM" ]; then
      echo "Checksum verified. Installing the DEB..."
      sudo dpkg -i "$DEB_APPLIANCE_FILE"
  else
      echo "Checksum verification failed. Aborting installation."
      exit 1
  fi
}

case "$1" in
  deb)
    deb_install
  ;;
  rpm)
    rpm_install
  ;;
  *)
    echo "[i] Invalid choice. Please specify either 'deb' or 'rpm'."
  ;;
esac
