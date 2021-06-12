# Image Processing Workflows

## Steps roughly ordered by time

Wallpaper images are found either in packs or individuals

Image Packs are:

- Flattened
- Deduped
- Sorted by orientation into folders
- Manually processed to find candidate images and hoist them to a single folder
- Color profile fixed

Individual Images are:

- Deduped
- Sorted by orientation into folders
- Manually processed to find candidate images
- Color profile fixed

At this point, all candidate images are:

- Contained in a single folder
- In the correct color profile, `sRGB`
- Landscape orientation
- Candidates for wallpaper
- Potentially meager or ample
- Potentially proportionate or disproportionate
- Potentially watermarked

Candidate Images are sorted by size first, which results in:

- ample images
- meager (narrow) images
- meager (short) images

Candidate Images are then scaled which results in:

- ample images
- ample images; and their meager source images

Candidate Images are then sorted by ratio which results in:

- ample, proportionate, images
- ample, proportionate, images; and their meager source images

- ample, disproportionate, images
- ample, disproportionate, images; and their meager source images

Disproportionate images are cropped which creates:

- ample, proportionate, images
- ample, proportionate, images; and their meager source images
- ample, proportionate, images; their meager source images, and their disproportionate source images

Sets are then sorted by watermark which results in:

- ample, proportionate, unmarked images

- ample, proportionate, unmarked images; and their meager source images
- ample, proportionate, unmarked images; and their disproportionate source images
- ample, proportionate, unmarked images; their meager source images, and their disproportionate source images

- ample, proportionate, marked images and their meager source images
- ample, proportionate, marked images and their disproportionate source images
- ample, proportionate, marked images; their meager source images, and their disproportionate source images

Marked images are then shopped which results in:

- ample, proportionate, unmarked images

- ample, proportionate, unmarked images; and their meager source images
- ample, proportionate, unmarked images; and their disproportionate source images
- ample, proportionate, unmarked images; their meager source images, and their disproportionate source images

- ample, proportionate, unmarked images; their meager source images, and their marked source images
- ample, proportionate, unmarked images; their disproportionate source images, and their marked source images
- ample, proportionate, unmarked images; their meager source images, their disproportionate source images, and their marked source images

Image sets are then renamed in a fashion such that the sets remain tied together

- ample, proportionate, unmarked images are given a prefix.
  - Prefix is either the image category or generated for unknown categories
- Source images are named in the form of `<processed-image-name>_<adjective>-source`
  - For an example set, it could be `bella-01`, `bella-01_marked-source`, and `bella-01_disproportionate-source`
  - Adjectives are always `meager` before `disproportionate` before `marked`
    - Good: `bella-01_meager-marked-source`
    - Bad: `bella-01_disproportionate-meager-source`

## Processes

### Flattening

Run `flatten_image_folders` on at the root of the model name.

### Dedupe

Use dupe guru, run it on the folder that has all the folders.

### Sort by orientation into folders

Use `sort_images_in_folders_by_orientation` when there are many folders with images in them, such as after downloading a pack. Run it in the folder containing all the subdirectories with images.

Use `sort_images_by_orientation` when there is just one folder with images in it. Run it in the folder with images.

### Color Profile Fixing

Run `fix_color_profile` in the folder with images we want to fix

### Image Adjustments

Images are always processed in order of:

- Size
- Ratio
- Mark

Subsequent stages build on the results of previous stages.

Sorting by ratio means:

16/9 is 1.7777777

- Images that are 16:9 are _proportionate_
- Images that are not 16:9 are _disproportionate_

Cropping means:

- Using croppola to make a disproportionate image proportionate
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

- Dedupe
- Sort by orientation (landscape or portrait)
- Find candidate images
- Fix color profiles
- Run script to sort by ratio then by size giving us:
  ```
  ample/
  ├── sample-image1.png
  ├── sample-image2.jpeg
  └── ...
  meager/
  ├── sample-image3.png
  ├── sample-image4.jpeg
  └── ...
  ```
- Then scale:
  ```
  root/
  ├── sample-image1.png
  ├── sample-image2.jpeg
  ├── sample-image3.png
  ├── sample-image3-meager-source.png
  ├── sample-image4.jpeg
  ├── sample-image4-meager-source.jpeg
  └── ...
  ```
- Then run script that sorts by ratio:
```
  proportionate/
  ├── sample-image1.png
  ├── sample-image3.png
  ├── sample-image3-meager-source.png
  └── ...
  disproportionate/
  ├── sample-image2.jpeg
  ├── sample-image4.jpeg
  ├── sample-image4-meager-source.jpeg
  └── ...
```
  - Where:
    - `proportionate/` are good to go
    - `disproportionate/` require cropping
- Then crop disproportionate images:
  ```
  root/
  ├── sample-image1.png
  ├── sample-image2.jpeg
  ├── sample-image2-disproportionate-source.jpeg
  ├── sample-image3.png
  ├── sample-image3-meager-source.png
  ├── sample-image4.jpeg
  ├── sample-image4-meager-disproportionate-source.jpeg
  └── ...
  ```
- Manually sort each image set into "marked" or "unmarked", giving us:
```
  unmarked/
  ├── sample-image1.png
  ├── sample-image2.jpeg
  ├── sample-image2-disproportionate-source.jpeg
  marked/
  ├── sample-image3.png
  ├── sample-image3-meager-source.png
  ├── sample-image4.jpeg
  ├── sample-image4-meager-disproportionate-source.jpeg
  └── ...
```
- Do the shopping, giving us:
```
  root/
  ├── sample-image1.png
  ├── sample-image2.jpeg
  ├── sample-image2-disproportionate-source.jpeg
  ├── sample-image3.png
  ├── sample-image3-meager-marked-source.png
  ├── sample-image4.jpeg
  ├── sample-image4-meager-disproportionate-marked-source.jpeg
  └── ...
```
- Then do the renaming and moving to destination folders

## Questions

- Should mark shopping really be done after scaling? Or will the results be better with shopping before scaling?
  - Shopping definitely after cropping, often times the mark is cropped off
