# Duplicates

Notes about to find duplicate files

Including:

- Photos
- Videos
- Zips of stuff (manual backups)
- Whatever else

Features that would be sweet:

- Similar images
- Similar videos
- "This entire folder is a duplicate"

## Tools

### Czkawka

- Constantly marketed on /r/datahoarder
- Actually seems pretty good


- Repository - https://github.com/qarmin/czkawka
- Files to download - https://github.com/qarmin/czkawka/releases
- Installation - https://github.com/qarmin/czkawka/blob/master/instructions/Installation.md
- Instruction - https://github.com/qarmin/czkawka/blob/master/instructions/Instruction.md

### DupeGuru

- Comes up a lot on Reddit
- I already use it
- Quick and easy for exact copy
- Supposedly a "similar" mode?

<https://dupeguru.voltaicideas.net/>

### RMLint

Looks great!

Notes:

- No official windows support
- Has an optional GUI
- Great docs
- Seems to be hashsum based

Works on:

…Duplicate Files and duplicate directories.
…Nonstripped binaries (i.e. binaries with debug symbols)
…Broken symbolic links.
…Empty files and directories.
…Files with broken user or/and group ID.

Links:

- <https://github.com/sahib/rmlint>
- <https://rmlint.readthedocs.io/en/latest/install.html>

### JDupes

- Only byte by byte exact matches, but _super fast_ apparently
- No knowledge of images, mp3s, whatever. EXIF or ID3 will cause it to not find match
- Only 100% exact matches

How to run:

```

jdupes -m
```

Options:

- `-m --summarize` for "summarize dupe information"
- `-M --printwithsummary` will print matches and `--summarize` at the end
- `-r --recurse` will process subdirectories (and recurse)
- `-z --zeromatch` will consider zero-length files to be duplicates

<https://github.com/jbruchon/jdupes>

### AllDup from Michael Thummerer

- Don't know if it's byte, hash, similar, whatever
- Freemium

<http://www.alldup.info/alldup_help/alldup.php>

### VisiPics

- "Similar image finder"
- Not updated since 2013

<http://www.visipics.info/index.php?title=Main_Page>

### AntiDupl

- Image specific tool that is based on contents of the files, finding duplicate and similar images
- "the program can find images with some types of defects"

<https://github.com/ermig1979/AntiDupl>

### AntiTwin

- From 2010 as the latest update

Features:

- Byte-by-byte comparison of user-defined files (file content)
- Search for identical or similar file names
- Pixel-based image comparison, e.g. search for similar pictures

<http://www.joerg-rosenthal.com/en/antitwin/>


### Robinhood

- Maintains a checksum database of file system and takes actions on things
- Hella complex

<https://github.com/cea-hpc/robinhood>

### GB

- Super opinionated and weird backup to Google Drive or S3 Glacier

<https://github.com/leijurv/gb>

### Easy Duplicate

- No idea what this is, some guy on reddit linked to an EXE

<https://www.reddit.com/r/DataHoarder/comments/ercor3/does_anyone_know_of_a_good_duplicate_finder_that/ff56fip/>

### Video Duplicate Finder

- Cross platform software with a gui
- Requires FFmpeg and FFprobe
- Seems that it takes a screenshot some distance into the video then compares
- Saves scans in a database, so rescans are super fast

<https://github.com/0x90d/videoduplicatefinder>

### Image Deuplicator

- Python library that seems pretty great
- Tons of different algorithms
- Documentation seems good

<https://github.com/idealo/imagededup>

### Fslint

- Linux only

<http://www.pixelbeat.org/fslint/>

### WinMerge

- For merging folders, files, and even images

<https://winmerge.org/>

### Awesome Duplicate Finder

- Compares similar images
<http://www.duplicate-finder.com/photo.html>

## Commercial Tools

### Duplicate Cleaner Pro 4 by DigitalVolcano

- Lots of people talking positively about it on Reddit
- Supports
  - Exact file match
  - Advanced filtering
  - Scan inside zip files (and others)
  - Specific modes for Images and muisc

### Duplicate Media Finder

- Commercial, for Windows
- Duplicate files from binary equality comparison
- "Similar Media Files" for Videos, Pictures, Sound
<https://duplicate-media-finder.kdo-rg.com/>

### DupeTrasher

- Written entirely in assembly, probably fast as fuck

<http://www.asmdev.net/products/dupetrasher/index.html>

### Duplicate Photos Fixer

- For photos

<https://www.duplicatephotosfixer.com/>

## Things to Ignore

- YADFR - Nothing looks any good about it
- CloneSpy - Makes some weird decisions, seems to be only exact-match, reviews were bad
- FSUM - Not really the entire gammut
- SpaceMan 99 - Only exact byte by byte
- rdfind - similar to jdupes but worse?

## Other things

- Tag based browsing for your desktop: <https://hydrusnetwork.github.io/hydrus/>
- Similar media scripts to what I've been working on: <https://github.com/raydouglass/media_management_scripts>
- Seems interesting, no idea what it would be for though... <https://github.com/boi123212321/porn-manager>
- Download all the stuff from Reddit sources: <https://github.com/shadowmoose/RedditDownloader>
- Cross-platform backup thing with deduplication built in <https://duplicacy.com/>

## Trials

Downloaded:

- AllDup
- jdupes
- VisiPics
- AntiDupl
- VideoDuplicateFinder





If you’re just looking for exact duplicates, it’s actually pretty easy to write a code to do it.

The simplest is you walk the file system and do a cryptographic hash of every file. That’s fine and easy to do but also very slow.

It turns out, you can speed it up by considering a series of necessary but not necessarily sufficient conditions that are faster to compute. You use them to narrow down the potential duplicates. On the one hand, you do more computations per file but on the other you do it on way fewer files.

For example, the following conditions are in order of what I would try to narrow it down. As you go down the list, you get more and more sure files are the same without having to test as many. Again, there is a trade off

Unique file size (super easy to test and cuts out a lot. Also, the larger the file, the less likely two non-identical files will have the same size). Far from sufficient.
Fast checksum of the first X bytes (e.g. xxhash, adler32, CRC32)
Fast checksum of the whole file (you usually could stop here but it is possible to be a false positive)
from experience, this doesn’t cut much compared to the first few kilobytes. I’ve started to skip this
Full cryptographic hash — Final step is actually sufficient. I use SHA256
I can share a rough python script that does this but it’s really not hard.

EDIT: Here is the python tool. I didn't even add a CLI. It is really barebones
<https://gist.github.com/Jwink3101/4d0edae5eae762509676913aac050049>

EDIT2: One time I posted this, I got in an argument with someone saying that they would rather compare byte-for-byte than rely on a hash function since, via the Pigeonhole principle, there must be two different files with the same SHA256 (a collision). If you want to do that, be my guest. But it is actually a lot harder since you need to do pair-wise comparisons to every potential match. (e.g. If 5 files have the same size, you now need to do 54/2=10 comparisons). And if you are concerned about two *different files having the same SHA256, you should buy some lottery tickets. Your odds are way better! (20 years from now, you may need a better hash function. Who knows? But I am not worried about it until then)
