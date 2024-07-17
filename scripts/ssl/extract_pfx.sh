#!/bin/bash
# Author: Joshua Ross
# Github: https://github.com/ColoredBytes 
# Purpose: pfx extraction script

# Define the application name and the current date
appName="YourAppName"  # Replace with your actual application name
currentDate=$(date +%Y-%m-%d)

# Display the application name and the current date
echo "Application: $appName"
echo "Date: $currentDate"

# Define the paths for the input PFX file and the base output directory
outputDir="./$appName"

# Ensure the output directory exists
if [ ! -d "$outputDir" ]; then
  mkdir -p "$outputDir"
fi

# Prompt for the PFX password securely
read -s -p "Enter the PFX password: " pfxPassword
echo

# Define the path to the PFX file (modify this as needed)
pfxFilePath="path/to/your/file.pfx"  # Replace with the actual path to your PFX file

# Extract private key
openssl pkcs12 -in "$pfxFilePath" -nocerts -nodes -out "$outputDir/key-pfx.pem" -passin pass:"$pfxPassword"
# Extract client certificate
openssl pkcs12 -in "$pfxFilePath" -clcerts -nokeys -out "$outputDir/cert-pfx.pem" -passin pass:"$pfxPassword"
# Extract CA certificate chain
openssl pkcs12 -in "$pfxFilePath" -cacerts -nokeys -chain -out "$outputDir/ca-pfx.pem" -passin pass:"$pfxPassword"
# Convert private key to PEM format
openssl rsa -in "$outputDir/key-pfx.pem" -out "$outputDir/key.pem"
# Convert client certificate to PEM format
openssl x509 -in "$outputDir/cert-pfx.pem" -out "$outputDir/cert.pem"
# Convert CA certificate chain to PEM format
openssl x509 -in "$outputDir/ca-pfx.pem" -out "$outputDir/ca.pem"

echo "Extraction and conversion completed."
