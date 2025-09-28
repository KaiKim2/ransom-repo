# simulate_block_winforms_loop.ps1
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

[void][System.Windows.Forms.Application]::EnableVisualStyles()

$duration = 20

$form = New-Object System.Windows.Forms.Form
$form.WindowState = 'Maximized'
$form.FormBorderStyle = 'None'
$form.TopMost = $true
$form.BackColor = [System.Drawing.Color]::Black
$form.StartPosition = 'Manual'
$form.Bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
$form.KeyPreview = $true

# Message label
$lbl = New-Object System.Windows.Forms.Label
$lbl.AutoSize = $false
$lbl.TextAlign = 'MiddleCenter'
$lbl.Dock = 'Top'
$lbl.Height = 200
$lbl.Font = New-Object System.Drawing.Font("Segoe UI",32,[System.Drawing.FontStyle]::Regular)
$lbl.ForeColor = [System.Drawing.Color]::White
$lbl.Text = "INPUT SIMULATION — Disabled for:"
$form.Controls.Add($lbl)

# Countdown label
$cnt = New-Object System.Windows.Forms.Label
$cnt.AutoSize = $false
$cnt.TextAlign = 'MiddleCenter'
$cnt.Dock = 'Top'
$cnt.Height = 260
$cnt.Font = New-Object System.Drawing.Font("Segoe UI",96,[System.Drawing.FontStyle]::Bold)
$cnt.ForeColor = [System.Drawing.Color]::Red
$cnt.Text = $duration.ToString()
$form.Controls.Add($cnt)

# Hint + CANCEL button
$panel = New-Object System.Windows.Forms.Panel
$panel.Dock = 'Fill'
$panel.BackColor = [System.Drawing.Color]::Black
$form.Controls.Add($panel)

$hint = New-Object System.Windows.Forms.Label
$hint.AutoSize = $false
$hint.TextAlign = 'MiddleCenter'
$hint.Dock = 'Top'
$hint.Height = 40
$hint.Font = New-Object System.Drawing.Font("Segoe UI",14)
$hint.ForeColor = [System.Drawing.Color]::LightGray
$hint.Text = "Press ESC or click CANCEL to stop immediately. This is a safe simulation."
$panel.Controls.Add($hint)

$btn = New-Object System.Windows.Forms.Button
$btn.Text = "CANCEL"
$btn.Font = New-Object System.Drawing.Font("Segoe UI",18)
$btn.Width = 200
$btn.Height = 56
$btn.Top = 80
$btn.Left = [int](($form.Bounds.Width - $btn.Width)/2)
$panel.Controls.Add($btn)

# Hide cursor
[System.Windows.Forms.Cursor]::Hide()

# Event handlers
$stop = $false
$form.Add_KeyDown({
    param($s,$e)
    if ($e.KeyCode -eq 'Escape') { $stop = $true }
    else { $e.Handled = $true }
})

$form.Add_MouseDown({ $e.Handled = $true })
$form.Add_MouseWheel({ $e.Handled = $true })
$btn.Add_Click({ $stop = $true })

# Show the form
$form.Show()

# Manual countdown loop
while (-not $stop -and $duration -ge 0) {
    $cnt.Text = $duration.ToString()
    $form.Refresh()          # repaint the form
    Start-Sleep -Seconds 1
    $duration--
}

# Cleanup
[System.Windows.Forms.Cursor]::Show()
$form.Close()
