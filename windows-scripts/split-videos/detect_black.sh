ffmpeg="/c/tools/ffmpeg-3.2.4-win64-static/bin/ffmpeg.exe"
video="???"
"$ffmpeg" -i "$video" -vf blackdetect=d=2:pic_th=0.98:pix_th=0.15 -an -f null -
