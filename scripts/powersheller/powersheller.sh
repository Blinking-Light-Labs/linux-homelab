#!/usr/bin/env bash
# Dev: Joshua Ross
# Reason: Powershell Install and Update Script.

TMP=$(mktemp -d) # Create TMP directory
LATEST=$(curl -s "https://api.github.com/repos/PowerShell/PowerShell/releases/latest" | jq -r '
  .assets[] |
  select(.name | endswith(".deb_amd64.deb")) |
  select(.browser_download_url | startswith("https://github.com/PowerShell/PowerShell/releases/download/v7.4.3/powershell-lts_") | not) |
  .browser_download_url
')

libcu_install() {
  # Grab libicu72_72 package and install it 
  wget -O "$TMP/libicu72_72.1-3ubuntu3_amd64.deb https://mirror.it.ubc.ca/ubuntu/pool/main/i/icu/libicu72_72.1-3ubuntu3_amd64.deb"
  sudo dpkg -i "$TMP/libicu72_72.1-3ubuntu3_amd64.deb"
}

powersheller() {
  # Download powershell deb package to TMP
  wget -O "$TMP/powershell.deb $LATEST"
  if [ ! -f "$TMP/powershell.deb" ]; then
    echo "Could not download latest .deb package!"
    exit 1
  fi

  # Install/update PowerShell deb package
  echo "Installing PowerShell..."
  sudo dpkg -i "$TMP/powershell.deb"
}

# Update the System
sudo apt-get update

case "$1" in
  install)
    libcu_install
    powersheller
    ;;
  update)
    powersheller
    ;;
  *)
    echo "Usage: $0 {install|update}"
    exit 1
    ;;
esac

# Remove TMP directory
rm -R $TMP

