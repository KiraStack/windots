# Initialize Starship prompt
# Invoke-Expression (&starship init powershell) 

Enable-PowerType # Enhanced autocomplete
Set-PSReadLineOption -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView # Enable predictions

# Clear command history
function Remove-History {
    Remove-Item (Get-PSReadlineOption).HistorySavePath -Force
}

# Show system uptime
function Get-Uptime {
    $u = New-TimeSpan -Start (Get-CimInstance Win32_OperatingSystem).LastBootUpTime
    Write-Host "Uptime: " -NoNewline -ForegroundColor Green
    Write-Host "$("{0:D2}" -f $u.Days):$("{0:D2}" -f $u.Hours):$("{0:D2}" -f $u.Minutes):$("{0:D2}" -f $u.Seconds)"
}

function prompt {
    $path = $(Get-Location).Path.ToLower() -replace '^([a-z]):', '/$1' -replace '\\', '/' # Unix-style path
    Write-Host "`n$path" -ForegroundColor Green # Print path
    Write-Host ">" -NoNewline -ForegroundColor Green # Prompt symbol
    return " "  # Ensures no unwanted extra prompt symbols
}