Add-Type -AssemblyName System.Windows.Forms

# Hold Shift 5 times to trigger Sticky Keys dialog
for ($i=0; $i -lt 5; $i++) {
    [System.Windows.Forms.SendKeys]::SendWait("+")
    Start-Sleep -Milliseconds 200
}

# Wait a moment for the dialog to appear
Start-Sleep -Seconds 1

# Press Enter to select "Yes"
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")
