@echo off
echo "Clean & Prepare VM"
vagrant destroy -f
vagrant up
timeout 30
echo "Turn On AutoLogin and reboot"
vagrant powershell -e -c "c:\Auto\Autologon.exe vagrant vagrant vagrant -accepteula" default
vagrant powershell -e -c "c:\Auto\play.exe telnet localhost 23 reboot" default