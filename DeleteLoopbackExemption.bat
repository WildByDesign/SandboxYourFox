@echo off 
Net session >nul 2>&1 || (PowerShell start -verb runas '%~0' &exit /b)
pause
call checknetisolation loopbackexempt -d -n=AppContainer.Launcher