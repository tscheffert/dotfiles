# Get the VM and OS details for a specified computer
# TODO: Test and make this actually work
function Get-VMOSDetail
{
  param(
    [Parameter()]
    $ComputerName = $Env:ComputerName,

    [Parameter()]
    $VMName
  )

  # Creating HASH Table for object creation
  $MyObj = @{}

  # Getting VM Object
  $Vm = Get-WmiObject -Namespace root\virtualization -Query "Select * From Msvm_ComputerSystem Where ElementName='$VMName'" -ComputerName $ComputerName

  # Getting VM Details
  $Kvp = Get-WmiObject -Namespace root\virtualization -Query "Associators of {$Vm} Where AssocClass=Msvm_SystemDevice ResultClass=Msvm_KvpExchangeComponent" -ComputerName $ComputerName

  # Converting XML to Object
  foreach ($CimXml in $Kvp.GuestIntrinsicExchangeItems)
  {
    $XML = [xml]$CimXml
    if ($XML)
    {
      foreach ($CimProperty in $XML.SelectNodes("/INSTANCE/PROPERTY"))
      {
        switch -exact ($CimProperty.Name)
        {
          "Data" { $Value = $CimProperty.VALUE }
          "Name" { $Name = $CimProperty.VALUE }
        }
      }
      $MyObj.Add($Name,$Value)
    }
  }

  # Outputting Object
  New-Object -TypeName PSCustomObject -Property $MyObj
}
