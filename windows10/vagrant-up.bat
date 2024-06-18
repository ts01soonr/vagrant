@echo off
echo "Clean & Prepare VM"
vagrant destroy -f
vagrant up
timeout 30
echo "reboot and autologin"
::timeout 20
::call autologin.bat
