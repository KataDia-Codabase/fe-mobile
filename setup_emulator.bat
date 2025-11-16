@echo off
echo Setting up Android Emulator for BahasaKu AI
echo.

REM Android Studio usually launches AVD Manager automatically
echo Opening AVD Manager...

REM Try to find path to avdmanager
set AVD_PATH1=C:\Users\rizky\AppData\Local\Android\sdk\tools\bin
set AVD_PATH2=C:\Program Files\Common Files\android\sdk\cmdline-tools\latest\bin

if exist "%AVD_PATH1%\avdmanager.exe" (
    echo Found Android Studio installation, opening AVD Manager...
    start "" "%AVD_PATH1%\avdmanager.exe"
) else if exist "%AVD_PATH2%\avdmanager.exe" (
    echo Found Android SDK command-line tools, opening AVD Manager...
    start "" "%AVD_PATH2%\avdmanager.exe"
) else (
    echo Could not find Android Studio or Android SDK
    echo.
    echo 1. Install Android Studio from: https://developer.android.com/studio
    echo 2. Install with Android SDK and AVD Manager
    echo 3. Try running this script again
    echo.
    echo Opening download page for Android Studio...
    start "" "https://developer.android.com/studio"
)

echo.
echo After Android Studio opens:
echo.
echo Navigate to Tools → AVD Manager
echo Create/Start "Pixel 7 Pro" emulator
echo Wait for boot completion (30-60 seconds)
echo.
echo Then run: flutter run -d android
echo.

REM Wait for user to continue
pause
