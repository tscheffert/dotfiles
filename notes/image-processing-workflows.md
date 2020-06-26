
# Image Processing Workflows

## Steps roughly ordered by time

Wallpaper images are found either in packs or individuals


Image Packs are:

- Flattened
- Deduped
- sorted by orientation into folders
- manually processed to find candidate images

Individual Images are:

- Deduped
- Sorted by orientation into folders
- processed into candidate images

At this point, all candidate images are:

- Landscape orientation
- Candidates for wallpaper
- Potentially proportionate or disproportionate
- Potentially meager or ample
- Potentially watermarked

Candidate Images are sorted by ratio which results in:

- proportionate images
- disproportionate images

Disproportionate images are cropped which creates:

- (already existed) proportionate images
- porportionate images and source images

Proportionate Images from these sets are sorted by size which results in:
######################## TODO: this needs to take narrow vs short into account maybe? nah

- ample, proportionate images
- ample, proportionate images and their disproportionate source images
- meager, porportionate images
- meager, porportionate images and their disproportionate source images

Sets with Meager images have their meager images scaled which results in:

- ample, proportionate images
- ample, proportionate images and their disproportionate source images

- ample, proportionate images and their meager source images
- ample, proportionate images, their disproportionate source images, and their meager source images

Sets are then sorted by watermark which results in:

- ample, proportionate, unmarked images

- ample, proportionate, unmarked images and their disproportionate source images
- ample, proportionate, unmarked images and their meager source images
- ample, proportionate, unmarked images, their disproportionate source images, and their meager source images

- ample, proportionate, marked images and their disproportionate source images
- ample, proportionate, marked images and their meager source images
- ample, proportionate, marked images, their disproportionate source images, and their meager source images

Marked images are then shopped which results in:

- ample, proportionate, unmarked images

- ample, proportionate, unmarked images and their disproportionate source images
- ample, proportionate, unmarked images and their meager source images
- ample, proportionate, unmarked images, their disproportionate source images, and their meager source images

- ample, proportionate, unmarked images, their disproportionate source images, and their marked source images
- ample, proportionate, unmarked images, their meager source images, and their marked source images
- ample, proportionate, unmarked images, their disproportionate source images, their meager source images, and their marked source images

Image sets are then renamed in a fashion such that the sets remain tied together

- ample, proportionate, unmarked images are given a prefix.
  - Prefix is either the image category or generated for unknown categories
- Source images are named in the form of `<processed-image-name>_<adjective>-source`
  - For an example set, it could be `bella-01`, `bella-01_marked-source`, and `bella-01_disproportionate-source>`

## Processes

### Flattening

Run `flatten_image_folders` on at the root of the model name.

### Dedupe

- Use dupe guru, run it on the folder that has all the folders.

### Image Adjustments

Images are always processed in order of:

- Ratio
- Size
- Mark

and subsequent stages build on the results of previous stages.

Sorting by ratio means:

16/9 is 1.7777777

- Images that are 16:9 are _proportionate_
- Images thare are not 16:9 are _disproportionate_

Cropping means:

- Using croppola to make a disporportionate image proportionate
- Cropped image usually has the same name with ` Cropped` appended to it.
- Sometimes the suffix is ` Cropped (<digit>)` when multiple crops were required.

Sorting by size means:

- Images larger than with width > 2560 and height > 1440 are _ample_
- Images under those sizes are _meager_.
  - Meager images where the width needs to be scaled are _narrow_
    - Meaning ratio is `< 16/9`, they will be less than 1.777 for width/height
  - Meager images where the height needs to be scaled are _short_
    - Meaning ratio is `> 16/9`, they will be more than 1.777 for width/height

Scaling means:

- Using topaz gigapixel to upscale an image by

Sorting by watermark means:

- Images that are watermarked are _marked_
- Images that are not watermarked are _unmarked_


## Recommended process

- Get candidate images
- Run script to sort by ratio then by size giving us:
- Now have:
######################## TODO: continue here
```
proportionate/
├── ample/
│   ├── sample-image1.png
│   ├── sample-image2.jpeg
│   └── ...
└── meager/
     ├── sample-image1.png
     ├── sample-image2.jpeg
     └── ...

disproportionate/
├── ample/
│   ├── sample-image1.png
│   ├── sample-image2.jpeg
│   └── ...
└── meager/
     ├── sample-image1.png
     ├── sample-image2.jpeg
     └── ...
```
- Where:
  - `proportionate/ample/` is good to go
  - `proportionate/meager/` needs scaling
  - `disproportionate/ample/` needs cropping
  - `disproportionate/meager/` needs cropping and scaling
- Do the cropping, which gives us:
```
proportionate/
├── ample/
│   ├── sample-image1.png
│   ├── sample-image2.jpeg
│   └── ...
└── meager/
     ├── sample-image1.png
     ├── sample-image1-upscaled.png
     ├── sample-image2.jpeg
     ├── sample-image2-upscaled.png (upscaling converts to png)
     └── ...

disproportionate/
├── ample/
│   ├── sample-image1.png
│   ├── sample-image2.jpeg
│   └── ...
└── meager/
     ├── sample-image1.png
     ├── sample-image2.jpeg
     └── ...
```
- Do the scaling, which gives us:
- Manually sort each image set into "marked" or "unmarked", giving us:
```
proportionate/
├── ample/
│   ├── sample-image1.png
│   ├── sample-image2.jpeg
│   └── ...
└── meager/
     ├── sample-image1.png
     ├── sample-image2.jpeg
     └── ...

disproportionate/
├── ample/
│   ├── sample-image1.png
│   ├── sample-image2.jpeg
│   └── ...
└── meager/
     ├── sample-image1.png
     ├── sample-image2.jpeg
     └── ...
```
- Do the shopping
- Rename everything in

## Questions

- Should mark shopping really be done after scaling? Or will the results be better with shopping before scaling?
  - Shopping defintely after cropping, often times the mark is cropped off
