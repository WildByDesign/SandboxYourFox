#Region
#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>
#include <ExtMsgBox.au3>
#include <StaticConstants.au3>
#include <File.au3>
#include <WinAPIFiles.au3>
#EndRegion

#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=firefox.ico
#AutoIt3Wrapper_Res_Icon_Add=firefox.ico
#AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_Res_Description=SandboxYourFox Installer
#AutoIt3Wrapper_Res_Fileversion=130.0.0.0
#AutoIt3Wrapper_Res_ProductVersion=130.0.0
#AutoIt3Wrapper_Res_ProductName=SandboxYourFox
#AutoIt3Wrapper_Res_LegalCopyright=@ 2024 WildByDesign
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_HiDpi=P
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

; Set Current Working Directory
Local $setCWD = True
If $setCWD Then FileChangeDir(@ScriptDir)

FirefoxRunning()

Func FirefoxRunning()
If ProcessExists("firefox.exe") Then
        _ExtMsgBoxSet(-1, 4, -1, -1, -1, -1, 800)
		$sMsg = "Firefox is currently running. Please close Firefox and run the installer again." & @CRLF
		$iRetValue = _ExtMsgBox (0, 0, "SandboxYourFox Installer", $sMsg)
		Exit
EndIf
EndFunc

InstallYesNo()

Func InstallYesNo()
_ExtMsgBoxSet(-1, -1, -1, -1, -1, -1, 800)
$sMsg = "Install location:" & @CRLF
$sMsg &= @ProgramFilesDir & "\SandboxYourFox" & @CRLF & @CRLF
$sMsg &= "Profile location:" & @CRLF
$sMsg &= @LocalAppDataDir & "\Packages\appcontainer.launcher\AC\Profile" & @CRLF & @CRLF
$sMsg &= "Downloads location:" & @CRLF
$sMsg &= @LocalAppDataDir & "\Packages\appcontainer.launcher\AC\Downloads" & @CRLF & @CRLF
$sMsg &= " " & @CRLF
$sMsg &= "Would you like to continue?" & @CRLF
$iRetValue = _ExtMsgBox (0, 4, "SandboxYourFox Installer", $sMsg)

If $iRetValue = 1 Then
    ConsoleWrite("Yes" & @CRLF)
ElseIf $iRetValue = 2 Then
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
Local $SandboxYourFox7z = True
Local $7zbin = True
Local $SetACL = True
Local $ProcessMitigations = True

; Use FileInstall to extract binaries
If $SandboxYourFox7z Then FileInstall(".\embed\SandboxYourFox.7z", @ProgramFilesDir & "\SandboxYourFox\SandboxYourFox.7z")
If $7zbin Then FileInstall(".\embed\7z.exe", @ProgramFilesDir & "\SandboxYourFox\7z.exe")
If $SetACL Then FileInstall(".\embed\SetACL.exe", @ProgramFilesDir & "\SandboxYourFox\SetACL.exe")
If $ProcessMitigations Then FileInstall(".\embed\ProcessMitigations.xml", @ProgramFilesDir & "\SandboxYourFox\ProcessMitigations.xml")
EndFunc

ExtractFiles()

Func ExtractFiles()
; Use FileInstall to bundle binaries
RunWait(@ComSpec & " /c " & '7z.exe x SandboxYourFox.7z', @ProgramFilesDir & "\SandboxYourFox", @SW_HIDE)
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
Local $iDelete1 = FileDelete(@ProgramFilesDir & "\SandboxYourFox\SandboxYourFox.7z")
Local $iDelete2 = FileDelete(@ProgramFilesDir & "\SandboxYourFox\7z.exe")
Local $iDelete3 = FileDelete(@ProgramFilesDir & "\SandboxYourFox\SetACL.exe")
Local $iDelete4 = FileDelete(@ProgramFilesDir & "\SandboxYourFox\ProcessMitigations.xml")
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

_ExtMsgBoxSet(-1, 4, -1, -1, -1, -1, 800)
$sMsg = "Installation has completed successfully." & @CRLF
$iRetValue = _ExtMsgBox (0, 0, "SandboxYourFox Installer", $sMsg)
EndFunc

Exit
