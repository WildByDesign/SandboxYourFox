
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=firefox.ico
#AutoIt3Wrapper_Res_Icon_Add=firefox.ico
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=SandboxYourFox
#AutoIt3Wrapper_Res_Fileversion=130.0.0.0
#AutoIt3Wrapper_Res_ProductVersion=130.0.0
#AutoIt3Wrapper_Res_ProductName=SandboxYourFox
#AutoIt3Wrapper_Res_LegalCopyright=@ 2024 WildByDesign
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_HiDpi=P
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

If $CmdLine[0] = 0 Then
	SandboxYourFox()
	Exit
EndIf

If $CmdLine[1] = "nosandbox" Then
$firefoxbin = @ProgramFilesDir & "\SandboxYourFox\Firefox\firefox.exe"
$profiledir = @LocalAppDataDir & "\Packages\appcontainer.launcher\AC\Profile"
EnvSet("MOZ_FORCE_DISABLE_E10S", "1")
EnvSet("MOZ_CRASHREPORTER_DISABLE", "1")
Local $string = ' -private-window -profile '
Local $o_Pid = Run($firefoxbin & $string & $profiledir, @ProgramFilesDir & "\SandboxYourFox")
EndIf

If $CmdLine[1] = "e10s" Then
$firefoxbin = @ProgramFilesDir & "\SandboxYourFox\Firefox\firefox.exe"
$profiledir = @LocalAppDataDir & "\Packages\appcontainer.launcher\AC\Profile"
EnvSet("MOZ_CRASHREPORTER_DISABLE", "1")
Local $string = ' -private-window -profile '
Local $o_Pid = Run($firefoxbin & $string & $profiledir, @ProgramFilesDir & "\SandboxYourFox")
EndIf

Func SandboxYourFox()

$firefoxbin = @ProgramFilesDir & "\SandboxYourFox\Firefox\firefox.exe"
$profiledir = @LocalAppDataDir & "\Packages\appcontainer.launcher\AC\Profile"
EnvSet("MOZ_FORCE_DISABLE_E10S", "1")
EnvSet("MOZ_CRASHREPORTER_DISABLE", "1")
Local $string = ' -m AppContainer.Launcher -d AppContainer.Launcher -c internetClient;registryRead;lpacAppExperience;lpacClipboard;lpacCom;lpacCryptoServices;lpacEnterprisePolicyChangeNotifications;lpacIME;lpacIdentityServices;lpacInstrumentation;lpacMedia;lpacPackageManagerOperation;lpacPayments;lpacPnPNotifications;lpacPrinting;lpacServicesManagement;lpacSessionManagement;lpacWebPlatform -l -i '
Local $string2 = '"' & $firefoxbin & ' -private-window -profile ' & $profiledir & '"'
Local $LaunchAppContainer = Run(@ProgramFilesDir & "\SandboxYourFox\LaunchAppContainer.exe" & $string & $string2, @ProgramFilesDir & "\SandboxYourFox", @SW_HIDE)

EndFunc

Exit
