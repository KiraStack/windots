# Initialize Starship prompt
Invoke-Expression (&starship init powershell)

# Efficient system uptime function
function Get-Uptime {
    $uptime = New-TimeSpan -Start (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime
    return "{0} days, {1} hours, {2} minutes, {3} seconds" -f $uptime.Days, $uptime.Hours, $uptime.Minutes, $uptime.Seconds
}

function Wotaku {
    $MediaType = Read-Host "Do you want to watch (a)nime or read (m)anga?"
    if ($MediaType -eq 'a' -or $MediaType -eq 'anime') { & "sh" "ani-cli" $args }
    elseif ($MediaType -eq 'm' -or $MediaType -eq 'manga') { & "mangal" $args }
    else { Write-Host "Invalid choice. Please choose 'anime' or 'manga'." -ForegroundColor Red }
}
