# Launch and start logging all input and output
Write-Host "`nScriptRunner launched. Use GUI to execute scripts.`n" -For Black -Back Cyan
$transcriptPath = "C:\Transcripts\sessionLog.csv"
Start-Transcript -Path $transcriptPath -NoClobber -Append
Write-Host "`n"

# Load assemblies
Add-Type -AssemblyName System.Windows.Forms | Out-Null

# Overall GUI layout
$GUI_Window = New-Object System.Windows.Forms.Form
$GUI_Window.Text = "ScriptRunner"
$GUI_Window.Size = New-Object System.Drawing.Size(500,275)
$GUI_Window.ControlBox = $true
$GUI_Window.FormBorderStyle = "Fixed3D"    
$GUI_Window.StartPosition = "CenterScreen"
$GUI_Window.Font = "Nirmala UI"
$GUI_Window.ForeColor = 'Black'
$GUI_Window.BackColor = 'DarkGray'
 
# Instruction label format
$instruction_Label = New-Object System.Windows.Forms.Label
$instruction_Label.Location = New-Object System.Drawing.Size(15,75)
$instruction_Label.Size = New-Object System.Drawing.Size(250,20)
$instruction_Label.TextAlign = "MiddleCenter"
$instruction_Label.Text = "Enter script path or browse for it."
$GUI_Window.Controls.Add($instruction_Label)

# Path text box
$pathText = New-Object System.Windows.Forms.Textbox
$pathText.Location = "20, 50"
$pathText.Size = "250, 30"
$GUI_Window.Controls.Add($pathText)
 
# Browse button
$browse_Button = New-Object System.Windows.Forms.Button
$browse_Button.Location = New-Object System.Drawing.Size(275,50)
$browse_Button.Size = New-Object System.Drawing.Size(100,25)
$browse_Button.TextAlign = "MiddleCenter"
$browse_Button.Cursor = "Hand"
$browse_Button.BackColor = "LightSteelBlue"
$browse_Button.ForeColor = "Black"
$browse_Button.Text = "Browse"
$browse = New-Object System.Windows.Forms.OpenFileDialog
$browse_Button.Add_Click({
    $browse.ShowDialog()
    $pathText.text = $browse.filename
    })
$GUI_Window.Controls.Add($browse_Button)

# Execute button
$execute_Button = New-Object System.Windows.Forms.Button
$execute_Button.Location = New-Object System.Drawing.Size(380,50)
$execute_Button.Size = New-Object System.Drawing.Size(100,25)
$execute_Button.TextAlign = "MiddleCenter"
$execute_Button.Cursor = "Hand"
$execute_Button.BackColor = "LightSteelBlue"
$execute_Button.ForeColor = "Black"
$execute_Button.Text = "Execute"
$execute = New-Object System.Windows.Forms.FolderBrowserDialog
$execute_Button.Add_Click({
    & $pathText.text
    $path = Split-Path -Path "$pathText" -Leaf 
    Write-Host "`nScipt executed successfully: $path"
    })
$GUI_Window.Controls.Add($execute_Button)


# Clear button
$clear_Button = New-Object System.Windows.Forms.Button
$clear_Button.Location = New-Object System.Drawing.Size(350,150)
$clear_Button.Size = New-Object System.Drawing.Size(100,25)
$clear_Button.TextAlign = "MiddleCenter"
$clear_Button.Cursor = "Hand"
$clear_Button.BackColor = "LightSteelBlue"
$clear_Button.ForeColor = "Black"
$clear_Button.Text = "Clear Console"
$clear = New-Object System.Windows.Forms.FolderBrowserDialog
$clear_Button.Add_Click({
    Clear-Host
    })
$GUI_Window.Controls.Add($clear_Button)

# CSV transcript button
$csv_Button = New-Object System.Windows.Forms.Button
$csv_Button.Location = New-Object System.Drawing.Size(200,150)
$csv_Button.Size = New-Object System.Drawing.Size(100,25)
$csv_Button.TextAlign = "MiddleCenter"
$csv_Button.Cursor = "Hand"
$csv_Button.BackColor = "LightSteelBlue"
$csv_Button.ForeColor = "Black"
$csv_Button.Text = "View CSV Log"
$transcript = New-Object System.Windows.Forms.FolderBrowserDialog
$csv_Button.Add_Click({
    & $transcriptPath
    })
$GUI_Window.Controls.Add($csv_Button)

# TXT transcript button
$txt_Button = New-Object System.Windows.Forms.Button
$txt_Button.Location = New-Object System.Drawing.Size(50,150)
$txt_Button.Size = New-Object System.Drawing.Size(100,25)
$txt_Button.TextAlign = "MiddleCenter"
$txt_Button.Cursor = "Hand"
$txt_Button.BackColor = "LightSteelBlue"
$txt_Button.ForeColor = "Black"
$txt_Button.Text = "View TXT Log"
$txt = New-Object System.Windows.Forms.FolderBrowserDialog
$txt_Button.Add_Click({
    & 'notepad.exe' $transcriptPath
    })
$GUI_Window.Controls.Add($txt_Button)
 
# Display GUI
$GUI_Window.Add_Shown({$GUI_Window.Activate()})
$GUI_Window.ShowDialog() | Out-Null

# Stop all logging
Write-Host "`n"
Stop-Transcript