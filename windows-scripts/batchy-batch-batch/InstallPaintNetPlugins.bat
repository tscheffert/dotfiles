:: Install Paint.Net Plugins
:: %~dp0 expands to the directory the batch file is run in, so you don't have to worry about current/working directory
xcopy "%~dp0Plugins\IcoCur.dll" "C:\Program Files\Paint.NET\FileTypes\" /s /i
pause
