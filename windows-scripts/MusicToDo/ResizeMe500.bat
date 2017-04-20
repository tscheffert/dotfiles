ren *.jpeg *.jpg
ren *.jpg Cov.jpg
cscript resize_image.wsf /indir:"%~dp0" /outdir:"%~dp0\Cov" /width:500 /height:500
//del *.jpg
move "%~dp0\Cov\Cov.jpg" "%~dp0"
rd "%~dp0\Cov"
del "resize_image.wsf"
del "ResizeMe500.bat"