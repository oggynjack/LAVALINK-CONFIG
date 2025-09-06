# Start Lavalink with IPv4 preference
# Usage:
# 1) Run in foreground (interactive): .\start-lavalink.ps1 -Foreground
# 2) Run in background (detached): .\start-lavalink.ps1 -Background
# The script forces the JVM to prefer IPv4 via -Djava.net.preferIPv4Stack=true

param(
    [switch]$Background,
    [switch]$Foreground
)

$cwd = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $cwd

# Common JVM args
$javaArgs = @('-Djava.net.preferIPv4Stack=true','-jar','Lavalink.jar')

if ($Background) {
    if (-not (Test-Path '.\logs')) { New-Item -ItemType Directory -Path '.\logs' | Out-Null }
    Start-Process -FilePath java -ArgumentList $javaArgs -WorkingDirectory $cwd -RedirectStandardOutput '.\logs\lavalink_out.log' -RedirectStandardError '.\logs\lavalink_err.log' -NoNewWindow
    Write-Output "Lavalink started in background; logs: $cwd\logs\lavalink_out.log"
    exit 0
}

# Default to foreground if no switch provided
Write-Output "Starting Lavalink in foreground (IPv4 preferred)..."
& java @javaArgs

if ($LASTEXITCODE -ne 0) {
    Write-Error "Lavalink exited with code $LASTEXITCODE"
}