# Make sure to run PowerShell as Administrator

# Get keyboard and mouse devices
$keyboard = Get-PnpDevice | Where-Object {$_.FriendlyName -like "*Keyboard*" -and $_.Status -eq "OK"}
$mouse    = Get-PnpDevice | Where-Object {$_.FriendlyName -like "*Mouse*" -and $_.Status -eq "OK"}

# Combine devices into a single array
$devices = @($keyboard + $mouse)  # Wrap in @() to make a proper array

# Disable devices
foreach ($dev in $devices) {
    Write-Output "Disabling: $($dev.FriendlyName)"
    Disable-PnpDevice -InstanceId $dev.InstanceId -Confirm:$false
}

# Wait for 20 seconds
Start-Sleep -Seconds 20

# Re-enable devices
foreach ($dev in $devices) {
    Write-Output "Enabling: $($dev.FriendlyName)"
    Enable-PnpDevice -InstanceId $dev.InstanceId -Confirm:$false
}
