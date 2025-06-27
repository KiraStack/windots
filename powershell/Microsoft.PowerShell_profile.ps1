# Init Starship prompt
# Invoke-Expression (&starship init powershell)


# Enable prediction suggestions
# Set-PSReadLineOption -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView

# Clear PSReadLine history
function rmhist {
    Remove-Item (Get-PSReadLineOption).HistorySavePath -Force
}

# Display system uptime
function uptime {
    $t = New-TimeSpan -Start (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
    Write-Host "(!) Uptime: $("{0:D2}:{1:D2}:{2:D2}:{3:D2}" -f $t.Days, $t.Hours, $t.Minutes, $t.Seconds)" -ForegroundColor Green
}

# Start Roblox Studio RPC
function rbx-rpc {
    $exe = 'C:\Program Files\StudioPresence-Windows\studiopresence-win.exe'

    if (Test-Path $exe) {
        Start-Process $exe
        Write-Host "(!) RPC started." -ForegroundColor Green
    } else {
        Write-Host "(!!) RPC not found at: $exe" -ForegroundColor Red
    }
}

# Custom prompt (optional)
function prompt {
    $cwd = (Get-Location).Path.ToLower() -replace '^([a-z]):', '/$1' -replace '\\', '/'
    Write-Host "`n$cwd" -ForegroundColor Green
    Write-Host ">" -NoNewline -ForegroundColor Green
    return " "
}