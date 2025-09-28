Set WshShell = WScript.CreateObject("WScript.Shell")

' Press Shift 5 times
For i = 1 To 5
    WshShell.SendKeys "+"
    WScript.Sleep 200   ' small delay between presses
Next

' Wait for 2 seconds for the Sticky Keys dialog to appear
WScript.Sleep 2000

' Press Enter to select "Yes"
WshShell.SendKeys "~"
