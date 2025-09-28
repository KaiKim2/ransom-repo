Set objShell = CreateObject("WScript.Shell")
objShell.Run "powershell -Command ""Start-Sleep -Seconds 20""", 0, True

' Disable Mouse Input
Set objWMIService = GetObject("winmgmts:\\.\root\cimv2")
Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_PointingDevice", "WQL", wbemFlagReturnImmediately + wbemFlagForwardOnly)

For Each objItem In colItems
    objItem.Disable()
Next

' Disable Keyboard Input
Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_Keyboard", "WQL", wbemFlagReturnImmediately + wbemFlagForwardOnly)

For Each objItem In colItems
    objItem.Disable()
Next

WScript.Sleep 20000

' Enable Mouse Input
Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_PointingDevice", "WQL", wbemFlagReturnImmediately + wbemFlagForwardOnly)

For Each objItem In colItems
    objItem.Enable()
Next

' Enable Keyboard Input
Set colItems = objWMIService.ExecQuery("SELECT * FROM Win32_Keyboard", "WQL", wbemFlagReturnImmediately + wbemFlagForwardOnly)

For Each objItem In colItems
    objItem.Enable()
Next
