# Initialize Starship prompt
Invoke-Expression (&starship init powershell)

# Efficient system uptime function
function Get-Uptime {
    $uptime = New-TimeSpan -Start (Get-CimInstance -ClassName Win32_OperatingSystem).LastBootUpTime
    return "{0} days, {1} hours, {2} minutes, {3} seconds" -f $uptime.Days, $uptime.Hours, $uptime.Minutes, $uptime.Seconds
}