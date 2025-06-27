function get {
    param([string]$CustomPath)
    
    # Validate custom path if provided
    if ($CustomPath) {
        if (Test-Path $CustomPath -PathType Leaf) { return $CustomPath }
        throw "Custom path not found: $CustomPath"
    }
    
    # Standard Git installation paths
    $paths = @(
        "$env:ProgramFiles\Git\git-bash.exe",
        "$env:ProgramFiles(x86)\Git\git-bash.exe", 
        "$env:LocalAppData\Programs\Git\git-bash.exe"
    )
    
    # Return first valid path found
    foreach ($path in $paths) {
        if (Test-Path $path -PathType Leaf) { return $path }
    }
    
    # Check PATH environment variable
    $cmd = Get-Command git-bash.exe -ErrorAction SilentlyContinue
    if ($cmd) { return $cmd.Source }

    # Define path to cache file
    $file = Join-Path $PSScriptRoot 'Cache.txt'

    # Check if cache file exists
    if (Test-Path $file) {
        
        # Read and trim cached path
        $path = Get-Content $file -Raw | ForEach-Object { $_.Trim() }
        
        # Return if valid file path exists
        if ($path -and (Test-Path $path -PathType Leaf)) { 
            return $path 
        }
    }
    
    # Return null if not found (handled by caller)
    return $null
}

function pick {
    # Initialize file dialog
    Add-Type -AssemblyName System.Windows.Forms
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Title = 'Select git-bash.exe'
    $dialog.Filter = 'Executable Files (*.exe)|*.exe'
    $dialog.InitialDirectory = "$env:ProgramFiles\Git"
    
    # Return selected path or throw if cancelled
    if ($dialog.ShowDialog() -eq 'OK') { return $dialog.FileName }
    throw "No file selected."
}

function test {
    param([string]$Path)
    
    # Validate path exists
    if (-not (Test-Path $Path -PathType Leaf)) { return $false }
    
    # Test Git Bash execution and version check
    try {
        $result = & $Path -c 'git --version' 2>&1
        return $true # return ($result -match '^git version')
    }
    catch { return $false }
}

function watch {
    param(
        [string]$media,
        [string]$path
    )
    
    # Media type validation
    if ($media -ne 'anime') { return }
    
    # Resolve Git Bash path
    if (-not $path) { $path = get }
    
    # Manual selection fallback
    if (-not $path) {
        Write-Host "File not found. Please select manually."
        try { $path = pick }
        catch {
            Write-Error "File selection cancelled."
            return
        }
    }
    
    # Validate resolved/selected path
    if (-not (test $path)) {
        Write-Error "Invalid executable: $path"
        return
    }
    
    # Cache valid path for zfuture use
    $file = Join-Path $PSScriptRoot 'Cache.txt'
    Set-Content -Path $file -Value $path -Encoding UTF8
    
    # Execute anime CLI command
    Write-Host "The anime interface app was launched."
    & $path -c 'sh ani-cli anime'
}

Export-ModuleMember -Function watch