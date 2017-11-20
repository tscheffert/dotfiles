$users = @( 'User Fullname')

$dbs = @( 'DB-NameHere')

$creds = Get-Credential -UserName "DOMAIN\User" -Message 'Gimme dem creds yo'

$server = your.domain.server.net
foreach ($user in $users) {
  $aduser = Get-ADUser -Filter { name -Like $user } -Server $server -Credential $creds

  foreach ($db in $dbs) {
    Add-ADGroupMember $db -Member $aduser
  }
}
