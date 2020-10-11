# Image Processing Colorprofiles

## Problem

Some times when I run something through croppola or lossless optimization, the colors look different afterwards.

## Summary

This is because of the different icc colorprofiles on a given image. Basically we want it to be in `sRGBv2`. In PhotoShop that's the `sRGB IEC61966-2.1` profile.

We'll use ImageMagick to identify files which aren't in the correct profile and convert them. The goal being, we can strip all the exif and embedded profiles (making it smaller) and it will look the same.

Unknown whether we want "Use Dither" or "use BlackPoint Compensation".

## Notes

References

- http://www.imagemagick.org/Usage/scripts/convert_any2srgb
- Get actual .icc files http://www.color.org/srgbprofiles.xalter


Found a profile:

```
>>> magick identify -format "%[profile:icc]" 1_015.jpeg
Adobe RGB (1998)%
```

Didn't find a profile:

```
>>> magick identify -format "%[profile:icc]" 1_015\ Cropped.jpg
identify: unknown image property "%[profile:icc]" @ warning/property.c/InterpretImageProperties/4101.
# Is the output stdout or stderr?
>>> magick identify -format "%[profile:icc]" 1_015\ Cropped.jpg 1>/dev/null
identify: unknown image property "%[profile:icc]" @ warning/property.c/InterpretImageProperties/4101.
# It's stderr, we silenced stderr
```

Note that both of those have an exit status of 0 still.

```
magick convert ./1_015\ Cropped.jpg -profile ./sRGB2014.icc -colorspace sRGB 1_015-cropped-v2.jpeg
```
