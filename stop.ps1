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

# Press Shift 5 times (key-down and key-up)
for ($i = 0; $i -lt 5; $i++) {
    [KeyboardSimulator]::keybd_event([KeyboardSimulator]::VK_SHIFT, 0, [KeyboardSimulator]::KEYEVENTF_KEYDOWN, 0)
    Start-Sleep -Milliseconds 50
    [KeyboardSimulator]::keybd_event([KeyboardSimulator]::VK_SHIFT, 0, [KeyboardSimulator]::KEYEVENTF_KEYUP, 0)
    Start-Sleep -Milliseconds 50
}

# Wait 2 seconds for Sticky Keys dialog to appear
Start-Sleep -Seconds 2

# Press Enter to select "Yes"
[KeyboardSimulator]::keybd_event([KeyboardSimulator]::VK_ENTER, 0, [KeyboardSimulator]::KEYEVENTF_KEYDOWN, 0)
[KeyboardSimulator]::keybd_event([KeyboardSimulator]::VK_ENTER, 0, [KeyboardSimulator]::KEYEVENTF_KEYUP, 0)
