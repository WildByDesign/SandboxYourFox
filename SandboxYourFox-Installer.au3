#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=firefox.ico
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=SandboxYourFox Installer
#AutoIt3Wrapper_Res_Fileversion=136.0.0
#AutoIt3Wrapper_Res_ProductVersion=136.0.0
#AutoIt3Wrapper_Res_ProductName=SandboxYourFox
#AutoIt3Wrapper_Res_LegalCopyright=@ 2025 WildByDesign
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_HiDpi=P
#AutoIt3Wrapper_Res_Icon_Add=firefox.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <AutoItConstants.au3>
#include <File.au3>

#include "includes\ExtMsgBox.au3"

; Set Current Working Directory
Local $setCWD = True
If $setCWD Then FileChangeDir(@ScriptDir)

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
		$sMsg = " Firefox is currently running. Please close Firefox and run the installer again. " & @CRLF
		$iRetValue = _ExtMsgBox (0, 0, "SandboxYourFox Installer", $sMsg)
		Exit
EndIf
EndFunc

InstallYesNo()

Func InstallYesNo()
;_ExtMsgBoxSet(-1, -1, -1, -1, -1, -1, 800)
$sMsg = " Install location:" & @CRLF
$sMsg &= " " & @ProgramFilesDir & "\SandboxYourFox" & @CRLF & @CRLF
$sMsg &= " Profile location:" & @CRLF
$sMsg &= " " & @LocalAppDataDir & "\Packages\appcontainer.launcher\AC\Profile " & @CRLF & @CRLF
$sMsg &= " Downloads location:" & @CRLF
$sMsg &= " " & @LocalAppDataDir & "\Packages\appcontainer.launcher\AC\Downloads " & @CRLF & @CRLF
$sMsg &= " " & @CRLF
$sMsg &= " Would you like to continue?" & @CRLF
$iRetValue = _ExtMsgBox (0, 4, "SandboxYourFox Installer", $sMsg)

If $iRetValue = 1 Then
    ConsoleWrite("Yes" & @CRLF)
ElseIf $iRetValue = 2 Then
;	_ExtMsgBoxSet(-1, 4, -1, -1, -1, -1, 800)
	$sMsg2 = " SandboxYourFox installation has been cancelled. " & @CRLF
	$iRetValue2 = _ExtMsgBox (0, 0, "SandboxYourFox Installer", $sMsg2)
    Exit
Exit
EndIf

EndFunc

DeleteDir()

Func DeleteDir()
        Local Const $sFilePath = @ProgramFilesDir & "\SandboxYourFox"

        ; If the directory exists then don't continue.
        If FileExists($sFilePath) Then

        ; Remove the directory and all sub-directories.
        DirRemove($sFilePath, $DIR_REMOVE)
		EndIf
EndFunc

CreateDir()

Func CreateDir()
        Local Const $sFilePath = @ProgramFilesDir & "\SandboxYourFox"

        ; If the directory exists then don't continue.
        If FileExists($sFilePath) Then
                Return False
        EndIf

        DirCreate($sFilePath)
EndFunc

BundleFiles()

Func BundleFiles()
; Use FileInstall to bundle binaries
Local $Firefox7z1 = True
Local $Firefox7z2 = True
Local $Firefox7z3 = True
Local $Policies7z = True
Local $7zbin = True
Local $ACL = True
Local $ProcessMitigations = True
Local $LaunchAppContainer = True
Local $SetAppContainerACL = True
Local $SandboxYourFox = True
Local $Uninstall = True

; Use FileInstall to extract binaries
If $Firefox7z1 Then FileInstall(".\embed\Firefox.7z.001", @ProgramFilesDir & "\SandboxYourFox\Firefox.7z.001")
If $Firefox7z2 Then FileInstall(".\embed\Firefox.7z.002", @ProgramFilesDir & "\SandboxYourFox\Firefox.7z.002")
If $Firefox7z3 Then FileInstall(".\embed\Firefox.7z.003", @ProgramFilesDir & "\SandboxYourFox\Firefox.7z.003")
If $Policies7z Then FileInstall(".\embed\Policies.7z", @ProgramFilesDir & "\SandboxYourFox\Policies.7z")
If $7zbin Then FileInstall(".\embed\7z.exe", @ProgramFilesDir & "\SandboxYourFox\7z.exe")
If $ACL Then FileInstall(".\embed\ACL.7z", @ProgramFilesDir & "\SandboxYourFox\ACL.7z")
If $ProcessMitigations Then FileInstall(".\embed\ProcessMitigations.xml", @ProgramFilesDir & "\SandboxYourFox\ProcessMitigations.xml")
If $LaunchAppContainer Then FileInstall(".\embed\LaunchAppContainer.exe", @ProgramFilesDir & "\SandboxYourFox\LaunchAppContainer.exe")
If $SetAppContainerACL Then FileInstall(".\embed\SetAppContainerACL.exe", @ProgramFilesDir & "\SandboxYourFox\SetAppContainerACL.exe")
If $SandboxYourFox Then FileInstall(".\SandboxYourFox.exe", @ProgramFilesDir & "\SandboxYourFox\SandboxYourFox.exe")
If $Uninstall Then FileInstall(".\Uninstall.exe", @ProgramFilesDir & "\SandboxYourFox\Uninstall.exe")
Sleep(1000)
EndFunc

ACDirExists()
Func ACDirExists()
        Local Const $sFilePath = @LocalAppDataDir & "\Packages\appcontainer.launcher\AC"

		; If the directory exists then don't continue.
        If FileExists($sFilePath) Then
                Return False
        Else
		AppContainerInit()
		EndIf
EndFunc

Func AppContainerInit()
        Local $iPID = Run(@ComSpec & " /c " & 'LaunchAppContainer.exe -m AppContainer.Launcher -d AppContainer.Launcher -i "SandboxYourFox.exe init"', @ProgramFilesDir & "\SandboxYourFox", @SW_HIDE)
        Sleep(1000)
EndFunc

CreateDirProfle()
Func CreateDirProfle()
        Local Const $sFilePath = @LocalAppDataDir & "\Packages\appcontainer.launcher\AC\Profile"

        ; If the directory exists then don't continue.
        If FileExists($sFilePath) Then
                Return False
        EndIf

        DirCreate($sFilePath)
		Sleep(500)
EndFunc

ExtensionSettings()
Func ExtensionSettings()
        Local Const $sFilePath = @LocalAppDataDir & "\Packages\appcontainer.launcher\AC\Profile\extension-preferences.json"

        ; If the file exists then don't continue.
        If FileExists($sFilePath) Then
                Return False
        EndIf

        Local $ExtensionPrefs = True
		If $ExtensionPrefs Then FileInstall(".\embed\extension-preferences.json", @ProgramFilesDir & "\SandboxYourFox\extension-preferences.json")
		Sleep(1000)
		FileCopy(@ProgramFilesDir & "\SandboxYourFox\extension-preferences.json", $sFilePath)
EndFunc

ExtractFiles()

Func ExtractFiles()
RunWait(@ComSpec & " /c " & '7z.exe x Firefox.7z.001', @ProgramFilesDir & "\SandboxYourFox", @SW_HIDE)
EndFunc

ExtractFiles2()

Func ExtractFiles2()
RunWait(@ComSpec & " /c " & '7z.exe x -aoa Policies.7z', @ProgramFilesDir & "\SandboxYourFox", @SW_HIDE)
EndFunc

ExtractFiles3()

Func ExtractFiles3()
RunWait(@ComSpec & " /c " & '7z.exe x ACL.7z', @ProgramFilesDir & "\SandboxYourFox", @SW_HIDE)
EndFunc

EnvVarFixDir()

Func EnvVarFixDir()
Local Const $sFilePath = @ProgramFilesDir & "\SandboxYourFox\ProcessMitigations.xml"
Local $EnvVarPath = @ProgramFilesDir & "\SandboxYourFox\Firefox\firefox.exe"
Local $line1 = '  <AppConfig Executable='
Local $line2 = '"'
Local $line3 = $EnvVarPath
Local $line4 = '"'
Local $line5 = '>'
_FileWriteToLine($sFilePath, 3, $line1 & $line2 & $line3 & $line4 & $line5, True)
EndFunc

ApplyMitigations()

Func ApplyMitigations()
Local $o_CmdString = ' Set-ProcessMitigation -PolicyFilePath .\ProcessMitigations.xml'
Local $o_powershell = "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"
Local $o_Pid = RunWait($o_powershell & $o_CmdString, @ProgramFilesDir & "\SandboxYourFox", @SW_HIDE)
EndFunc

RegistryDir()

Func RegistryDir()

$Test = RegEnumVal("HKCU\Software\Mozilla", "1")
If @Error <= 0 Then
;MsgBox(0, "", "Found")
Else
    ;MsgBox(0, "", "Not Found")
	RegWrite("HKEY_CURRENT_USER\Software\Mozilla")
EndIf

EndFunc

RunSetACL()

Func RunSetACL()
Local $string1 = ' -on '
Local $string2 = '"'
Local $string3 = 'hkcu\Software\Mozilla'
Local $string4 = '"'
Local $string5 = ' -ot reg -actn ace -ace '
Local $string6 = '"'
Local $string7 = 'n:S-1-15-2-3573185071-1305232710-3586399557-853445500-2893132591-3326066854-537196996;p:full'
Local $string8 = '"'
;Local $string8 = ' -on "hkcu\Software\Mozilla" -ot reg -actn ace -ace "n:S-1-15-2-3573185071-1305232710-3586399557-853445500-2893132591-3326066854-537196996;p:full"'
RunWait(@ProgramFilesDir & "\SandboxYourFox\SetACL.exe" & $string1 & $string2 & $string3 & $string4 & $string5 & $string6 & $string7 & $string8, "", @SW_HIDE)
EndFunc

Cleanup()

Func Cleanup()
Local $iDelete1 = FileDelete(@ProgramFilesDir & "\SandboxYourFox\Firefox.7z.001")
Local $iDelete2 = FileDelete(@ProgramFilesDir & "\SandboxYourFox\Firefox.7z.002")
Local $iDelete3 = FileDelete(@ProgramFilesDir & "\SandboxYourFox\Firefox.7z.003")
Local $iDelete4 = FileDelete(@ProgramFilesDir & "\SandboxYourFox\7z.exe")
Local $iDelete5 = FileDelete(@ProgramFilesDir & "\SandboxYourFox\SetACL.exe")
Local $iDelete6 = FileDelete(@ProgramFilesDir & "\SandboxYourFox\ProcessMitigations.xml")
Local $iDelete7 = FileDelete(@ProgramFilesDir & "\SandboxYourFox\Policies.7z")
Local $iDelete8 = FileDelete(@ProgramFilesDir & "\SandboxYourFox\ACL.7z")
Local $iDelete9 = FileDelete(@ProgramFilesDir & "\SandboxYourFox\extension-preferences.json")
EndFunc

Shortcut()

Func Shortcut()
Local Const $sFilePath = @DesktopDir & "\SandboxYourFox.lnk"

FileCreateShortcut(@ProgramFilesDir & "\SandboxYourFox\SandboxYourFox.exe", $sFilePath, @ProgramFilesDir & "\SandboxYourFox", "", _
        "SandboxYourFox", @ProgramFilesDir & "\SandboxYourFox\Firefox\firefox.exe", "", "0")

Local Const $sFilePath2 = @ProgramFilesDir & "\SandboxYourFox\SandboxYourFox (no sandbox).lnk"

FileCreateShortcut(@ProgramFilesDir & "\SandboxYourFox\SandboxYourFox.exe", $sFilePath2, @ProgramFilesDir & "\SandboxYourFox", "nosandbox", _
        "SandboxYourFox (no sandbox)", @ProgramFilesDir & "\SandboxYourFox\Firefox\firefox.exe", "", "0")

EndFunc

MozillaDir()

Func MozillaDir()
Local Const $sFilePath1 = @AppDataDir & "\Mozilla"
Local Const $sFilePath2 = @LocalAppDataDir & "\Mozilla"

If FileExists($sFilePath1) Then
	ConsoleWrite("Yes" & @CRLF)
Else
	DirCreate($sFilePath1)
EndIf

If FileExists($sFilePath2) Then
	ConsoleWrite("Yes" & @CRLF)
Else
	DirCreate($sFilePath2)
EndIf
EndFunc


MozillaDirACL()

Func MozillaDirACL()
Local Const $sFilePath1 = @AppDataDir & "\Mozilla"
Local Const $sFilePath2 = @LocalAppDataDir & "\Mozilla"

RunWait("icacls " & @AppDataDir & "\Mozilla /grant *S-1-15-2-3573185071-1305232710-3586399557-853445500-2893132591-3326066854-537196996:(OI)(CI)(F)", @SystemDir, @SW_HIDE)
RunWait("icacls " & @LocalAppDataDir & "\Mozilla /grant *S-1-15-2-3573185071-1305232710-3586399557-853445500-2893132591-3326066854-537196996:(OI)(CI)(F)", @SystemDir, @SW_HIDE)

EndFunc

InstallComplete()

Func InstallComplete()

;_ExtMsgBoxSet(-1, 4, -1, -1, -1, -1, 800)
$sMsg = " Installation has completed successfully. " & @CRLF
$iRetValue = _ExtMsgBox (0, 0, "SandboxYourFox Installer", $sMsg)
EndFunc

Exit
