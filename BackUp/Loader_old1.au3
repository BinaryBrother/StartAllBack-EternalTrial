#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile_x64=StartAllBackCfg.exe
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseUpx=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
_RenewTrial()
ShellExecute(@ProgramFilesDir & "\StartAllBack\StartAllBackCfg_Original.exe")
Func _RenewTrial()
	RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID\{9fce6b89-ea11-1a21-9bc0-81917c66e2f}\StartAllBack_TrialReset","Month: " & @MON,"REG_SZ","Day: " & @MDAY)
EndFunc

	Func _FindLowercaseRegistryKeys()
	Local $sBaseKey = "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\CLSID"
	Local $i = 1, $sSubKey, $aKeys[1] = [0]
	While 1
		$sSubKey = RegEnumKey($sBaseKey, $i)
		If @error Then ExitLoop
		If StringRegExp($sSubKey, "^[a-z0-9\{\}-]+$") Then
			ReDim $aKeys[$aKeys[0] + 2]
			$aKeys[$aKeys[0] + 1] = $sSubKey
			$aKeys[0] += 1
		EndIf
		$i += 1
	WEnd
	Return $aKeys
EndFunc
