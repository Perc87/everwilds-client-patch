@echo off
setlocal
title EverWilds Client Patch Installer
powershell.exe -NoProfile -STA -ExecutionPolicy Bypass -File "%~dp0Install-EverWilds.ps1"
if errorlevel 1 (
  echo.
  echo Installation did not complete. Please read the message above.
)
echo.
pause
