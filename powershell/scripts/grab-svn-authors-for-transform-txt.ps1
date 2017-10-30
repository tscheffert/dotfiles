# Start with an authors-transform.txt in the script's directory
# From:
#   https://john.albin.net/git/convert-subversion-to-git
#   svn log -q | awk -F '|' '/^r/ {sub("^ ", "", $2); sub(" $", "", $2); print $2" = "$2" <"$2">"}' | sort -u > authors-transform.txt
# Before:
#   jdoe = jdoe <jdoe>
# After:
#   jdoe = John Doe <john.doe@example.com>
# Note: If lines with jdoe and JDoe exist, then we want both to exist after transform

$outFile = ".\transformed-authors.txt"

if (Test-Path $outFile) {
  Write-Output 'Clearing existing authors-transformed.txt'
  Remove-Item -Path $outFile
}

$outputWriter = New-Object System.IO.StreamWriter $outFile

Write-Output 'Loading authors-transform.txt and transforming lines'
foreach ($line in (Get-Content ".\authors-transform.txt")) {
  # Try to find the user then output a nice string or leave it
  #   $user.SamAccountName = $user.Name <$user.UserPrincipalName.ToLower()>
  $samAccountName = [regex]::matches($line,"^\S+").captures.groups[0].value

  $user = Get-ADUser -LDAPFilter "(SamAccountName=$samAccountName)"
  if ($null -ne $user) {
    $transformedLine = "$($samAccountName) = $($user.Name) <$($user.UserPrincipalName.ToLower())>"

    $outputWriter.WriteLine($transformedLine)
  }
  else {
    $outputWriter.WriteLine($line)
  }
}

# Write remaining buffer to file and release file handle
$outputWriter.Flush()
$outputWriter.Close()
Write-Output 'Completed transforming'
