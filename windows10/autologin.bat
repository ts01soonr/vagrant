@echo off
vagrant powershell -e -c "c:\Auto\play.exe telnet localhost 23 autologin" default
timeout 2
vagrant powershell -e -c "c:\Auto\play.exe telnet localhost 23 reboot" default