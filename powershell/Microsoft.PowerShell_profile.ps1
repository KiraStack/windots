# Constants
$Global:EnableShowHeader = $true  # Global toggle for showing header automatically

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

# Define the ASCII gradient function
function show-header {
    $lines = @'
       _             _       __ 
  __ _| |__   ___ __| | ___ / _|
 / _` | '_ \ / __/ _` |/ _ \ |_ 
| (_| | |_) | (_| (_| |  __/  _|
 \__,_|_.__/ \___\__,_|\___|_|
'@ -split "`n"

    function Convert($hue) {
        $saturation = 0.4
        $brightness = 0.9
        $chroma = $brightness * $saturation
        $factor = $chroma * (1 - [math]::Abs((($hue / 60) % 2) - 1))
        $match = $brightness - $chroma

        if      ($hue -lt 60)  { $red, $green, $blue = $chroma, $factor, 0 }
        elseif  ($hue -lt 120) { $red, $green, $blue = $factor, $chroma, 0 }
        elseif  ($hue -lt 180) { $red, $green, $blue = 0, $chroma, $factor }
        elseif  ($hue -lt 240) { $red, $green, $blue = 0, $factor, $chroma }
        elseif  ($hue -lt 300) { $red, $green, $blue = $factor, 0, $chroma }
        else                    { $red, $green, $blue = $chroma, 0, $factor }

        $red   = [math]::Round(($red   + $match) * 255)
        $green = [math]::Round(($green + $match) * 255)
        $blue  = [math]::Round(($blue  + $match) * 255)

        return "$red;$green;$blue"
    }

    $max_pos = $lines.Length + ($lines | Measure-Object -Property Length -Maximum).Maximum

    for ($row = 0; $row -lt $lines.Length; $row++) {
        $line = $lines[$row]

        for ($column = 0; $column -lt $line.Length; $column++) {
            $pos = $row + $column
            $hue = ($pos / $max_pos) * 360
            $color = Convert $hue
            Write-Host -NoNewline "$([char]27)[38;2;${color}m$($line[$column])"
        }
        Write-Host "$([char]27)[0m"
    }
}

# Override Clear-Host to show header after clearing
function Clear-Host {
    # Clear the console
    [System.Console]::Clear()

    # Display the ASCII header if enabled
    if ($Global:EnableShowHeader) {
        show-header
    }
}

# Call show-header on startup only if enabled
if ($Global:EnableShowHeader) {
    show-header
}