Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

[System.Windows.Forms.Application]::EnableVisualStyles()

try {
    # =========================
    # SYSTEM INFO (OTTIMIZZATO)
    # =========================
    $cpu = (Get-CimInstance Win32_Processor | Select-Object -First 1).Name
    $ram = [math]::Round((Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory / 1GB)
    $disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
    $free = [math]::Round($disk.FreeSpace / 1GB)
    $total = [math]::Round($disk.Size / 1GB)
    $used = $total - $free

    # =========================
    # WINDOW CONFIG
    # =========================
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "CyberColy's Toolkit for Christianbronx v2.1"
    $form.Size = New-Object System.Drawing.Size(720, 580)
    $form.StartPosition = "CenterScreen"
    $form.BackColor = [System.Drawing.Color]::FromArgb(15, 15, 25)
    $form.ForeColor = [System.Drawing.Color]::White
    $form.FormBorderStyle = "FixedSingle"
    $form.MaximizeBox = $false

    # =========================
    # TITLE
    # =========================
    $title = New-Object System.Windows.Forms.Label
    $title.Text = "CYBERCOLY'S TOOLKIT"
    $title.Font = New-Object System.Drawing.Font("Segoe UI", 22, [System.Drawing.FontStyle]::Bold)
    $title.ForeColor = [System.Drawing.Color]::Cyan
    $title.AutoSize = $true
    $title.Location = New-Object System.Drawing.Point(20, 20)
    $form.Controls.Add($title)

    # =========================
    # INFO PANEL
    # =========================
    function Add-InfoLabel($text, $y) {
        $label = New-Object System.Windows.Forms.Label
        $label.Text = $text
        $label.ForeColor = "White"
        $label.Font = New-Object System.Drawing.Font("Segoe UI", 10)
        $label.AutoSize = $true
        $label.Location = New-Object System.Drawing.Point(20, $y)
        $form.Controls.Add($label)
    }

    Add-InfoLabel "CPU: $cpu" 100
    Add-InfoLabel "RAM: $ram GB" 140
    Add-InfoLabel "Storage: $used GB / $total GB" 180

    $bar = New-Object System.Windows.Forms.ProgressBar
    $bar.Location = New-Object System.Drawing.Point(20, 220)
    $bar.Size = New-Object System.Drawing.Size(640, 25)
    $bar.Minimum = 0
    $bar.Maximum = [int]$total
    $bar.Value = [int]$used
    $form.Controls.Add($bar)

    # =========================
    # FIXED BUTTON FUNCTION
    # =========================
    # La correzione principale: usiamo direttamente il blocco d'azione nel Click event
    function Add-ToolkitButton($text, $x, $y, $action) {
        $button = New-Object System.Windows.Forms.Button
        $button.Text = $text
        $button.Width = 300
        $button.Height = 45
        $button.Location = New-Object System.Drawing.Point($x, $y)
        $button.BackColor = [System.Drawing.Color]::FromArgb(35, 35, 50)
        $button.ForeColor = [System.Drawing.Color]::White
        $button.FlatStyle = "Flat"
        $button.Font = New-Object System.Drawing.Font("Segoe UI", 10, [System.Drawing.FontStyle]::Bold)
        
        # FIX: Assegniamo l'azione in modo che l'EXE possa interpretarla correttamente
        $button.add_Click($action)
        
        $form.Controls.Add($button)
    }

    # =========================
    # BUTTONS & ACTIONS
    # =========================
    Add-ToolkitButton "Open Task Manager" 20 300 { Start-Process taskmgr }
    Add-ToolkitButton "Open Windows Update" 340 300 { Start-Process "ms-settings:windowsupdate" }

    Add-ToolkitButton "Generate Battery Report" 20 370 {
        $path = "$env:USERPROFILE\Desktop\BatteryReport.html"
        powercfg /batteryreport /output $path
        [System.Windows.Forms.MessageBox]::Show("Report creato sul Desktop!", "Toolkit")
    }

    Add-ToolkitButton "Run Defender Quick Scan" 340 370 {
        Start-Process "powershell.exe" -ArgumentList "Start-MpScan -ScanType QuickScan"
        [System.Windows.Forms.MessageBox]::Show("Scansione Defender avviata!", "Toolkit")
    }

    Add-ToolkitButton "Clean TEMP Files" 20 440 {
        Remove-Item "$env:TEMP\*" -Force -Recurse -ErrorAction SilentlyContinue
        [System.Windows.Forms.MessageBox]::Show("File temporanei puliti!", "Toolkit")
    }

    Add-ToolkitButton "Exit Toolkit" 340 440 { $form.Close() }

    # Mostra la finestra
    $form.ShowDialog()

} catch {
    [System.Windows.Forms.MessageBox]::Show($_.Exception.Message, "Critical Error")
}