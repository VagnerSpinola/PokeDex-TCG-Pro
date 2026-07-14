# Weekly catalog sync — scheduled task "PokeDexTCG WeeklyCatalogSync".
# Pulls new sets/cards (delta) and adds their images to the scanner index.

. (Join-Path $PSScriptRoot "sync_common.ps1")

Start-SyncLog "catalog_sync"
try {
    Ensure-Database
    Invoke-Etl "etl.sync_cards"
    Invoke-Etl "etl.build_scan_index"
    Write-Output "catalog + scan index OK - $(Get-Date)"
} catch {
    Write-Output "FALHOU: $_"
    exit 1
} finally {
    Stop-Transcript | Out-Null
}
