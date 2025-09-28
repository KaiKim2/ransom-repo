# simulate_block_winforms.ps1
# Pure PowerShell WinForms fullscreen simulation (safe). 20s countdown. Esc/CANCEL to exit.

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

try {
    [void][System.Windows.Forms.Application]::EnableVisualStyles()

    $form = New-Object System.Windows.Forms.Form
    $form.WindowState = 'Maximized'
    $form.FormBorderStyle = 'None'
    $form.TopMost = $true
    $form.BackColor = [System.Drawing.Color]::Black
    $form.StartPosition = 'Manual'
    $form.Bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds
    $form.KeyPreview = $true

    # Title / message
    $lbl = New-Object System.Windows.Forms.Label
    $lbl.AutoSize = $false
    $lbl.TextAlign = 'MiddleCenter'
    $lbl.Dock = 'Top'
    $lbl.Height = 200
    $lbl.Font = New-Object System.Drawing.Font("Segoe UI",32,[System.Drawing.FontStyle]::Regular)
    $lbl.ForeColor = [System.Drawing.Color]::White
    $lbl.Text = "INPUT SIMULATION — Disabled for:"
    $form.Controls.Add($lbl)

    # Counter
    $cnt = New-Object System.Windows.Forms.Label
    $cnt.AutoSize = $false
    $cnt.TextAlign = 'MiddleCenter'
    $cnt.Dock = 'Top'
    $cnt.Height = 260
    $cnt.Font = New-Object System.Drawing.Font("Segoe UI",96,[System.Drawing.FontStyle]::Bold)
    $cnt.ForeColor = [System.Drawing.Color]::Red
    $cnt.Text = "20"
    $form.Controls.Add($cnt)

    # Hint + button
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
    # center the button
    $btn.Left = [int](($form.Bounds.Width - $btn.Width) / 2)
    $panel.Controls.Add($btn)

    # Hide cursor
    [System.Windows.Forms.Cursor]::Hide()

    # Event handlers: swallow input but allow ESC
    $form.Add_KeyDown({
        param($s,$e)
        if ($e.KeyCode -eq 'Escape') {
            [System.Windows.Forms.Cursor]::Show()
            $form.Close()
        } else {
            $e.Handled = $true
        }
    })

    $form.Add_MouseDown({
        param($s,$e)
        $e.Handled = $true
    })

    $form.Add_MouseWheel({
        param($s,$e)
        $e.Handled = $true
    })

    $btn.Add_Click({
        [System.Windows.Forms.Cursor]::Show()
        $form.Close()
    })

    # Countdown timer
    $duration = 20
    $timer = New-Object System.Windows.Forms.Timer
    $timer.Interval = 1000
    $timer.Add_Tick({
        $duration -= 1
        if ($duration -lt 0) {
            $timer.Stop()
            [System.Windows.Forms.Cursor]::Show()
            $form.Close()
        } else {
            $cnt.Text = $duration.ToString()
        }
    })
    $timer.Start()

    # Run the form (modal)
    [System.Windows.Forms.Application]::Run($form)
} catch {
    # if anything goes wrong, show the error (useful when run interactively)
    [System.Windows.Forms.Cursor]::Show()
    Write-Error "Simulation failed: $($_.Exception.Message)"
    throw
}
