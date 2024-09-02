#Region ; *** Dynamically added Include files ***
#include <FileConstants.au3>                                 ; added:08/30/24 19:15:13
#EndRegion ; *** Dynamically added Include files ***

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

CreateDir()

Func CreateDir()
        Local Const $sFilePath = @TempDir & "\SandboxYourFox"

        If FileExists($sFilePath) Then
                Return False
        EndIf

        DirCreate($sFilePath)
EndFunc

BundleFiles()

Func BundleFiles()
Local $UninstallBin = True

If $UninstallBin Then FileInstall(".\embed\Uninstall.exe", @TempDir & "\SandboxYourFox\Uninstall.exe", $FC_OVERWRITE)
EndFunc

Uninstall()

Func Uninstall()
Run(@TempDir & "\SandboxYourFox\Uninstall.exe", "")
EndFunc

Exit
