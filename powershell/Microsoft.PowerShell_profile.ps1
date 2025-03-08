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
    $uptime = New-TimeSpan -Start (Get-CimInstance Win32_OperatingSystem).LastBootUpTime  
    return "$($uptime.Days)d $($uptime.Hours)h $($uptime.Minutes)m $($uptime.Seconds)s"  
}

function prompt {
    $path = $(Get-Location).Path.ToLower() -replace '^([a-z]):', '/$1' -replace '\\', '/' # Unix-style path
    Write-Host "`n$path" -ForegroundColor Green # Print path
    Write-Host ">" -NoNewline -ForegroundColor Green # Prompt symbol
    return " "  # Ensures no unwanted extra prompt symbols
}