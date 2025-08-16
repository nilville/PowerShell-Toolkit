# PowerShell Profile - Custom Functions Collection

A comprehensive PowerShell profile script that enhances your command-line experience with useful utility functions for system administration, file management, and productivity.

## 🚀 Features

This profile includes 19 custom functions that provide shortcuts and utilities for common tasks:

### System Maintenance

- **Clear-Cache**: Clears Windows cache from multiple locations (Prefetch, Temp, IE Cache)
- **Free-Memory**: Frees up system memory using garbage collection and standby list clearing
- **sysinfo**: Displays comprehensive system information
- **Get-CPUUsage**: Shows current CPU usage percentage
- **Get-MemoryUsage**: Displays available memory in MB

### Process Management

- **pkill**: Kill processes by name (Linux-style command)
- **pgrep**: Find processes by name (Linux-style command)
- **admin**: Launch elevated PowerShell sessions with optional commands

### File Operations

- **ff**: Fast file finder - recursively search for files by name pattern
- **unzip**: Extract archives to current directory
- **nf**: Create new files quickly
- **trash**: Move files/folders to Recycle Bin safely
- **open**: Open files/folders with default applications
- **ls-date**: List files sorted by creation date

### Network & Web

- **Get-PubIP**: Get your public IP address
- **url**: Open URLs in default browser (auto-adds http:// if needed)

### System Control

- **Shutdown-PC**: Safely shutdown the computer
- **Reboot-PC**: Restart the computer
- **winutil**: Launch Chris Titus Tech's Windows Utility

### Help

- **help-profile**: Display all available custom functions with descriptions

## 📦 Installation

### Method 1: Manual Installation

1. **Find your PowerShell profile location:**

   ```powershell
   $PROFILE
   ```

2. **Create the profile directory if it doesn't exist:**

   ```powershell
   New-Item -ItemType Directory -Path (Split-Path $PROFILE) -Force
   ```

3. **Download and save the script:**

   - Download `Microsoft.PowerShell_profile.ps1` from this repository
   - Save it to your PowerShell profile location (usually `Documents\PowerShell\`)

4. **Reload your profile:**
   ```powershell
   . $PROFILE
   ```

### Method 2: Direct Download

```powershell
# Download directly to your profile location
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/[YOUR-USERNAME]/[REPO-NAME]/main/Microsoft.PowerShell_profile.ps1" -OutFile $PROFILE
```

### Method 3: Git Clone

```bash
git clone https://github.com/[YOUR-USERNAME]/[REPO-NAME].git
cd [REPO-NAME]
copy Microsoft.PowerShell_profile.ps1 $env:USERPROFILE\Documents\PowerShell\
```

## 🔧 Usage Examples

### File Management

```powershell
# Find all log files
ff "*.log"

# Create a new file
nf "test.txt"

# Move file to recycle bin
trash "oldfile.txt"

# Extract a zip file
unzip "archive.zip"
```

### System Monitoring

```powershell
# Check CPU usage
Get-CPUUsage

# Check available memory
Get-MemoryUsage

# Get system information
sysinfo
```

### Process Management

```powershell
# Kill all notepad processes
pkill notepad

# Find running Chrome processes
pgrep chrome

# Run command as administrator
admin "Get-Service"
```

### Network

```powershell
# Get your public IP
Get-PubIP

# Open a website
url "github.com"
```

### System Maintenance

```powershell
# Clear system caches
Clear-Cache

# Free up memory
Free-Memory
```

## ⚠️ Prerequisites

- **PowerShell 5.1** or **PowerShell 7+**
- **Windows 10/11** (some functions are Windows-specific)
- **Administrator privileges** may be required for some functions (Clear-Cache, Free-Memory)

## 📝 Function Reference

| Function          | Description                    | Usage                 |
| ----------------- | ------------------------------ | --------------------- |
| `Clear-Cache`     | Clears Windows cache locations | `Clear-Cache`         |
| `ff`              | Find files by name pattern     | `ff "pattern"`        |
| `Get-PubIP`       | Get public IP address          | `Get-PubIP`           |
| `winutil`         | Launch Windows utility script  | `winutil`             |
| `admin`           | Run elevated PowerShell        | `admin "command"`     |
| `unzip`           | Extract archive files          | `unzip "file.zip"`    |
| `pkill`           | Kill process by name           | `pkill "processname"` |
| `pgrep`           | Find process by name           | `pgrep "processname"` |
| `nf`              | Create new file                | `nf "filename"`       |
| `trash`           | Move to Recycle Bin            | `trash "filepath"`    |
| `sysinfo`         | Show system information        | `sysinfo`             |
| `Shutdown-PC`     | Shutdown computer              | `Shutdown-PC`         |
| `Reboot-PC`       | Restart computer               | `Reboot-PC`           |
| `open`            | Open with default app          | `open "filepath"`     |
| `Free-Memory`     | Free system memory             | `Free-Memory`         |
| `Get-CPUUsage`    | Show CPU usage                 | `Get-CPUUsage`        |
| `Get-MemoryUsage` | Show available memory          | `Get-MemoryUsage`     |
| `url`             | Open URL in browser            | `url "website.com"`   |
| `ls-date`         | List files by date             | `ls-date`             |

## 🔍 Troubleshooting

**Profile not loading?**

- Check if execution policy allows scripts: `Get-ExecutionPolicy`
- If needed, set execution policy: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`

**Function not found?**

- Reload your profile: `. $PROFILE`
- Check if profile exists: `Test-Path $PROFILE`

**Permission errors?**

- Some functions require administrator privileges
- Use the `admin` function to run elevated commands

## 🙏 Acknowledgments

- Inspired by Unix/Linux command-line utilities
- Chris Titus Tech for the Windows utility script
- PowerShell community for best practices and examples

---

⭐ **If you find this profile useful, please give it a star!** ⭐
