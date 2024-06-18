#setup-Auto.zip-with AutoLogin
Write-Host "sleep 30s"
Start-Sleep -s 30
$Key="HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender"
#If( -Not (Test-Path -Path "Registry::$Key") ){ New-Item -Path $Key }
New-ItemProperty -Path $Key -Name DisableAntiSpyware -Value 1 -PropertyType DWORD -Force
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
Set-ItemProperty -Path $RegPath -Name "DefaultUserName" -Value "Vagrant"
Set-ItemProperty -Path $RegPath -Name "DefaultPassword" -Value "vagrant"
Set-ItemProperty -Path $RegPath -Name "AutoAdminLogon" -Value 1
Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0
Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False
try {Remove-MpThreat} catch{Write-Host "Exception-here-Remove-MpThreat"}
Add-MpPreference -ExclusionPath c:\Auto
Add-MpPreference -ExclusionPath c:\AutoTest
$AutoZip="C:\vagrant\scripts\Auto.zip"
Expand-Archive $AutoZip -DestinationPath C:\ -Force
CD C:\Auto;cmd.exe -/c all.bat > all.txt;
Write-Host "sleep another 30s after install Automation package"
Start-Sleep -s 30
C:\Auto\play.exe telnet localhost 23 autologin
C:\Auto\play.exe telnet localhost 23 reboot
ipconfig
#Restart-Computer
Write-Host "setup-Done"