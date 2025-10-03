param(
    [Parameter(Mandatory=$true)]
    [string]$TargetDrive
)

# Extended list of known wallet filenames and types
$KnownWalletFiles = @(
    "wallet.dat",       # Bitcoin Core, Litecoin Core, Dogecoin Core
    "keystore.json",    # Ethereum (Geth, Parity), Metamask backups
    "mbhd.wallet.aes",  # MultiBit HD
    "electrum.dat",     # Electrum backups (older versions)
    "electrum.sqlite",  # Electrum backups (newer versions)
    "keyfile",          # Various wallets (e.g., Exodus backups)
    "data.ldb",         # LevelDB databases (can contain wallets, e.g., Coinomi Desktop)
    "leveldb",          # Directory name for LevelDB databases (searched implicitly below)
    "wallet.bin",       # Various older wallets
    "master.key",       # Key file (e.g., Jaxx)
    "secret_keys",      # File or directory name for private keys
    "mnemonic.txt",     # Manually saved seed words (text file)
    "seed.txt",         # Alternative seed backup
    "private.key"       # Raw private key files
)

# Check if the target exists
if (-not (Test-Path -Path $TargetDrive -PathType Container)) {
    Write-Host "ERROR: The drive '$TargetDrive' does not exist." -ForegroundColor Red
    exit 1
}

Write-Host "Starting extended search for Wallet files on: $TargetDrive ..." -ForegroundColor Cyan
Write-Host "---"

# Start search for files and directories
$foundFiles = Get-ChildItem -Path $TargetDrive -Recurse -Force -ErrorAction SilentlyContinue |
    Where-Object { 
        $name = $_.Name.ToLower()
        # Check for matching filenames OR matching directory names (like 'leveldb')
        $name -in $KnownWalletFiles -or 
        ($_.PSIsContainer -and $name -in $KnownWalletFiles) 
    } |
    Select-Object -ExpandProperty FullName

Write-Host "---"

# Output summary
if ($foundFiles.Count -gt 0) {
    Write-Host "INFO: $($foundFiles.Count) potential Wallet files and directories found:" -ForegroundColor Green
    $foundFiles | ForEach-Object {
        Write-Host "- $_" -ForegroundColor Green
    }
}
else {
    Write-Host "INFO: No known Wallet files or directories found." -ForegroundColor Yellow
}