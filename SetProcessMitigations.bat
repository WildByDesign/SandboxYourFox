@echo off
Net session >nul 2>&1 || (PowerShell start -verb runas '%~0' &exit /b)

:: This applies the necessary Process Mitigations

Powershell -Command Set-ProcessMitigation -PolicyFilePath C:\AppContainer\ProcessMitigations.xml

Echo ...

Echo Applying Process Mitigations. Please wait...

Echo ...

TIMEOUT /nobreak /T 5

pause