$ErrorActionPreference = 'Stop'
Set-Location C:\
if (-not (Test-Path 'C:\runner.zip')) {
  Write-Host "[1/4] 下载 runner (CDN 镜像)..."
  Invoke-WebRequest -Uri 'https://gcore.jsdelivr.net/gh/actions/runner@latest/download/actions-runner-win-x64-latest.zip' -OutFile 'C:\runner.zip'
}
if (-not (Test-Path 'C:\actions-runner\config.cmd')) {
  Write-Host "[2/4] 解压..."
  Expand-Archive -Path 'C:\runner.zip' -DestinationPath 'C:\actions-runner' -Force
}
Set-Location 'C:\actions-runner'
Write-Host "[3/4] 注册..."
.\config.cmd --unattended --url 'https://github.com/asdfxvgsbb/xiaodan-train' --token 'COGFNHNOMDETF6FUK6WYGITK6BS6S' --name 'my-cloud-server' --replace --work 'C:\actions-runner\_work'
Write-Host "[4/4] 启动 runner..."
.\run.cmd
