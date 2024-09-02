#Region ; *** Dynamically added Include files ***
#include <AutoItConstants.au3>                               ; added:08/30/24 19:14:20
#include <ExtMsgBox.au3>                                     ; added:08/30/24 19:14:20
#EndRegion ; *** Dynamically added Include files ***

#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=firefox.ico
#AutoIt3Wrapper_Res_Icon_Add=firefox.ico
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=SandboxYourFox Uninstaller
#AutoIt3Wrapper_Res_Fileversion=130.0.0.0
#AutoIt3Wrapper_Res_ProductVersion=130.0.0
#AutoIt3Wrapper_Res_ProductName=SandboxYourFox
#AutoIt3Wrapper_Res_LegalCopyright=@ 2024 WildByDesign
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_HiDpi=P
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

FirefoxRunning()

Func FirefoxRunning()
If ProcessExists("firefox.exe") Then
        _ExtMsgBoxSet(-1, 4, -1, -1, -1, -1, 800)
		$sMsg = "Firefox is currently running. Please close Firefox and run the uninstaller again." & @CRLF
		$iRetValue = _ExtMsgBox (0, 0, "SandboxYourFox Uninstaller", $sMsg)
		Exit
EndIf
EndFunc

RemoveInstall()

Func RemoveInstall()
_ExtMsgBoxSet(-1, -1, -1, -1, -1, -1, 800)
$sMsg = "SandboxYourFox Location:" & @CRLF
$sMsg &= @ProgramFilesDir & "\SandboxYourFox" & @CRLF & @CRLF
$sMsg &= " " & @CRLF
$sMsg &= "This will remove SandboxYourFox from the above location. Would you like to continue?" & @CRLF
$iRetValue = _ExtMsgBox (0, 4, "SandboxYourFox Uninstaller", $sMsg)

If $iRetValue = 1 Then
    ConsoleWrite("Yes" & @CRLF)
ElseIf $iRetValue = 2 Then
	_ExtMsgBoxSet(-1, 4, -1, -1, -1, -1, 800)
	$sMsg2 = "SandboxYourFox uninstall has been cancelled." & @CRLF
	$iRetValue2 = _ExtMsgBox (0, 0, "SandboxYourFox Uninstaller", $sMsg2)
    Exit
EndIf

EndFunc

DeleteDir()

Func DeleteDir()
        Local Const $sFilePath = @ProgramFilesDir & "\SandboxYourFox"

        If FileExists($sFilePath) Then

        DirRemove($sFilePath, $DIR_REMOVE)
		EndIf
EndFunc

DeleteShortcut()

Func DeleteShortcut()
Local Const $sFilePath = @DesktopDir & "\SandboxYourFox.lnk"

Local $iDelete = FileDelete($sFilePath)

EndFunc

RemoveMitigations()

Func RemoveMitigations()
RegDelete("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options\firefox.exe")
EndFunc

RemoveProfile()

Func RemoveProfile()
_ExtMsgBoxSet(-1, -1, -1, -1, -1, -1, 800)
$sMsg = "Profile Location:" & @CRLF
$sMsg &= @LocalAppDataDir & "\Packages\appcontainer.launcher\AC\Profile" & @CRLF & @CRLF
$sMsg &= " " & @CRLF
$sMsg &= "This will remove your SandboxYourFox Profile from the above location. Would you like to continue?" & @CRLF
$iRetValue = _ExtMsgBox (0, 4, "SandboxYourFox Uninstaller", $sMsg)

If $iRetValue = 1 Then
    ConsoleWrite("Yes" & @CRLF)
ElseIf $iRetValue = 2 Then
    Exit
EndIf

EndFunc

DeleteProfileDir()

Func DeleteProfileDir()
        Local Const $sFilePath = @LocalAppDataDir & "\Packages\appcontainer.launcher"

        If FileExists($sFilePath) Then

        DirRemove($sFilePath, $DIR_REMOVE)
		EndIf
EndFunc

InstallComplete()

Func InstallComplete()

_ExtMsgBoxSet(-1, 4, -1, -1, -1, -1, 800)
$sMsg = "SandboxYourFox has been successfully uninstalled." & @CRLF
$iRetValue = _ExtMsgBox (0, 0, "SandboxYourFox Uninstaller", $sMsg)
EndFunc

Exit
