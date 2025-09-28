# Make sure to run PowerShell as Administrator

# Get keyboard and mouse devices
$keyboard = Get-PnpDevice | Where-Object {$_.FriendlyName -like "*Keyboard*" -and $_.Status -eq "OK"}
$mouse    = Get-PnpDevice | Where-Object {$_.FriendlyName -like "*Mouse*" -and $_.Status -eq "OK"}

# Disable devices
foreach ($dev in $keyboard + $mouse) {
    Write-Output "Disabling: $($dev.FriendlyName)"
    Disable-PnpDevice -InstanceId $dev.InstanceId -Confirm:$false
}

# Wait for 20 seconds
Start-Sleep -Seconds 20

# Re-enable devices
foreach ($dev in $keyboard + $mouse) {
    Write-Output "Enabling: $($dev.FriendlyName)"
    Enable-PnpDevice -InstanceId $dev.InstanceId -Confirm:$false
}
