$blockInput = Add-Type -MemberDefinition @"
using System;
using System.Runtime.InteropServices;

public class BlockInput {
    [DllImport("user32.dll")]
    public static extern bool BlockInput(bool fBlockIt);
}
"@ -Name "BlockInput" -Namespace "Win32" -PassThru

$BlockInput::BlockInput($true)
Start-Sleep -Seconds 20
$BlockInput::BlockInput($false)
