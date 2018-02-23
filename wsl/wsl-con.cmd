@echo off

rem Based this off of the wsl-con.cmd in the ConEmu install and the ConEmu
rem documentation: ttps://conemu.github.io/en/BashOnWindows.html#true-color-example

rem I have no idea why this needs to be in a batch cmd file to work, starting
rem conemu-cyg-64.exe directly didn't result in a working 256 colors for some reason.

ConEmuC -osverinfo > nul
if errorlevel 2560 (
  rem Windows 10 detected, OK
) else (
  call cecho "Windows 10 is required"
  exit /b 100
)

if not exist "%windir%\system32\bash.exe" (
  call cecho "Windows subsystem for linux was not installed!"
  call cecho "https://conemu.github.io/en/BashOnWindows.html#TLDR"
  exit /b 100
)
pushd .
chdir "%ConEmuBaseDirShort%\wsl"

setlocal

if exist "%CD%\wslbridge-backend" goto wsl_ready

call cecho /yellow "wslbridge is not installed! download latest ConEmu distro"
goto err

:wsl_ready
cd /d "%CD%"
set "PATH=%CD%;%PATH%"
call SetEscChar
echo %ESC%[9999H
popd
"%ConEmuBaseDirShort%\conemu-cyg-64.exe" --wsl -t bash --login -i
goto :EOF

:err
call cecho "wslbridge-backend was not installed properly"
timeout 10
exit /b 1
goto :EOF
