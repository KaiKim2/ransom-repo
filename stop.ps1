Add-Type @"
public class BlockInput {
    [System.Runtime.InteropServices.DllImport("user32.dll")]
    public static extern bool BlockInput(bool fBlockIt);
}
"@

[BlockInput]::BlockInput($true)
Start-Sleep -Seconds 20
[BlockInput]::BlockInput($false)
