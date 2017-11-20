$Scriptblock = {
  Add-Type -AssemblyName System.Speech
  $SpeechSynth = New-Object System.Speech.Synthesis.SpeechSynthesizer
  $CatFact = (ConvertFrom-Json (Invoke-WebRequest -Uri 'http://catfacts-api.appspot.com/api/facts' -UseBasicParsing)).facts
  $SpeechSynth.Speak("did you know?" + $CatFact)
}

Invoke-Command -ComputerName VictimPC -ScriptBlock $Scriptblock

