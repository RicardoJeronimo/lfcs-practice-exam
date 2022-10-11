@echo off

REM Cygwin path
set CYGWIN=C:\cygwin64

REM Shell path
set SH=%CYGWIN%\bin\bash.exe

"%SH%" -c "/usr/local/bin/ansible-playbook-winpath.sh %*"