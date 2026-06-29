$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "此腳本需要管理員權限來建立軟連結，正在嘗試以管理員身分重啟..." -ForegroundColor Yellow
    # 取得目前執行腳本的參數，並以管理員權限重新開啟一個 PowerShell 視窗執行
    $arguments = "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    if ($args) { $arguments += " " + ($args -join " ") }
    Start-Process powershell -ArgumentList $arguments -Verb RunAs
    Exit
}


$env:MSYS = "winsymlinks:nativestrict"
$ErrorActionPreference = "Stop"
$BASEDIR = $PSScriptRoot
$DOTBOT_DIR = "meta/dotbot"

Set-Location $BASEDIR

$CONFIG = "meta/dotbot-configs/windows.conf.yaml"

git submodule update --init --recursive $DOTBOT_DIR


$DotbotScript = Join-Path $BASEDIR "$DOTBOT_DIR/bin/dotbot"
python3 "$DotbotScript" -d "$BASEDIR" -c "$CONFIG" $args

Read-Host "請按任意鍵繼續..."
