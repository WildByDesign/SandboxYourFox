#NoTrayIcon
#RequireAdmin

#include <AutoItConstants.au3>
#include <FileConstants.au3>

#include "includes\ExtMsgBox.au3"

#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=firefox.ico
#AutoIt3Wrapper_Res_Icon_Add=firefox.ico
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=SandboxYourFox Uninstaller
#AutoIt3Wrapper_Res_Fileversion=137.0.0
#AutoIt3Wrapper_Res_ProductVersion=137.0.0
#AutoIt3Wrapper_Res_ProductName=SandboxYourFox
#AutoIt3Wrapper_Res_LegalCopyright=@ 2025 WildByDesign
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_HiDpi=P
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

If $CmdLine[0] = 0 Then

InstallStep2()
EndIf

Func InstallStep2()
; C:\Users\user-name\AppData\Local\Temp\SandboxYourFox\Uninstall.exe
Local $quote1 = '"'
Local $tempdir1 = @HomeDrive
Local $tempdir2 = '\Users\'
Local $tempdir3 = @UserName
Local $tempdir4 = '\AppData\Local\Temp\SandboxYourFox\Uninstall.exe'
Local $quote2 = '"'
Local $tempdir5 = ' uninstall'

FileCopy(@ScriptDir & "\Uninstall.exe", @TempDir & "\SandboxYourFox\Uninstall.exe", $FC_OVERWRITE + $FC_CREATEPATH)
Run($quote1 & $tempdir1 & $tempdir2 & $tempdir3 & $tempdir4 & $quote2 & $tempdir5, "")
;MsgBox($MB_SYSTEMMODAL, "Title", $tempdir1 & $tempdir2 & $tempdir3 & $tempdir4 & $tempdir5)

	Exit

EndFunc

If $CmdLine[1] = "uninstall" Then
EndIf

Global $isDarkMode = is_app_dark_theme()
;MsgBox($MB_SYSTEMMODAL, "Title", $isDarkMode)

If $isDarkMode = True Then
;MsgBox($MB_SYSTEMMODAL, "Title", "We are in Dark Mode!")
Global $DarkMode = _ExtMsgBoxSet(-1, 4, 0x202020, 0xFFFFFF, -1, -1, 800)
;$sMsg = 'We are in Dark Mode!'

;$iRetValue = _ExtMsgBox (0, 0, "Dark Mode", $sMsg)
Else
;MsgBox($MB_SYSTEMMODAL, "Title", "We are in Light Mode!")
Global $LightMode = _ExtMsgBoxSet(-1, 4, -1, -1, -1, -1, 800)
;$sMsg = 'We are in Light Mode!'

;$iRetValue = _ExtMsgBox (0, 0, "Light Mode", $sMsg)
EndIf

#cs ----------------------------------------------------------------------------
 Function    : is_app_dark_theme()
 Description : returns if the user has enabled the dark theme for applications in the Windows settings (0 on / 1 off)
               if OS too old (key does not exist) the key returns nothing, so function returns False
#ce ----------------------------------------------------------------------------
func is_app_dark_theme()
    return(regread('HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize', 'AppsUseLightTheme') == 0) ? True : False
endfunc

FirefoxRunning()

Func FirefoxRunning()
If ProcessExists("firefox.exe") Then
;        _ExtMsgBoxSet(-1, 4, -1, -1, -1, -1, 800)
		$sMsg = " Firefox is currently running. Please close Firefox and run the uninstaller again. " & @CRLF
		$iRetValue = _ExtMsgBox (0, 0, "SandboxYourFox Uninstaller", $sMsg)
		Exit
EndIf
EndFunc

RemoveInstall()

Func RemoveInstall()
;_ExtMsgBoxSet(-1, -1, -1, -1, -1, -1, 800)
$sMsg = " SandboxYourFox Location:" & @CRLF
$sMsg &= " " & @ProgramFilesDir & "\SandboxYourFox " & @CRLF & @CRLF
$sMsg &= " " & @CRLF
$sMsg &= " This will remove SandboxYourFox from the above location. Would you like to continue? " & @CRLF
$iRetValue = _ExtMsgBox (0, 4, "SandboxYourFox Uninstaller", $sMsg)

If $iRetValue = 1 Then
    ConsoleWrite("Yes" & @CRLF)
ElseIf $iRetValue = 2 Then
;	_ExtMsgBoxSet(-1, 4, -1, -1, -1, -1, 800)
	$sMsg2 = " SandboxYourFox uninstall has been cancelled. " & @CRLF
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
;_ExtMsgBoxSet(-1, -1, -1, -1, -1, -1, 800)
$sMsg = " Profile Location:" & @CRLF
$sMsg &= " " & @LocalAppDataDir & "\Packages\appcontainer.launcher\AC\Profile " & @CRLF & @CRLF
$sMsg &= " " & @CRLF
$sMsg &= " This will remove your SandboxYourFox Profile from the above location. Would you like to continue? " & @CRLF
$iRetValue = _ExtMsgBox (0, 4, "SandboxYourFox Uninstaller", $sMsg)

If $iRetValue = 1 Then
    ConsoleWrite("Yes" & @CRLF)
ElseIf $iRetValue = 2 Then
	InstallComplete()
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

;_ExtMsgBoxSet(-1, 4, -1, -1, -1, -1, 800)
$sMsg = " SandboxYourFox has been successfully uninstalled. " & @CRLF
$iRetValue = _ExtMsgBox (0, 0, "SandboxYourFox Uninstaller", $sMsg)
EndFunc
Exit
