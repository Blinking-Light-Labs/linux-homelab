# Define the application name and the current date
$appName = ""
$currentDate = Get-Date -Format "yyyy-MM-dd"

# Display the application name and the current date
Write-Output "Application: $appName"
Write-Output "Date: $currentDate"

# Define the paths for the input PFX file and the base output directory
$pfxPath = "C:\path\"
$outputDir = "C:\path\$appName"

# Ensure the output directory exists
if (-Not (Test-Path -Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir
}

# Prompt for the PFX password securely
$pfxPassword = Read-Host "Enter the PFX password" -AsSecureString
$pfxPasswordPlainText = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($pfxPassword))

# Define the filenames with the app name and date appended
$crtFilename = "certificate_$($appName.Replace(' ', '_'))_$currentDate.crt"
$keyFilename = "private_$($appName.Replace(' ', '_'))_$currentDate.key"

# Define the paths for the output CRT and KEY files
$crtPath = "$outputDir\$crtFilename"
$keyPath = "$outputDir\$keyFilename"


# Export the private key
openssl pkcs12 -in $pfxPath -nocerts -nodes -out $keyPath -password pass:$pfxPasswordPlainText

# Export the certificate
openssl pkcs12 -in $pfxPath -clcerts -nokeys -out $crtPath -password pass:$pfxPasswordPlainText

Write-Output "Conversion complete: $pfxPath to $crtPath and $keyPath in $outputDir"