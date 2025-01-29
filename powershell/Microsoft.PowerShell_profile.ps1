# Runs the Starship prompt initialization command for PowerShell
# Invoke-Expression (&starship init powershell)

# Efficient system uptime function
function uptime {
    # Get system uptime since last boot
    $lastBoot = (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime
    $uptime = New-TimeSpan -Start $lastBoot 
    
    # Format uptime output
    $days = $uptime.Days
    $hours = $uptime.Hours
    $minutes = $uptime.Minutes
    $seconds = $uptime.Seconds
    
    return "${days} days, ${hours} hours, ${minutes} minutes, ${seconds} seconds"
}

function prompt {
    $path = $(Get-Location).Path # Get the current directory path
    $path = $path.ToLower() -replace '^([a-z]):', '/$1' -replace '\\', '/' # Convert path from Windows to Unix style
    Write-Host "" # Print a blank line before the prompt for spacing
    Write-Host $path -ForegroundColor Green # Print the path in green
    Write-Host ">" -NoNewline -ForegroundColor green # Print the prompt symbol ">" in green
    return " "  # Ensures no unwanted extra prompt symbols
}