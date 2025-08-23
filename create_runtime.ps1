# OTClient Runtime Setup Script
# This script creates a clean runtime directory with only the files needed to run otclient.exe

param(
    [string]$RuntimeDir = "runtime"
)

Write-Host "OTClient Runtime Setup Script" -ForegroundColor Green
Write-Host "=============================" -ForegroundColor Green
Write-Host ""

# Check if we're in the right directory
if (-not (Test-Path "otclient.exe")) {
    Write-Host "Error: Please run this script from the OTClient root directory (where otclient.exe is located)" -ForegroundColor Red
    exit 1
}

# Create runtime directory
if (Test-Path $RuntimeDir) {
    Write-Host "Removing existing runtime directory..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $RuntimeDir
}

Write-Host "Creating runtime directory: $RuntimeDir" -ForegroundColor Green
New-Item -ItemType Directory -Path $RuntimeDir | Out-Null

# Copy executable
Write-Host "Copying otclient.exe..." -ForegroundColor Cyan
Copy-Item "otclient.exe" $RuntimeDir

# Copy essential folders
$foldersToCopy = @("data", "modules", "mods")
foreach ($folder in $foldersToCopy) {
    if (Test-Path $folder) {
        Write-Host "Copying $folder/ to $RuntimeDir/$folder/..." -ForegroundColor Cyan
        Copy-Item -Recurse -Force $folder "$RuntimeDir/"
    } else {
        Write-Host "Warning: $folder not found, creating empty directory" -ForegroundColor Yellow
        New-Item -ItemType Directory -Path "$RuntimeDir/$folder" | Out-Null
    }
}

# Copy essential Lua files
$filesToCopy = @("init.lua", "otclientrc.lua")
foreach ($file in $filesToCopy) {
    if (Test-Path $file) {
        Write-Host "Copying $file..." -ForegroundColor Cyan
        Copy-Item $file $RuntimeDir
    } else {
        Write-Host "Warning: $file not found" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Runtime setup completed successfully!" -ForegroundColor Green
Write-Host "Runtime directory: $RuntimeDir" -ForegroundColor Cyan
Write-Host ""
Write-Host "To run the client:" -ForegroundColor Yellow
Write-Host "  cd $RuntimeDir" -ForegroundColor White
Write-Host "  .\otclient.exe" -ForegroundColor White
Write-Host ""
Write-Host "The client is configured to connect to: 35.199.75.222:7171 (Tibia 7.72)" -ForegroundColor Green
Write-Host ""
Write-Host "You can now delete or move the source files to keep your project clean." -ForegroundColor Cyan

