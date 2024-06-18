#setup-Auto.zip
$Key="HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender"
If( -Not (Test-Path -Path "Registry::$Key") ){ New-Item -Path $Key }
New-ItemProperty -Path $Key -Name DisableAntiSpyware -Value 1 -PropertyType DWORD -Force
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
Set-ItemProperty -Path $RegPath -Name "DefaultUserName" -Value "Vagrant"
Set-ItemProperty -Path $RegPath -Name "DefaultPassword" -Value "vagrant"
Set-ItemProperty -Path $RegPath -Name "AutoAdminLogon" -Value 1
Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0
Set-NetFirewallProfile -Profile Domain, Public, Private -Enabled False
#try {Remove-MpThreat} catch { Write-Host "Exception-here-Remove-MpThreat" }
Add-MpPreference -ExclusionPath c:\Auto
Add-MpPreference -ExclusionPath c:\AutoTest
$AutoZip="C:\vagrant\scripts\Auto.zip"
Expand-Archive $AutoZip -DestinationPath C:\ -Force
cd C:\Auto;cmd.exe -/c all.bat > all.txt;
Start-Sleep -s 15
try {C:\Auto\autologon.exe vagrant vagrant vagrant -accepteula} catch{ Write-Host "Exception-here-AutoLogon"}
try {C:\Auto\play.exe telnet localhost 23 reboot} catch{ Write-Host "Exception-here-reboot"}
ipconfig
#Restart-Computer
Write-Host "setup-Done"