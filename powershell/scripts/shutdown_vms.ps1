Import-Module Hyper-V -RequiredVersion 1.1

# TODO: This doesn't really work and is mangled, but it's a good reference still

$blades = @()

$chef_dbs = @()

$actinoform_dbs = @()

$tlrg_web_vms =@()

$tlrg_wrk_vms = @()

# $creds = Get-Credential -UserName "my_username@domain" -Message 'Gimme dem creds yo'
foreach ($blade in $blades) {
  write-host "Trying blade $blade"
  $blade_vms = Get-VM -ComputerName $blade | Where-Object {$_.State -eq 'Off'}
  foreach ($vm in $blade_vms) {
    # if ($tlrg_wrk_vms.Contains($vm.Name.ToLower())) {
    if ($tlrg_web_vms.Contains($vm.Name.ToLower())) {
    # if ($actinoform_dbs.Contains($vm.Name.ToLower())) {
    # if ($chef_dbs.Contains($vm.Name.ToLower())) {
      write-host "Starting $($vm.Name)"
      write-host "  State: $($vm.State)"
      # Start-VM -VM $vm #-ComputerName $blade
      # Stop-VM $vm
    }
  }
}


# TODO: Currently `Start-VM` fails with this:
# Starting vm-name-here
#   State: Off
# Start-VM : Unable to cast COM object of type 'System.__ComObject' to interface type
# 'System.Management.IWbemServices'. This operation failed because the QueryInterface call on
# the COM component for the interface with IID '{9556DC99-828C-11CF-A37E-00AA003240C7}' failed
# due to the following error: The requested object does not exist. (Exception from HRESULT:
# 0x80010114).
# At C:\Users\tscheffert\.dotfiles\powershell\scripts\shutdown_vms.ps1:83 char:7
# +       Start-VM -VM $vm #-ComputerName $blade
# +       ~~~~~~~~~~~~~~~~
#     + CategoryInfo          : NotSpecified: (:) [Start-VM], InvalidCastException
#     + FullyQualifiedErrorId : Unspecified,Microsoft.HyperV.PowerShell.Commands.StartVMCommand




# foreach ($user in $users) {
#   $aduser = Get-ADUser -Filter { name -Like $user } -Server $server -Credential $creds

#   foreach ($db in $dbs) {
#     Add-ADGroupMember $db -Member $aduser
#   }
# }
