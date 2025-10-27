# Set-up the Starship prompt
Invoke-Expression (&starship init powershell)

# Enable prediction suggestions with history and plugin integration
Set-PSReadLineOption -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView

# Function to clear the command history stored by the terminal
function rmhist {
    Remove-Item (Get-PSReadLineOption).HistorySavePath -Force
}

# Function to display system uptime
function uptime {
    $t = New-TimeSpan -Start (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
    Write-Host "(!) Uptime: $("{0:D2}:{1:D2}:{2:D2}:{3:D2}" -f $t.Days, $t.Hours, $t.Minutes, $t.Seconds)" -ForegroundColor Green
}

# Custom prompt function (optional, currently commented out)
# Customizes the prompt to display the current working directory (CWD) in a Unix-style format
# function prompt {
#     $cwd = (Get-Location).Path.ToLower() -replace '^([a-z]):', '/$1' -replace '\\', '/'
#     Write-Host "`n$cwd" -ForegroundColor Green
#     Write-Host ">" -NoNewline -ForegroundColor Green
#     return " "
# }
