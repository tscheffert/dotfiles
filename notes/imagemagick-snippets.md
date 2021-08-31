# ImageMagick

## TODO

- Finish looking through:
<https://unix.stackexchange.com/questions/63769/fast-tool-to-generate-thumbnail-video-galleries-for-command-line>
<http://p.outlyer.net/vcs>
<https://superuser.com/questions/538112/meaningful-thumbnails-for-a-video-using-ffmpeg>

## Thumbnails Generating

### Naive

<https://unix.stackexchange.com/a/63820>

```
ffmpeg  -i MOVIE.mp4 -r 1/60 -vf scale=-1:120 -vcodec png capture-%002d.png
```

Results: Slow! Took >30 mins, maybe cause my CPU was tied up, for a 53 minute and 1.53GB movie

### Naive but Faster

Source: <https://superuser.com/a/821680>

Docs:
- <https://ffmpeg.org/ffmpeg.html#toc-Main-options>
- <https://ffmpeg.org/ffmpeg-filters.html>

PSEUDO CODE
```
for X in 1..N
  T = integer( (X - 0.5) * D / N )
  run `ffmpeg -ss <T> -i <movie> -vf select="eq(pict_type\,I)" -vframes 1 capture<X>.jpg`
```

Where:

D - video duration read from ffmpeg -i <movie> alone or ffprobe which has nice JSON output writer btw
N - total number of thumbnails you want
X - thumbnail number, from 1 to N
T - time point for tumbnail
Simply the above writes down center key-frame of each partition of the movie. E.g. if movie is 300s long and you want 3 thumbnails then it takes one key frame after 50s, 150s and 250s. For 5 thumbnails it would be 30s, 90s, 150s, 210s, 270s. You can adjust N depending on movie duration D, that e.g. 5 minute movie will have 3 thumbnails but over 1 hour will have 20 thumbnails.

Notes: This _must_ be the right way to do it. It's SOOO fast


### Smarter with scenes

From the filters examples: <https://ffmpeg.org/ffmpeg-filters.html#Examples-145>

```
ffmpeg -i video.avi -vf select='gt(scene\,0.4)',scale=-1:480,tile -frames:v 1 preview.png
```

### Smarter with other stuff

## Compositing Thumbnails

### Naive

TODO: What is this stuff

```
magick montage -title "Test" -geometry +4+4 capture*.jpg output.jpg
```
