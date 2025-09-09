<# oh-my-posh.exe --init --shell pwsh --config "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/sonicboom_dark.omp.json" | Invoke-Expression #>
<# oh-my-posh.exe --init --shell pwsh --config "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/clean-detailed.omp.json" | Invoke-Expression #>
<# oh-my-posh.exe --init --shell pwsh --config "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/lambdageneration.omp.json" | Invoke-Expression #>
<# oh-my-posh.exe --init --shell pwsh --config "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/gruvbox.omp.json" | Invoke-Expression #>
<# oh-my-posh.exe --init --shell pwsh --config "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/kali.omp.json" | Invoke-Expression #>
<# oh-my-posh.exe --init --shell pwsh --config "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/pure.omp.json" | Invoke-Expression #>
<# oh-my-posh.exe --init --shell pwsh --config "https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/patriksvensson.omp.json" | Invoke-Expression #>
<# oh-my-posh.exe --init --shell pwsh --config "https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/catppuccin_mocha.omp.json" | Invoke-Expression #>
<# oh-my-posh.exe --init --shell pwsh | Invoke-Expression #>

#------------enable one of the above themes by uncommenting it------------#

function Clear-Cache {
    Write-Host "Clearing cache..." -ForegroundColor Cyan

    Write-Host "Clearing Windows Prefetch..." -ForegroundColor Yellow
    Remove-Item -Path "$env:SystemRoot\Prefetch\*" -Force -ErrorAction SilentlyContinue

    Write-Host "Clearing Windows Temp..." -ForegroundColor Yellow
    Remove-Item -Path "$env:SystemRoot\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

    Write-Host "Clearing User Temp..." -ForegroundColor Yellow
    Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

    Write-Host "Clearing Internet Explorer Cache..." -ForegroundColor Yellow
    Remove-Item -Path "$env:LOCALAPPDATA\Microsoft\Windows\INetCache\*" -Recurse -Force -ErrorAction SilentlyContinue

    Write-Host "Cache clearing completed." -ForegroundColor Green
}

function ff($name) {
    Get-ChildItem -recurse -filter "*${name}*" -ErrorAction SilentlyContinue | ForEach-Object {
        Write-Output "$($_.FullName)"
    }
}

function winutil {
	irm https://christitus.com/win | iex
}

function admin {
    if ($args.Count -gt 0) {
        $argList = $args -join ' '
        Start-Process wt -Verb runAs -ArgumentList "pwsh.exe -NoExit -Command $argList"
    } else {
        Start-Process wt -Verb runAs
    }
}

function unzip ($file) {
    Write-Output("Extracting", $file, "to", $pwd)
    $fullFile = Get-ChildItem -Path $pwd -Filter $file | ForEach-Object { $_.FullName }
    Expand-Archive -Path $fullFile -DestinationPath $pwd
}

function pkill($name) {
    Get-Process $name -ErrorAction SilentlyContinue | Stop-Process
}

function pgrep($name) {
    Get-Process $name
}

function nf { param($name) New-Item -ItemType "file" -Path . -Name $name }

function trash($path) {
    $fullPath = (Resolve-Path -Path $path).Path

    if (Test-Path $fullPath) {
        $item = Get-Item $fullPath

        if ($item.PSIsContainer) {
            $parentPath = $item.Parent.FullName
        } else {
            $parentPath = $item.DirectoryName
        }

        $shell = New-Object -ComObject 'Shell.Application'
        $shellItem = $shell.NameSpace($parentPath).ParseName($item.Name)

        if ($item) {
            $shellItem.InvokeVerb('delete')
            Write-Host "Item '$fullPath' has been moved to the Recycle Bin."
        } else {
            Write-Host "Error: Could not find the item '$fullPath' to trash."
        }
    } else {
        Write-Host "Error: Item '$fullPath' does not exist."
    }
}

function sysinfo { Get-ComputerInfo }

function Shutdown-PC {
    Write-Host "Shutting down the computer..." -ForegroundColor Red
    Stop-Computer -Force
}

function Reboot-PC {
    Write-Host "Rebooting the computer..." -ForegroundColor Yellow
    Restart-Computer -Force
}

function open($path) {
    if (Test-Path $path) {
        Start-Process -FilePath $path
        Write-Host "Opening '$path' with the default application." -ForegroundColor Green
    } else {
        Write-Host "Error: Path '$path' does not exist." -ForegroundColor Red
    }
}

function Free-Memory {
    Write-Host "Freeing up memory..." -ForegroundColor Cyan

    Write-Host "Clearing Standby List..." -ForegroundColor Yellow
    if (Get-Command -Name "Clear-MemoryStandbyList" -ErrorAction SilentlyContinue) {
        Clear-MemoryStandbyList
    } else {
        Write-Host "Clear-MemoryStandbyList command not found. Attempting to use alternative methods..."
        [System.GC]::Collect()
        [System.GC]::WaitForPendingFinalizers()
        [System.GC]::Collect()
    }

    Write-Host "Memory cleanup completed." -ForegroundColor Green
}

function pc-usage {
    # Get CPU usage
    $cpu = Get-Counter '\Processor(_Total)\% Processor Time'
    $cpuUsage = [math]::Round($cpu.CounterSamples.CookedValue, 2)

    # Get memory usage
    $os = Get-CimInstance Win32_OperatingSystem
    $totalMem = $os.TotalVisibleMemorySize
    $freeMem = $os.FreePhysicalMemory
    $usedMem = $totalMem - $freeMem
    $memUsagePercent = [math]::Round(($usedMem / $totalMem) * 100, 2)

    Write-Host "CPU Usage: $cpuUsage%" -ForegroundColor Green
    Write-Host "RAM Usage: $memUsagePercent%" -ForegroundColor Green
}

function url {
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$url
    )
    if ($url -notmatch '^[a-zA-Z][a-zA-Z0-9+\-.]*://') {
        $url = "http://$url"
    }
    Start-Process $url
}

function ls-date {
    param(
        [string]$Path = "."
    )
    Get-ChildItem -Path $Path | Sort-Object CreationTime | Format-Table Name, CreationTime, Length, Mode
}

function help-profile {
    Write-Host "Available Custom Functions:" -ForegroundColor Cyan
    Write-Host "1. Clear-Cache: Clears various cache locations." -ForegroundColor Yellow
    Write-Host "2. ff: Finds files matching a name." -ForegroundColor Yellow
    Write-Host "3. Get-PubIP: Retrieves the public IP address." -ForegroundColor Yellow
    Write-Host "4. winutil: Downloads and executes a script from christitus.com." -ForegroundColor Yellow
    Write-Host "5. admin: Runs a command in an elevated PowerShell window." -ForegroundColor Yellow
    Write-Host "6. unzip: Unzips a file in the current directory." -ForegroundColor Yellow
    Write-Host "7. pkill: Kills a process by name." -ForegroundColor Yellow
    Write-Host "8. pgrep: Gets a process by name." -ForegroundColor Yellow
    Write-Host "9. nf: Creates a new file." -ForegroundColor Yellow
    Write-Host "10. trash: Moves a file or directory to the Recycle Bin." -ForegroundColor Yellow
    Write-Host "11. sysinfo: Displays system information." -ForegroundColor Yellow
    Write-Host "12. Shutdown-PC: Shuts down the computer." -ForegroundColor Yellow
    Write-Host "13. Reboot-PC: Reboots the computer." -ForegroundColor Yellow
    Write-Host "14. open: Opens a file or directory with the default application." -ForegroundColor Yellow
    Write-Host "15. Free-Memory: Frees up memory." -ForegroundColor Yellow
    Write-Host "16. pc-usage: Displays current CPU and RAM usage." -ForegroundColor Yellow
    Write-Host "17. url: Opens a URL in your default browser." -ForegroundColor Yellow
    Write-Host "18. ls-date: Lists files sorted by creation date." -ForegroundColor Yellow
}
