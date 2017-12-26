ffmpeg="/c/tools/ffmpeg-3.2.4-win64-static/bin/ffmpeg.exe"
video="$1"
"$ffmpeg" -i "$video" -vf blackdetect=d=1:pic_th=0.85:pix_th=0.15 -an -f null -
