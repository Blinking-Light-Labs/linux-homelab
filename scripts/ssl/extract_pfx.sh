#!/bin/bash
# Author: Joshua Ross
# Github: https://github.com/ColoredBytes 
# Purpose: pfx extraction script

# Variables
appName="gitea"  # Replace with your actual application name
currentDate=$(date +%Y-%m-%d)
pfxFile="./pfx/gitea.pfx"  # Replace with the actual path to your PFX file
outputDir="./$appName"

# Ensure the output directory exists
if [ ! -d "$outputDir" ]; then
  mkdir -p "$outputDir"
fi

# Prompt for the PFX password securely
read -s -p "Enter the PFX password: " pfxPassword
echo

# Generate filenames with app name and date
privKeyFile="${outputDir}/${appName}-${currentDate}-priv.key"
pubCrtFile="${outputDir}/${appName}-${currentDate}-pub.crt"
caCrtFile="${outputDir}/${appName}-${currentDate}-ca.crt"

# Extract the private key
openssl pkcs12 -in "$pfxFile" -nocerts -nodes -out "$privKeyFile" -passin pass:"$pfxPassword"
# Extract the public key
openssl pkcs12 -in "$pfxFile" -clcerts -nokeys -out "$pubCrtFile" -passin pass:"$pfxPassword"
# Extract the CA cert chain
openssl pkcs12 -in "$pfxFile" -cacerts -nokeys -chain -out "$caCrtFile" -passin pass:"$pfxPassword"

echo "Private key saved to: $privKeyFile"
echo "Public key saved to: $pubCrtFile"
echo "CA cert chain saved to: $caCrtFile"

echo "Extraction and conversion completed."