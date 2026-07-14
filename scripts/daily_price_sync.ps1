# Daily price sync — scheduled task "PokeDexTCG DailyPriceSync".
# Idempotent (upserts); accumulates the price history that feeds the app's
# price charts.

. (Join-Path $PSScriptRoot "sync_common.ps1")

Start-SyncLog "price_sync"
try {
    Ensure-Database
    Invoke-Etl "etl.sync_prices"
    Write-Output "price sync OK - $(Get-Date)"
} catch {
    Write-Output "FALHOU: $_"
    exit 1
} finally {
    Stop-Transcript | Out-Null
}
