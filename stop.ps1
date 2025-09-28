# simulate_block.ps1
# Safe simulation: fullscreen overlay, hides cursor, swallows most events, 20s countdown, Cancel/Esc to exit.

Add-Type -AssemblyName PresentationFramework,PresentationCore,WindowsBase

# Create WPF Window
$window = New-Object System.Windows.Window
$window.WindowStyle = 'None'
$window.ResizeMode  = 'NoResize'
$window.WindowState = 'Maximized'
$window.Topmost     = $true
$window.Background  = [System.Windows.Media.Brushes]::Black
$window.ShowInTaskbar = $true

# Hide cursor while window active
[System.Windows.Input.Mouse]::OverrideCursor = [System.Windows.Input.Cursors]::None

# Layout
$grid = New-Object System.Windows.Controls.Grid
$grid.VerticalAlignment = 'Center'
$grid.HorizontalAlignment = 'Center'

# Message
$msg = New-Object System.Windows.Controls.TextBlock
$msg.Text = "INPUT SIMULATION — Disabled for:"
$msg.FontSize = 36
$msg.Foreground = [System.Windows.Media.Brushes]::White
$msg.HorizontalAlignment = 'Center'
$msg.Margin = '0,0,0,10'
$msg.TextAlignment = 'Center'

# Countdown
$counter = New-Object System.Windows.Controls.TextBlock
$counter.Text = "20"
$counter.FontSize = 110
$counter.Foreground = [System.Windows.Media.Brushes]::Red
$counter.HorizontalAlignment = 'Center'
$counter.TextAlignment = 'Center'

# Hint
$hint = New-Object System.Windows.Controls.TextBlock
$hint.Text = "Press ESC or click CANCEL to stop immediately. This is a safe simulation."
$hint.FontSize = 16
$hint.Foreground = [System.Windows.Media.Brushes]::LightGray
$hint.HorizontalAlignment = 'Center'
$hint.Margin = '0,10,0,0'
$hint.TextAlignment = 'Center'

# Cancel button
$btn = New-Object System.Windows.Controls.Button
$btn.Content = "CANCEL"
$btn.FontSize = 22
$btn.Padding = "12,8,12,8"
$btn.HorizontalAlignment = 'Center'
$btn.Margin = '0,30,0,0'
$btn.Width = 160

# StackPanel to hold elements
$panel = New-Object System.Windows.Controls.StackPanel
$panel.HorizontalAlignment = 'Center'
$panel.VerticalAlignment = 'Center'
$panel.Children.Add($msg) | Out-Null
$panel.Children.Add($counter) | Out-Null
$panel.Children.Add($hint) | Out-Null
$panel.Children.Add($btn) | Out-Null

$grid.Children.Add($panel) | Out-Null
$window.Content = $grid

# Event handlers to "swallow" input while focused (but allow Esc and Cancel)
# Key handler
$kbdHandler = {
    param($s,$e)
    if ($e.Key.ToString() -eq 'Escape') {
        # restore cursor and close
        [System.Windows.Input.Mouse]::OverrideCursor = $null
        $window.Close()
        return
    }
    $e.Handled = $true
}

# Mouse handlers
$mouseDownHandler = {
    param($s,$e)
    $e.Handled = $true
}
$mouseWheelHandler = {
    param($s,$e)
    $e.Handled = $true
}

# Attach handlers
$window.Add_PreviewKeyDown($kbdHandler)
$window.Add_PreviewMouseDown($mouseDownHandler)
$window.Add_PreviewMouseWheel($mouseWheelHandler)

# Cancel button click
$btn.Add_Click({
    [System.Windows.Input.Mouse]::OverrideCursor = $null
    $window.Close()
})

# DispatcherTimer for countdown
$duration = 20
$dispatcherTimer = New-Object System.Windows.Threading.DispatcherTimer
$dispatcherTimer.Interval = [System.TimeSpan]::FromSeconds(1)
$dispatcherTimer.Add_Tick({
    $duration -= 1
    if ($duration -lt 0) {
        $dispatcherTimer.Stop()
        [System.Windows.Input.Mouse]::OverrideCursor = $null
        $window.Close()
    } else {
        $counter.Text = $duration.ToString()
    }
})
# Start UI on STA thread
$startAction = {
    $dispatcherTimer.Start()
    $window.ShowDialog() | Out-Null
}

# Run on STA thread to avoid threading issues
$thread = New-Object System.Threading.Thread([System.Threading.ThreadStart] $startAction)
$thread.SetApartmentState([System.Threading.ApartmentState]::STA)
$thread.Start()
$thread.Join()
