### Options __________________________________________________________________________________________________________
$ffmpeg = "C:\tools\ffmpeg-3.2.4-win64-static\bin\ffmpeg.exe" # Set path to your ffmpeg.exe
$folder = ".\*"              # Set path to your video folder; '\*' must be appended
$filter = @("*.mov","*.mp4")        # Set which file extensions should be processed
$dur = 2                            # Set the minimum detected black duration (in seconds)
$pic = 0.98                         # Set the threshold for considering a picture as "black" (in percent)
$pix = 0.15                         # Set the threshold for considering a pixel "black" (in luminance)

### Main Program ______________________________________________________________________________________________________

foreach ($video in dir $folder -include $filter -exclude "*_???.*" -r){

  ### Set path to logfile
  $logfile = Get-Item -LiteralPath "$($video.FullName)_ffmpeg.log"

  ### analyse each video with ffmpeg and search for black scenes
  & $ffmpeg -i $video -vf blackdetect=d=`"$dur`":pic_th=`"$pic`":pix_th=`"$pix`" -an -f null - 2> $logfile

  ### Use regex to extract timings from logfile
  $report = @()
  Select-String 'black_start:.*black_end:' $logfile | % {
    $black          = "" | Select  start, end, cut

    # extract start time of black scene
    $start_s     = $_.line -match '(?<=black_start:)\S*(?= black_end:)'    | % {$matches[0]}
    $start_ts    = [timespan]::fromseconds($start_s)
    $black.start = "{0:HH:mm:ss.fff}" -f ([datetime]$start_ts.Ticks)

    # extract duration of black scene
    $end_s       = $_.line -match '(?<=black_end:)\S*(?= black_duration:)' | % {$matches[0]}
    $end_ts      = [timespan]::fromseconds($end_s)
    $black.end   = "{0:HH:mm:ss.fff}" -f ([datetime]$end_ts.Ticks)

    # calculate cut point: black start time + black duration / 2
    $cut_s       = ([double]$start_s + [double]$end_s) / 2
    $cut_ts      = [timespan]::fromseconds($cut_s)
    $black.cut   = "{0:HH:mm:ss.fff}" -f ([datetime]$cut_ts.Ticks)

    $report += $black
  }

  ### Write start time, duration and the cut point for each black scene to a seperate CSV
  $report | Export-Csv -path "$($video.FullName)_cutpoints.csv" -NoTypeInformation
}
