# Path to Sticky Keys registry key
$regPath = "HKCU:\Control Panel\Accessibility\StickyKeys"

# Enable Sticky Keys by setting the "Flags" value
# "510" = Sticky Keys enabled (standard)
Set-ItemProperty -Path $regPath -Name "Flags" -Value "510"

# Optional: Force settings to apply immediately
Stop-Process -Name explorer -Force
Start-Process explorer

Write-Host "Sticky Keys enabled!"
