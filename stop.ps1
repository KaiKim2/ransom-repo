Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing
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

# Hide cursor
[System.Windows.Forms.Cursor]::Hide()

# Create a full-screen form
$form = New-Object System.Windows.Forms.Form
$form.FormBorderStyle = 'None'
$form.WindowState = 'Maximized'
$form.TopMost = $true

# Load and display the image
$picBox = New-Object System.Windows.Forms.PictureBox
$picBox.Dock = 'Fill'
$picBox.Image = [System.Drawing.Image]::FromFile("pic.jpg")
$picBox.SizeMode = 'StretchImage'
$form.Controls.Add($picBox)

# Show the form (covers the screen)
$form.Show()

# Simulate holding Shift for 8 seconds
[KeyboardSimulator]::keybd_event([KeyboardSimulator]::VK_SHIFT, 0, [KeyboardSimulator]::KEYEVENTF_KEYDOWN, 0)
Start-Sleep -Seconds 8
[KeyboardSimulator]::keybd_event([KeyboardSimulator]::VK_SHIFT, 0, [KeyboardSimulator]::KEYEVENTF_KEYUP, 0)

# Press Enter once
[KeyboardSimulator]::keybd_event([KeyboardSimulator]::VK_ENTER, 0, [KeyboardSimulator]::KEYEVENTF_KEYDOWN, 0)
[KeyboardSimulator]::keybd_event([KeyboardSimulator]::VK_ENTER, 0, [KeyboardSimulator]::KEYEVENTF_KEYUP, 0)

# Keep the image visible until the script is terminated manually
[System.Windows.Forms.Application]::Run($form)

# If script ends, show the cursor again
[System.Windows.Forms.Cursor]::Show()
