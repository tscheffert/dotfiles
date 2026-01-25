# Overview

Man Page: <https://www.lcdf.org/gifsicle/man.html>

## Gifsicle History:

```
gifsicle --no-extensions -O3 -o weird-apes-O3.gif weird-apes.gif
gifsicle --no-extensions -O3 weird-apes.gif > weird-apes-O3.gif
gifsicle -O2 mlem.gif
gifsicle -O2 mlem.gif > mlem-o2.gif
gifsicle -O2 noooo.gif > noooooo2.gif
gifsicle -O3 -o jumping-raichu-O3 jumping-raichu.gif
gifsicle -O3 -o jumping-raichu-O3.gif jumping-raichu.gif
gifsicle -O3 mlem.gif > mlem-o3.gif
gifsicle -O3 noooo.gif > noooooo3.gif
gifsicle -O3 weird-apes.gif > weird-apes-O3.gif
gifsicle -h
gifsicle -k 20 --color-method blend-diversity -O3 -o weird-apes-k20.gif weird-apes.gif
gifsicle -k 20 --color-method median-cut -O3 -o weird-apes-k20.gif weird-apes.gif
gifsicle -k 20 --median-cut blend-diversity -O3 -o weird-apes-k20.gif weird-apes.gif
gifsicle -k 20 -O3 -o weird-apes-k20.gif weird-apes.gif
gifsicle -k 200 -O3 -o weird-apes-k200.gif weird-apes.gif
gifsicle -k 30 -O3 -o weird-apes-k200.gif weird-apes.gif
gifsicle -k 30 -O3 -o weird-apes-k30.gif weird-apes.gif
gifsicle -k 68 -O3 -o weird-apes-k200.gif weird-apes.gif
gifsicle -k 68 -O3 -o weird-apes-k68.gif weird-apes.gif
```

## Gifsicle

### Deoptimize
```
gifsicle --unoptimize your.gif > your-output.gif
```

### Resize
```
gifsicle --resize 250x250 out.gif -o smaller-out.gif
```


### Optimize
```
gifsicle -03 -o your-output.gif your.gif
```

### Transparent

> Make color transparent in the following frames. Color can be a colormap index
(0-255), a hexadecimal color specification (like "#FF00FF" for magenta), or slash-
or comma-separated red, green and blue values (each between 0 and 255).

```
gifsicle --transparent
```

### Crop


> --crop x1,y1-x2,y2
> Crop the following input frames to a smaller rectangular area. The top-left corner of this rectangle is (x1,y1); you can give either the lower-right corner, (x2,y2), or the width and height of the rectangle. In the x1,y1+widthxheight form, width and height can be zero or negative. A zero dimension means the cropping area goes to the edge of the image; a negative dimension brings the cropping area that many pixels back from the image edge. For example, --crop 2,2+-2x-2 will shave 2 pixels off each side of the input image. Cropping takes place before any rotation, flipping, resizing, or positioning.

```

gifsicle --crop x1,y1+widthxheight input.gif > output.gif
```


## ImageMagick

### Strip White Background

```
magick party_dumpster.gif -layers Coalesce -set dispose Background -fuzz 8%% -transparent White -layers optimize party_dumpster_transparent.gif
```

### Expand image canvas

```
magick party_dumpster_transparent_anim.gif -background none -gravity east -splice 2x0 resized.gif
magick resized.gif -background none -gravity west -splice 3x0 resizeder.gif
magick resizeder.gif -background none -gravity north -splice 0x3 resizederer.gif
magick resizederer.gif -background none -gravity south -splice 0x2 resizedest.gif
```
