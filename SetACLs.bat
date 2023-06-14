@echo off

:: This checks for existing Mozilla AppData folders and, if not existing, creates them prior to setting ACLs

Echo Checking for existing directories before applying AppContainer ACLs.

if not exist "C:\AppContainer" mkdir "C:\AppContainer"
if not exist "%APPDATA%\Mozilla" mkdir "%APPDATA%\Mozilla"
if not exist "%LOCALAPPDATA%\Mozilla" mkdir "%LOCALAPPDATA%\Mozilla"

Echo ...

Echo Applying AppContainer ACLs. Please wait...

Echo ...

TIMEOUT /nobreak /T 5

:: This applies the necessary AppContainer ACLs which only allow via AppContainer name of AppContainer.Launcher

call icacls C:\AppContainer /grant *S-1-15-2-3573185071-1305232710-3586399557-853445500-2893132591-3326066854-537196996:(OI)(CI)(F)
call icacls %APPDATA%\Mozilla /grant *S-1-15-2-3573185071-1305232710-3586399557-853445500-2893132591-3326066854-537196996:(OI)(CI)(F)
call icacls %LOCALAPPDATA%\Mozilla /grant *S-1-15-2-3573185071-1305232710-3586399557-853445500-2893132591-3326066854-537196996:(OI)(CI)(F)

pause