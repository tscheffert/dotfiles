# These are things that may make gaming on a windows PC better, but may not. My current values do not match the ones being suggested here. I don't remember where these ones come from. Looking in the Settings, Game DVR is disabled. Not going to run this atm, but I will keep this script around in case I need it later.

param(
  [switch]$Set = $false)

if ($set) {
  Write-Output "-Set flag passed, setting values"
} else {
  Write-Output "No -Set flag passed, only getting values. Run with -Set to set values."
}

# [HKEY_CURRENT_USER\System\GameConfigStore]
# "GameDVR_Enabled"=dword:00000000
# "GameDVR_FSEBehaviorMode"=dword:00000002

if ($set) {
  # Set-ItemProperty -Path 'HKCU:\System\GameConfigStore' -Name 'GameDVR_Enabled' -Value "0" -Type DWord
  # Set-ItemProperty -Path 'HKCU:\System\GameConfigStore' -Name 'GameDVR_FSEBehaviorMode' -Value "2" -Type DWord
} else {
  Get-ItemProperty -Path 'HKCU:\System\GameConfigStore' -Name 'GameDVR_Enabled'
  Get-ItemProperty -Path 'HKCU:\System\GameConfigStore' -Name 'GameDVR_FSEBehaviorMode'
}

# [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\current\device\ApplicationManagement]
# "AllowAppStoreAutoUpdate"=dword:00000002
# "AllowGameDVR"=dword:00000000
# "AllowStore"=dword:00000001

if ($set) {
  Write-Output "Set temporarily disabled"
  # Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\ApplicationManagement' -Name 'AllowAppStoreAutoUpdate' -Value "2" -Type DWord
  # Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\ApplicationManagement' -Name 'AllowGameDVR' -Value "0" -Type DWord
  # Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\ApplicationManagement' -Name 'AllowStore' -Value "1" -Type DWord
} else {
  Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\ApplicationManagement' -Name 'AllowAppStoreAutoUpdate'
  Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\ApplicationManagement' -Name 'AllowGameDVR'
  Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\current\device\ApplicationManagement' -Name 'AllowStore'
}


# [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR]
# "highrange"=dword:00000001
# "lowrange"=dword:00000000
# "mergealgorithm"=dword:00000001
# "policytype"=dword:00000004
# "value"=dword:00000000

if ($set) {
  Write-Output "Set temporarily disabled"
  # Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR' -Name 'highrange' -Value "1" -Type DWord
  # Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR' -Name 'lowrange' -Value "0" -Type DWord
  # Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR' -Name 'mergealgorithm' -Value "1" -Type DWord
  # Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR' -Name 'policytype' -Value "4" -Type DWord
  # Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR' -Name 'value' -Value "0" -Type DWord
} else {
  Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR' -Name 'highrange'
  Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR' -Name 'lowrange'
  Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR' -Name 'mergealgorithm'
  Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR' -Name 'policytype'
  Get-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\AllowGameDVR' -Name 'value'
}


# [HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\GameDVR]
# "AllowGameDVR"=dword:00000000

if ($set) {
  Write-Output "Set temporarily disabled"
  # Set-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR' -Name 'AllowGameDVR' -Value "0" -Type DWord
} else {
  Get-ItemProperty -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR' -Name 'AllowGameDVR'
}
