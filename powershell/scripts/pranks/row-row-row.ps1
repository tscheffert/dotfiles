$j1 = Start-Job {
  Add-Type -AssemblyName System.Speech
  $SpeechSynth = New-Object System.Speech.Synthesis.SpeechSynthesizer
  $SpeechSynth.SelectVoiceByHints('Male')
  $SpeechSynth.Speak("Row, Row, Row your boat gently down the stream.  Merrily! Merrily! Merrily! Life is but a dream.")
}
Start-Sleep -Seconds 1
$j2 = Start-Job {
  Add-Type -AssemblyName System.Speech
  $SpeechSynth = New-Object System.Speech.Synthesis.SpeechSynthesizer
  $SpeechSynth.SelectVoiceByHints('Female')
  $SpeechSynth.Speak("Row, Row, Row your boat gently down the stream.  Merrily! Merrily! Merrily! Life is but a dream.")
}
$j1,$j2 | Wait-Job | Receive-Job
$j1,$j2 | Remove-Job
