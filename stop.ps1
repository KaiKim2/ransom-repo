Add-Type @"
using System;
using System.Runtime.InteropServices;

public class KeyboardSimulator {
    [DllImport("user32.dll")]
    public static extern void keybd_event(byte bVk, byte bScan, int dwFlags, int dwExtraInfo);

    public const int KEYEVENTF_KEYDOWN = 0x0000;
    public const int KEYEVENTF_KEYUP   = 0x0002;
    public const byte VK_SHIFT = 0x10;
    public const byte VK_ENTER = 0x0D;
}
"@

Write-Host "Simulating Shift key held for 9 seconds, then pressing Enter..."

# Hold Shift down
[KeyboardSimulator]::keybd_event([KeyboardSimulator]::VK_SHIFT, 0, [KeyboardSimulator]::KEYEVENTF_KEYDOWN, 0)

# Wait for 9 seconds
Start-Sleep -Seconds 9

# Release Shift
[KeyboardSimulator]::keybd_event([KeyboardSimulator]::VK_SHIFT, 0, [KeyboardSimulator]::KEYEVENTF_KEYUP, 0)

# Press Enter once
[KeyboardSimulator]::keybd_event([KeyboardSimulator]::VK_ENTER, 0, [KeyboardSimulator]::KEYEVENTF_KEYDOWN, 0)
[KeyboardSimulator]::keybd_event([KeyboardSimulator]::VK_ENTER, 0, [KeyboardSimulator]::KEYEVENTF_KEYUP, 0)

Write-Host "Done."
