@echo off
echo ============================================
echo  MI Lottery Analytics - Windows Build
echo ============================================
echo.

:: Check Node.js
where node >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Node.js not found. Download from https://nodejs.org
    pause & exit /b 1
)

:: Delete old dist and cache to avoid stale files
if exist dist rmdir /s /q dist
if exist node_modules rmdir /s /q node_modules

echo [1/3] Installing dependencies...
call npm install
if %ERRORLEVEL% NEQ 0 ( echo ERROR: npm install failed & pause & exit /b 1 )

echo.
echo [2/3] Building Windows app...
call npm run build:win
if %ERRORLEVEL% NEQ 0 ( echo ERROR: Build failed & pause & exit /b 1 )

echo.
echo [3/3] Creating desktop shortcut script...
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%TEMP%\shortcut.vbs"
echo sLinkFile = oWS.SpecialFolders("Desktop") ^& "\MI Lottery Analytics.lnk" >> "%TEMP%\shortcut.vbs"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%TEMP%\shortcut.vbs"
echo oLink.TargetPath = "%CD%\dist\MI Lottery Analytics-win32-x64\MI Lottery Analytics.exe" >> "%TEMP%\shortcut.vbs"
echo oLink.Save >> "%TEMP%\shortcut.vbs"
cscript /nologo "%TEMP%\shortcut.vbs"

echo.
echo ============================================
echo  Build complete!
echo.
echo  App folder:
echo    dist\MI Lottery Analytics-win32-x64\
echo.
echo  To run the app, double-click:
echo    MI Lottery Analytics.exe
echo    (inside the folder above)
echo.
echo  A desktop shortcut was also created.
echo ============================================
pause
