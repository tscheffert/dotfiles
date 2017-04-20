### Options __________________________________________________________________________________________________________
$ffmpeg = "C:\tools\ffmpeg-3.2.4-win64-static\bin\ffmpeg.exe" # Set path to your ffmpeg.exe
$folder = ".\*"              # Set path to your video folder; '\*' must be appended
$filter = @("*.mov","*.mp4")        # Set which file extensions should be processed

### Main Program ______________________________________________________________________________________________________

foreach ($video in dir $folder -include $filter -exclude "*_???.*" -r){

  ### Set path to logfile
  $logfile = "$($video.FullName)_ffmpeg.log"

  ### Read in all cutpoints from *_cutpoints.csv; concat to string e.g "00:03:23.014,00:06:32.289,..."
  $cuts = ( Import-Csv "$($video.FullName)_cutpoints.csv" | % {$_.cut} ) -join ","

  ### put together the correct new name, "%03d" is a generic number placeholder for ffmpeg
  $output = $video.directory.Fullname + "\" + $video.basename + "_%03d" + $video.extension

  ### use ffmpeg to split current video in parts according to their cut points
  & $ffmpeg -i $video -f segment -segment_times $cuts -c copy -map 0 $output 2> $logfile
}
