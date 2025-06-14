#Region ; *** Dynamically added Include files ***
#include <Array.au3>                                         ; added:06/11/25 15:40:54
#EndRegion ; *** Dynamically added Include files ***
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile_x64=StartAllBack_EternalTrial.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Comment=StartAllBack Eternal Trial
#AutoIt3Wrapper_Res_Description=This will lock the StartAllBack trial to 100 days
#AutoIt3Wrapper_Res_Fileversion=1.0
#AutoIt3Wrapper_Res_ProductVersion=1.0
#AutoIt3Wrapper_Res_CompanyName=WiseTech Solutions
#AutoIt3Wrapper_Res_requestedExecutionLevel=highestAvailable
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

; This script is used to reset the StartAllBack trial by deleting the registry key that StartAllBack watches.
; The trial timer is based on the last modification date of a specific registry key.

; Make sure we're somewhere safe, like the StartAllBack ProgramFiles folder.
_MoveEternalTrial()

; Make sure that a scheduled task is created to reset the trial.
$Return = ShellExecuteWait("schtasks", '/create /tn "StartAllBack_EternalTrial" /tr "' & FileGetShortName(@ProgramFilesDir & "\StartAllBack\StartAllBack_EternalTrial.exe") & '" /sc onlogon /rl highest /f')

; Then, we find the key. It will be the only key under CLSID that is all lowercase.
; Example $RegKey = HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{9fce6b89-ea11-1a21-9bc0-81917c66e2f}
$RegKey = _FindStartAllBack_RegistryKey()

; Now, we'll delete the key being watched by StartAllBack. When StartIsBackCfg loads, it will recreate this key.
; Essentially, resetting the trial by changing the key's modification date.
RegDelete($RegKey)

Func _FindStartAllBack_RegistryKey()
	Local $sBaseKey = "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID"
	Local $i = 1, $sSubKey, $aKeys[1] = [0]
	While 1
		$sSubKey = RegEnumKey($sBaseKey, $i)
		ConsoleWrite($sSubKey & @CRLF)
		If @error Then ExitLoop
		If StringRegExp($sSubKey, "(\{[a-z0-9-\}\{]+\})") Then
			ReDim $aKeys[$aKeys[0] + 2]
			$aKeys[$aKeys[0] + 1] = $sSubKey
			$aKeys[0] += 1
		EndIf
		$i += 1
	WEnd
	If IsArray($aKeys) And UBound($aKeys) >= 2 Then
		Return $sBaseKey & "\" & $aKeys[1]
	Else
		Return SetError(1, 0, "No StartAllBack registry key found.")
	EndIf
EndFunc   ;==>_FindStartAllBack_RegistryKey

Func _SelfMove($iDelay = 3)
	Local $sCmdFile
	FileDelete(@TempDir & "\scratch.bat")
	$sCmdFile = 'ping -n ' & $iDelay & ' 127.0.0.1 > nul' & @CRLF _
			& 'move /Y "' & FileGetShortName(@ScriptFullPath) & '" "' & @ProgramFilesDir & '\StartAllBack\StartAllBack_EternalTrial.exe"' & @CRLF _
			& 'start "" "' & @ProgramFilesDir & '\StartAllBack\StartAllBack_EternalTrial.exe"'
	FileWrite(@TempDir & "\scratch.bat", $sCmdFile)
	Run(@TempDir & "\scratch.bat", @TempDir, @SW_HIDE)
EndFunc   ;==>_SelfMove

Func _MoveEternalTrial()
	If @ScriptDir <> @ProgramFilesDir & "\StartAllBack" Then
		_SelfMove()
		Exit
	EndIf
EndFunc   ;==>_MoveEternalTrial
