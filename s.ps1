$ErrorActionPreference = 'Continue'
Set-Location C:\
if (-not (Test-Path 'C:\runner.zip')) {
  Write-Host '[1/4] 下载 runner (逐个试镜像源)...'
  $cands = @(
    'https://github.com/actions/runner/releases/latest/download/actions-runner-win-x64-latest.zip',
    'https://ghproxy.net/https://github.com/actions/runner/releases/latest/download/actions-runner-win-x64-latest.zip',
    'https://ghfast.top/https://github.com/actions/runner/releases/latest/download/actions-runner-win-x64-latest.zip',
    'https://gh-proxy.com/https://github.com/actions/runner/releases/latest/download/actions-runner-win-x64-latest.zip',
    'https://ghproxy.cc/https://github.com/actions/runner/releases/latest/download/actions-runner-win-x64-latest.zip',
    'https://mirror.ghproxy.com/https://github.com/actions/runner/releases/latest/download/actions-runner-win-x64-latest.zip',
    'https://gh.llkk.cc/https://github.com/actions/runner/releases/latest/download/actions-runner-win-x64-latest.zip'
  )
  $ok = $false
  foreach ($u in $cands) {
    try {
      Write-Host "  尝试: $u"
      Invoke-WebRequest -Uri $u -OutFile 'C:\runner.zip' -TimeoutSec 180
      if ((Get-Item 'C:\runner.zip').Length -gt 50MB) { $ok = $true; Write-Host '  OK 下载成功'; break }
      else { Write-Host '  文件太小,跳过'; Remove-Item 'C:\runner.zip' }
    } catch { Write-Host "  失败: $($_.Exception.Message.Substring(0,[Math]::Min(80,$_.Exception.Message.Length)))" }
  }
  if (-not $ok) { Write-Host '全部源失败,请检查网络'; exit 1 }
}
if (-not (Test-Path 'C:\actions-runner\config.cmd')) {
  Write-Host '[2/4] 解压 runner...'
  Expand-Archive -Path 'C:\runner.zip' -DestinationPath 'C:\actions-runner' -Force
}
Set-Location 'C:\actions-runner'
Write-Host '[3/4] 注册到 xiaodan-train...'
.\config.cmd --unattended --url 'https://github.com/asdfxvgsbb/xiaodan-train' --token 'COGFNHNOMDETF6FUK6WYGITK6BS6S' --name 'my-cloud-server' --replace --work 'C:\actions-runner\_work'
Write-Host '[4/4] 启动 runner...'
.\run.cmd
