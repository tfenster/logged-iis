DISM /Online /Add-Capability /CapabilityName:Microsoft.NanoServer.IIS /NoRestart
if errorlevel 3010 (
    echo The specified optional feature requested a reboot which was suppressed.
    exit /b 0
)
@echo off