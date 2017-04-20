set folder="M:\Music"
cd /d %folder%
for /f "delims=" %%G in ('dir /b /s /ah *.jpg') do (if not "%%G" == "Cov.*" del "%%G" /s /ah)
