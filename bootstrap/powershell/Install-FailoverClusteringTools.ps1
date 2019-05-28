# Details: https://www.microsoft.com/en-us/download/details.aspx?id=45520

# DISM /online /Add-Capability /CapabilityName:Rsat.FailoverCluster.Management.Tools~~~~0.0.1.0

# Problem: Error code0x800f0954
# Sorce: https://social.technet.microsoft.com/Forums/en-US/42bfdd6e-f191-4813-9142-5c86a2797c53/windows-10-1809-rsat-toolset-error-code-of-0x800f0954?forum=win10itprogeneral
#   Run "gpedit.msc" to edit your local computer policy The setting in question is: Computer Configuration\Administrative Templates\System\Specify settings for optional component installation and component repair
#   My local policy seems to have defaulted to "Disabled" - after changing it to "Enabled" and selecting the checkbox labeled "Download repair content and optional features directly from Windows Update instead of Windows Server Update Services (WSUS)" the RSAT tools installed for me.


Add-WindowsCapability -online -Name "Rsat.FailoverCluster.Management.Tools~~~~0.0.1.0"
