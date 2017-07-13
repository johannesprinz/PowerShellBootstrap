@echo off
powershell -Command "Start-Process powershell '-Version 4 -NoLogo -NoExit -NoProfile -ExecutionPolicy Unrestricted -File ""%~dp0\script\psake.ps1""' -Verb RunAs"