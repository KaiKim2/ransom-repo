# disable_input.ps1
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class InputBlocker {
    [DllImport("user32.dll")]
    public static extern bool BlockInput(bool fBlockIt);
}
"@

# Duration to block input (seconds)
$duration = 10

Write-Host "Blocking keyboard and mouse for $duration seconds..."
# Block input
[InputBlocker]::BlockInput($true)

Start-Sleep -Seconds $duration

# Unblock input
[InputBlocker]::BlockInput($false)
Write-Host "Input unblocked."
