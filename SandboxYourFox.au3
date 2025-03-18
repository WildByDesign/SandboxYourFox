#NoTrayIcon

#include "includes\ExtMsgBox.au3"

#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=firefox.ico
#AutoIt3Wrapper_Res_Icon_Add=firefox.ico
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=SandboxYourFox
#AutoIt3Wrapper_Res_Fileversion=136.0.2
#AutoIt3Wrapper_Res_ProductVersion=136.0.2
#AutoIt3Wrapper_Res_ProductName=SandboxYourFox
#AutoIt3Wrapper_Res_LegalCopyright=@ 2025 WildByDesign
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_HiDpi=P
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

If $CmdLine[0] = 0 Then
	SandboxYourFox()
	Exit
EndIf

If $CmdLine[1] = "sandbox" Then
	SandboxYourFox()
	Exit
EndIf

If $CmdLine[1] = "nosandbox" Then
	NoSandbox()
	Exit
EndIf

If $CmdLine[1] = "e10s" Then
	e10s()
	Exit
EndIf

If $CmdLine[1] = "setacl" Then
	SetACL()
	Exit
EndIf

If $CmdLine[1] = "init" Then
	Exit
EndIf

Func NoSandbox()

$firefoxbin = @ProgramFilesDir & "\SandboxYourFox\Firefox\firefox.exe"
$profiledir = @LocalAppDataDir & "\Packages\appcontainer.launcher\AC\Profile"
EnvSet("MOZ_FORCE_DISABLE_E10S", "1")
EnvSet("MOZ_CRASHREPORTER_DISABLE", "1")
Local $string = ' -private-window -profile '
Local $o_Pid = Run($firefoxbin & $string & '"' & $profiledir & '"', @ProgramFilesDir & "\SandboxYourFox")
EndFunc

Func e10s()

$firefoxbin = @ProgramFilesDir & "\SandboxYourFox\Firefox\firefox.exe"
$profiledir = @LocalAppDataDir & "\Packages\appcontainer.launcher\AC\Profile"
EnvSet("MOZ_CRASHREPORTER_DISABLE", "1")
Local $string = ' -private-window -profile '
Local $o_Pid = Run($firefoxbin & $string & '"' & $profiledir & '"', @ProgramFilesDir & "\SandboxYourFox")
EndFunc

Func SetACL()

_ExtMsgBoxSet(33, 4, 0x202020, 0xFFFFFF, -1, -1, 800)
$sMsg = ' Your AppContainer ACL permissions have been set specifically for "AppContainer.Launcher" ' & @CRLF
$sMsg &= ' which is associated with the following SID:' & @CRLF & @CRLF
$sMsg &= ' S-1-15-2-3573185071-1305232710-3586399557-853445500-2893132591-3326066854-537196996 ' & @CRLF & @CRLF & @CRLF
$sMsg &= " Important:" & @CRLF & @CRLF
$sMsg &= " Please remember that setting ACL permissions on certain directories (eg. C:\Program Files) " & @CRLF
$sMsg &= ' and registry keys (eg. HKEY_LOCAL_MACHINE) require running SetAppContainerACL as Admin. ' & @CRLF
$sMsg &= " " & @CRLF

$iRetValue = _ExtMsgBox (0, 0, "SetAppContainerACL", $sMsg)
EndFunc

Func SandboxYourFox()

$firefoxbin = @ProgramFilesDir & "\SandboxYourFox\Firefox\firefox.exe"
;$firefoxbin = @ProgramFilesDir & "\SandboxYourFox\Firefox\SandboxYourFox.exe"
$profiledir = @LocalAppDataDir & "\Packages\appcontainer.launcher\AC\Profile"
EnvSet("MOZ_FORCE_DISABLE_E10S", "1")
EnvSet("MOZ_CRASHREPORTER_DISABLE", "1")
Local $string = ' -m AppContainer.Launcher -d AppContainer.Launcher -c internetClient;registryRead;lpacAppExperience;lpacClipboard;lpacCom;lpacCryptoServices;lpacEnterprisePolicyChangeNotifications;lpacIME;lpacIdentityServices;lpacInstrumentation;lpacMedia;lpacPackageManagerOperation;lpacPayments;lpacPnPNotifications;lpacPrinting;lpacServicesManagement;lpacSessionManagement;lpacWebPlatform -l -i '
Local $string2 = '"' & $firefoxbin & ' -private-window -profile ' & '""' & $profiledir & '""' & '"'
Local $LaunchAppContainer = Run(@ProgramFilesDir & "\SandboxYourFox\LaunchAppContainer.exe" & $string & $string2, @ProgramFilesDir & "\SandboxYourFox", @SW_HIDE)
EndFunc

Exit
