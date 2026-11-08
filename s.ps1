$ErrorActionPreference = 'Stop'
Set-Location C:\
if (-not (Test-Path 'C:\runner.zip')) {
  Invoke-WebRequest -Uri 'https://github.com/actions/runner/releases/latest/download/actions-runner-win-x64-latest.zip' -OutFile 'C:\runner.zip'
}
if (-not (Test-Path 'C:\actions-runner\config.cmd')) {
  Expand-Archive -Path 'C:\runner.zip' -DestinationPath 'C:\actions-runner' -Force
}
Set-Location 'C:\actions-runner'
.\config.cmd --unattended --url 'https://github.com/asdfxvgsbb/xiaodan-train' --token 'COGFNHNOMDETF6FUK6WYGITK6BS6S' --name 'my-cloud-server' --replace --work 'C:\actions-runner\_work'
.\run.cmd
