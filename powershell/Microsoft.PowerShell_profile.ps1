# Initialize Starship prompt
Invoke-Expression (&starship init powershell)

# Enable prediction suggestions
Set-PSReadLineOption -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView

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

# Export installed Scoop packages as JSON
function scoop-export {
    $packages = scoop list | Select-Object -Skip 2 | ForEach-Object {
        $parts = ($_ -split '\s+')[0..1]
        [PSCustomObject]@{
            Name    = $parts[0]
            Version = $parts[1]
        }
    }
    $packages | ConvertTo-Json -Depth 3
}

# Custom prompt (optional)
# function prompt {
#     $p = (Get-Location).Path.ToLower() -replace '^([a-z]):', '/$1' -replace '\\', '/'
#     Write-Host "`n$p" -ForegroundColor Green
#     Write-Host ">" -NoNewline -ForegroundColor Green
#     return " "
# }
