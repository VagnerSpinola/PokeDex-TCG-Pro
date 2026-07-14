# Shared helpers for the scheduled sync scripts.

$script:Root = Split-Path $PSScriptRoot -Parent

function Start-SyncLog([string]$name) {
    $dir = Join-Path $script:Root "backend\data\logs"
    New-Item -ItemType Directory -Force $dir | Out-Null
    $log = Join-Path $dir "$($name)_$(Get-Date -Format yyyyMMdd_HHmmss).log"
    Start-Transcript -Path $log | Out-Null
    # keep only the newest 14 logs per job
    Get-ChildItem $dir -Filter "$($name)_*.log" |
        Sort-Object Name -Descending | Select-Object -Skip 14 |
        Remove-Item -Force -ErrorAction SilentlyContinue
}

function Ensure-Database {
    docker info 2>$null | Out-Null
    if ($LASTEXITCODE -ne 0) {
        Write-Output "Docker parado - iniciando Docker Desktop..."
        Start-Process "C:\Program Files\Docker\Docker\Docker Desktop.exe"
        foreach ($i in 1..60) {
            Start-Sleep -Seconds 5
            docker info 2>$null | Out-Null
            if ($LASTEXITCODE -eq 0) { break }
        }
        docker info 2>$null | Out-Null
        if ($LASTEXITCODE -ne 0) { throw "Docker nao subiu em 300s" }
    }
    Set-Location $script:Root
    docker compose up -d 2>&1 | Out-Null
    foreach ($i in 1..40) {
        $ok = docker compose ps 2>$null | Select-String "healthy"
        if ($ok) { return }
        Start-Sleep -Seconds 3
    }
    throw "Postgres nao ficou saudavel"
}

function Invoke-Etl([string]$module) {
    Set-Location $script:Root
    & (Join-Path $script:Root "backend\.venv\Scripts\python.exe") -u -m $module
    if ($LASTEXITCODE -ne 0) { throw "$module falhou (exit $LASTEXITCODE)" }
}
