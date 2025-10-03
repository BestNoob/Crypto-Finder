param(
    [Parameter(Mandatory=$true)]
    [string]$TargetDrive
)

# Extended list of specific Executable names of mining software
$KnownMinerExecutables = @(
    "t-rex.exe",          # T-Rex Miner (NVIDIA)
    "PhoenixMiner.exe",   # Phoenix Miner (Legacy ETH)
    "xmrig.exe",          # XMRig (CPU/Monero)
    "nbminer.exe",        # NBMiner (Multi-Algo)
    "gminer.exe",         # GMiner (Multi-Algo)
    "lolminer.exe",       # LolMiner (Multi-Algo)
    "bzminer.exe",        # BZMiner
    "ethminer.exe",       # Older Ethereum Miner
    "ccminer.exe",        # Generic NVIDIA Miner
    "cgminer.exe",        # Generic ASIC/FPGA/GPU Miner
    "sgminer.exe",        # Generic AMD Miner
    "nicehashminer.exe"   # NiceHash
)

# List of specific configuration and batch files (crucial for finding wallet addresses)
$KnownConfigFiles = @(
    "config.json",        # General configuration (XMRig, NBMiner, etc.)
    "start.bat",          # Generic start scripts
    "mine.bat",           # Specific mining start script
    "pool.txt",           # Mining pool address configuration
    "pools.json",         # Extended pool configuration
    "miner_conf.ini",     # Specific configuration files
    "user_config.txt",    # Specific NiceHash config
    "settings.ini"        # General miner settings
)

# Combine all file types for the search
$SearchFiles = $KnownMinerExecutables + $KnownConfigFiles

# Check if the target exists
if (-not (Test-Path -Path $TargetDrive -PathType Container)) {
    Write-Host "ERROR: The drive '$TargetDrive' does not exist." -ForegroundColor Red
    exit 1
}

Write-Host "Starting extended search for Mining Software on: $TargetDrive ..." -ForegroundColor Cyan
Write-Host "---"

# Start search
$foundFiles = Get-ChildItem -Path $TargetDrive -Recurse -Force -ErrorAction SilentlyContinue |
    Where-Object { $_.PSIsContainer -eq $false -and $SearchFiles -contains $_.Name.ToLower() } |
    Select-Object -ExpandProperty FullName

Write-Host "---"

# Output summary
if ($foundFiles.Count -gt 0) {
    Write-Host "INFO: $($foundFiles.Count) potential mining-related files found:" -ForegroundColor Green
    $foundFiles | ForEach-Object {
        Write-Host "- $_" -ForegroundColor Green
    }
}
else {
    Write-Host "INFO: No known mining programs or configuration files found." -ForegroundColor Yellow
}
