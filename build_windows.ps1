# OTClient Windows Build Script
# This script automates the build process for Windows

param(
    [string]$BuildType = "RelWithDebInfo",
    [string]$VcpkgRoot = "C:\vcpkg",
    [string]$Triplet = "x64-windows-static"
)

Write-Host "OTClient Windows Build Script" -ForegroundColor Green
Write-Host "=============================" -ForegroundColor Green
Write-Host ""

# Check if we're in the right directory
if (-not (Test-Path "CMakeLists.txt")) {
    Write-Host "Error: Please run this script from the OTClient root directory" -ForegroundColor Red
    exit 1
}

# Check if vcpkg exists
if (-not (Test-Path $VcpkgRoot)) {
    Write-Host "Error: vcpkg not found at $VcpkgRoot" -ForegroundColor Red
    Write-Host "Please install vcpkg first:" -ForegroundColor Yellow
    Write-Host "  git clone https://github.com/Microsoft/vcpkg.git $VcpkgRoot" -ForegroundColor Yellow
    Write-Host "  cd $VcpkgRoot" -ForegroundColor Yellow
    Write-Host "  .\bootstrap-vcpkg.bat" -ForegroundColor Yellow
    exit 1
}

# Check if CMake is available
try {
    $cmakeVersion = cmake --version 2>$null
    if ($LASTEXITCODE -ne 0) {
        throw "CMake not found"
    }
    Write-Host "Found CMake: $cmakeVersion" -ForegroundColor Green
} catch {
    Write-Host "Error: CMake not found. Please install CMake 3.22+ or use Visual Studio" -ForegroundColor Red
    exit 1
}

# Create build directory
$buildDir = "build"
if (Test-Path $buildDir) {
    Write-Host "Removing existing build directory..." -ForegroundColor Yellow
    Remove-Item -Recurse -Force $buildDir
}

Write-Host "Creating build directory..." -ForegroundColor Green
New-Item -ItemType Directory -Path $buildDir | Out-Null

# Configure the project
Write-Host "Configuring project with CMake..." -ForegroundColor Green
Write-Host "Build Type: $BuildType" -ForegroundColor Cyan
Write-Host "Triplet: $Triplet" -ForegroundColor Cyan
Write-Host ""

$cmakeArgs = @(
    "..",
    "-DCMAKE_TOOLCHAIN_FILE=$VcpkgRoot\scripts\buildsystems\vcpkg.cmake",
    "-DVCPKG_TARGET_TRIPLET=$Triplet",
    "-DCMAKE_BUILD_TYPE=$BuildType"
)

$cmakeCmd = "cmake " + ($cmakeArgs -join " ")
Write-Host "Running: $cmakeCmd" -ForegroundColor Gray

Push-Location $buildDir
try {
    & cmake @cmakeArgs
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error: CMake configuration failed" -ForegroundColor Red
        exit 1
    }
} finally {
    Pop-Location
}

# Build the project
Write-Host ""
Write-Host "Building project..." -ForegroundColor Green
Push-Location $buildDir
try {
    & cmake --build . --config $BuildType
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error: Build failed" -ForegroundColor Red
        exit 1
    }
} finally {
    Pop-Location
}

# Copy required files
Write-Host ""
Write-Host "Copying required files..." -ForegroundColor Green

$outputDir = "build\$BuildType"
if (-not (Test-Path $outputDir)) {
    Write-Host "Error: Build output directory not found" -ForegroundColor Red
    exit 1
}

# Copy data and modules folders
$foldersToCopy = @("data", "modules")
foreach ($folder in $foldersToCopy) {
    if (Test-Path $folder) {
        Write-Host "Copying $folder to $outputDir..." -ForegroundColor Cyan
        Copy-Item -Recurse -Force $folder $outputDir
    } else {
        Write-Host "Warning: $folder not found" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Build completed successfully!" -ForegroundColor Green
Write-Host "Executable location: $outputDir\otclient.exe" -ForegroundColor Cyan
Write-Host ""
Write-Host "To run the client:" -ForegroundColor Yellow
Write-Host "  cd $outputDir" -ForegroundColor White
Write-Host "  .\otclient.exe" -ForegroundColor White
Write-Host ""
Write-Host "The client is configured to connect to: 35.199.75.222:7171 (Tibia 7.72)" -ForegroundColor Green
