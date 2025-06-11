#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile_x64=StartAllBack_EternalTrial.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

; This script is used to reset the StartAllBack trial by deleting the registry key that StartAllBack watches.
; The trial is based on the last modification date of a specific registry key.

; Make sure we're somewhere safe, like the StartAllBack ProgramFiles folder.
If @ScriptDir <> @ProgramFilesDir & "\StartAllBack" Then
	_SelfMove()
EndIf

; Make sure that a scheduled task is created to reset the trial.
$Return = ShellExecuteWait("schtasks", '/create /tn "StartAllBack_EternalTrial" /tr "' & @ProgramFilesDir & "\StartAllBack\StartAllBack_EternalTrial.exe" & '" /sc onlogon /rl highest /f')

; Then, we find the key. It will be the only key under CLSID that is all lowercase.
; Example $RegKey = HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{9fce6b89-ea11-1a21-9bc0-81917c66e2f}
$RegKey = _FindStartAllBack_RegistryKey()
If @error Then
	MsgBox(16, "Eternal Trial", "Failed to find StartAllBack registry key.")
EndIf

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
	If IsArray($aKeys) Then
		Return $sBaseKey & "\" & $aKeys[1]
	Else
		Return SetError(1, 0, "No StartAllBack registry key found.")
	EndIf
EndFunc   ;==>_FindLowercaseRegistryKeys

Func _SelfMove($iDelay = 3)
    Local $sCmdFile
    FileDelete(@TempDir & "\scratch.bat")
    $sCmdFile = 'ping -n ' & $iDelay & ' 127.0.0.1 > nul' & @CRLF _
            & 'move /Y "' & FileGetShortName(@ScriptFullPath) & '" "' & @ProgramFilesDir & '\StartAllBack\StartAllBack_EternalLoader.exe"' & @CRLF _
            & 'start "" "' & @ProgramFilesDir & '\StartAllBack\StartAllBack_EternalLoader.exe"'
    FileWrite(@TempDir & "\scratch.bat", $sCmdFile)
    Run(@TempDir & "\scratch.bat", @TempDir, @SW_HIDE)
EndFunc
