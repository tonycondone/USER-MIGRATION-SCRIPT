@echo off
title Full User Migration (admin -> tonyc)
echo ================================
echo Starting full migration...
echo ================================

:: STEP 1 - Create AppData structure
echo Creating AppData folders...
mkdir "C:\Users\tonyc\AppData"
mkdir "C:\Users\tonyc\AppData\Roaming"
mkdir "C:\Users\tonyc\AppData\Local"
mkdir "C:\Users\tonyc\AppData\LocalLow"

:: STEP 2 - Migrate AppData (FULL COPY)
echo Migrating AppData (this may take time)...
robocopy "C:\Users\admin\AppData" "C:\Users\tonyc\AppData" /E /COPYALL /XJ /R:1 /W:1

:: STEP 3 - Copy user root config files (best effort)
echo Copying user profile config files...
robocopy "C:\Users\admin" "C:\Users\tonyc" NTUSER.DAT NTUSER.* /COPYALL /R:1 /W:1

:: STEP 4 - Fix permissions
echo Fixing permissions...
icacls "C:\Users\tonyc" /setowner tonyc /t /c
icacls "C:\Users\tonyc" /grant tonyc:F /t

:: STEP 5 - Verify AppData
echo Verifying AppData...
dir "C:\Users\tonyc\AppData"

echo ================================
echo Migration complete.
echo Please RESTART your PC.
echo ================================

pause
