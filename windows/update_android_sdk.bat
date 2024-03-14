:: Download latest adb & fastboot (android-sdk) from Google servers and update automatically using command prompt only
:: Created by @leuthier - March 2024


@ECHO OFF
SETLOCAL


echo "Checking adb & fastboot versions"
adb --version
fastboot --version


echo "Killing adb service"
adb kill-server


echo "Downloading adb service"
bitsadmin /transfer /download /priority FOREGROUND "https://dl.google.com/android/repository/platform-tools-latest-windows.zip" "C:\android-sdk-windows-terminal\platform-tools-latest-windows.zip"
cd "C:\android-sdk-windows-terminal"
ren "platform-tools" "platform-tools_old"
tar -xf platform-tools-latest-windows.zip
ren "platform-tools-latest-windows" "platform-tools"


adb --version
fastboot --version


echo "Deleting platform-tools-latest-windows.zip and platform-tools_old"
del "platform-tools-latest-windows.zip"
@RD /S /Q "platform-tools_old"
echo "Update done successfully"