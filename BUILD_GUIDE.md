# OTClient Build Guide for Windows - Tibia 7.72

This guide will help you compile OTClient for Windows to connect to your Tibia 7.72 server at `35.199.75.222:7171`.

## Prerequisites

### 1. Visual Studio 2022
- Download and install [Visual Studio 2022 Community](https://visualstudio.microsoft.com/downloads/) (free)
- During installation, make sure to select:
  - **Desktop development with C++**
  - **CMake tools for Visual Studio**
  - **Windows 10/11 SDK**

### 2. vcpkg Package Manager
```powershell
# Clone vcpkg to a permanent location (e.g., C:\vcpkg)
git clone https://github.com/Microsoft/vcpkg.git C:\vcpkg

# Run the bootstrap script
cd C:\vcpkg
.\bootstrap-vcpkg.bat

# Set environment variable (add to your system environment variables)
setx VCPKG_ROOT "C:\vcpkg"
setx VCPKG_DEFAULT_TRIPLET "x64-windows-static"

# Install required packages
.\vcpkg install asio luajit glew physfs openal-soft libogg libvorbis zlib opengl nlohmann-json protobuf liblzma openssl abseil cpp-httplib discord-rpc libobfuscate parallel-hashmap pugixml stduuid bshoshany-thread-pool fmt angle
```

### 3. CMake
- Install [CMake 3.22+](https://cmake.org/download/) or use the one included with Visual Studio

## Build Instructions

### Option 1: Using CMake (Recommended)

1. **Open Command Prompt or PowerShell**
```powershell
cd "E:\Projetos Git\otclient2"
```

2. **Create build directory and configure**
```powershell
mkdir build
cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=C:\vcpkg\scripts\buildsystems\vcpkg.cmake -DVCPKG_TARGET_TRIPLET=x64-windows-static -DCMAKE_BUILD_TYPE=RelWithDebInfo
```

3. **Build the project**
```powershell
cmake --build . --config RelWithDebInfo
```

### Option 2: Using Visual Studio Solution

1. **Open the solution file**
   - Open `vc17/otclient.sln` in Visual Studio 2022

2. **Set build configuration**
   - Select `Release` configuration
   - Select `x64` platform

3. **Build the solution**
   - Press `Ctrl+Shift+B` or go to `Build > Build Solution`

## Configuration

The client has been pre-configured with the following settings:

- **Default Server**: `35.199.75.222:7171`
- **Client Version**: `772` (Tibia 7.72)
- **Protocol**: `772`
- **Walking Formula**: Fixed for older protocols
- **Item Animation Speed**: Optimized for 7.72

### Configuration Files Modified

1. **`init.lua`** - Added default server configuration
2. **`otclientrc.lua`** - Set default client version and server
3. **`data/setup.otml`** - Enabled walking formula fix and optimized item animation

## Running the Client

After successful compilation:

1. **Navigate to the build directory**
```powershell
cd build\RelWithDebInfo  # or Debug if you built in debug mode
```

2. **Copy required files**
   - Copy the `data/` folder from the source directory to the build output directory
   - Copy the `modules/` folder from the source directory to the build output directory

3. **Run the client**
```powershell
.\otclient.exe
```

## Troubleshooting

### Common Build Issues

1. **vcpkg not found**
   - Make sure `VCPKG_ROOT` environment variable is set correctly
   - Restart your command prompt after setting environment variables

2. **Missing packages**
   - Run `.\vcpkg install` for all required packages
   - Make sure you're using the correct triplet (`x64-windows-static`)

3. **CMake version too old**
   - Update CMake to version 3.22 or higher
   - Use the CMake included with Visual Studio 2022

4. **Visual Studio not found**
   - Make sure you have the C++ development tools installed
   - Try using the Developer Command Prompt

### Runtime Issues

1. **Missing DLLs**
   - Make sure all required DLLs are in the same directory as `otclient.exe`
   - Check that `data/` and `modules/` folders are present

2. **Connection issues**
   - Verify the server IP and port are correct
   - Check if the server is running and accessible

## Features

This OTClient build includes:

- **Tibia 7.72 Protocol Support** - Full compatibility with your server
- **Optimized Walking System** - Fixed stuttering issues common in older protocols
- **Modern UI** - Clean, customizable interface
- **Module System** - Easy to extend and modify
- **Performance Optimizations** - Multi-threading and efficient rendering

## Support

If you encounter issues:

1. Check the console output for error messages
2. Verify all prerequisites are installed correctly
3. Make sure the build environment is properly configured
4. Check the [OTClient Wiki](https://github.com/mehah/otclient/wiki) for additional help

## Next Steps

After successful compilation:

1. Test the connection to your server
2. Customize the UI and modules as needed
3. Explore the module system for additional features
4. Consider contributing to the project

Happy gaming with your custom OTClient!
