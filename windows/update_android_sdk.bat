:: Download latest adb & fastboot (android-sdk) from Google servers and update automatically using command prompt only
:: Created by @leuthier


@echo off

set SDK_DIR=C:\android-sdk-windows-terminal
set ZIP_FILE=%SDK_DIR%\platform-tools-latest-windows.zip
set URL=https://dl.google.com/android/repository/platform-tools-latest-windows.zip

echo Checking current Android SDK installed...
where adb
adb --version
fastboot --version

echo.
echo Killing adb server...
adb kill-server >nul 2>&1

echo.
echo Preparing SDK directory...
if not exist "%SDK_DIR%" mkdir "%SDK_DIR%"

echo.
echo Downloading platform-tools from Google...
bitsadmin /transfer /download /priority FOREGROUND "%URL%" "%ZIP_FILE%"

if not exist "%ZIP_FILE%" (
    echo ERROR: Download failed
    exit /b 1
)

cd /d "%SDK_DIR%"

if exist "platform-tools" (
    echo Backing up old platform-tools...
    rmdir /s /q platform-tools_old 2>nul
    ren platform-tools platform-tools_old
)

echo.
echo Extracting latest platform-tools...
tar -xf platform-tools-latest-windows.zip

if not exist "platform-tools" (
    echo ERROR: Extraction failed
    exit /b 1
)

echo.
echo Cleaning up...
del platform-tools-latest-windows.zip
rmdir /s /q platform-tools_old 2>nul

echo.
echo Android SDK version installed:
"%SDK_DIR%\platform-tools\adb.exe" --version
"%SDK_DIR%\platform-tools\fastboot.exe" --version

echo.
echo Update DONE!
pause
