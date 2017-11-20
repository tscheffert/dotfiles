#*****************************************************************************************************************
#* RemoteLogoffRebootShutdown-Computer.ps1                                                                       *
#* By: Daveeatworld                                                                                              *
#* Date: 3/20/2017                                                                                               *
#* Modified: 3/22/2017                                                                                           *
#* I originally created this script in 2012 with VBScript.                                                       *
#* Version 1.1 (No GUI)                                                                                          *
#* Version changes: Switch logic improved for better menu, readability, and error handling along with            *
#* better user input from version 1.0                                                                            *
#* Script Function:                                                                                              *
#* Script that is able to remotely: Logoff, Shutdown, or Reboot a computer. Can be forced or user confirmed.     *
#* Force versions of Logoff, Shutdown, and Reboot do not notify user or allow them to save anything.             *
#* User inputs into script a computer name  or IP Address as well as the action to perform.                      *
#*                                                                                                               *
#* Valid arguments for Win32Shutdown method (Action to perform on target computer):                              *
#*                                                                                                               *
#* 0 – Log Off Computer (Prompts user.)                                                                         *
#* 4 – Forced Log Off (No user prompt. No ability to save work.)                                                *
#* 1 – Shutdown (Prompts user.)                                                                                 *
#* 5 – Force Shutdown (No user prompt. No ability to save work.)                                                *
#* 2 – Reboot (Prompts user.)                                                                                   *
#* 6 – Forced Reboot (No user prompt. No ability to save work.)                                                 *
#* 8 – Power Off Forced Power Off (Not used in script. No code for it. Just listed for documentation)           *
#* 12 – Forced Power Off (Not used in script. No code for it. Just listed for documentation)                    *
#*****************************************************************************************************************

#Variable for Popup MessageBox
$WShell = New-Object -ComObject WScript.Shell

#User Input for name or IP Address of the target computer. Also converts to upper case if entered as lower case.
$Computer = (Read-Host "Please enter the computer name ").ToUpper()

#If user input for Computer name is blank/empty/null, exit script.
If ($Computer -eq [string]::empty){
    Read-Host "You did not enter a correct parameter. The Script will now end."
    Break
}



#User Input for the operation the wish to perform. Valid arguments are listed above at the top of the script for the Win32Shutdown method. $Action is the variable that holds the argument.
$MenuItems = (
    '1. Log Off Computer (Prompts user.)',
    '2. Forced Log Off (No user prompt. No ability to save work.)',
    '3. Shutdown (Prompts user.)',
    '4. Force Shutdown (No user prompt. No ability to save work.)',
    '5. Reboot (Prompts user.)',
    '6. Forced Reboot (No user prompt. No ability to save work.)',
    'x - Enter the letter "x" to Exit'
    )
$ValidChoices = $MenuItems | ForEach-Object {$_[0]}

$Choice = ''
while ($Choice -notin $ValidChoices)
    {
    Clear-Host
    $MenuItems
    Write-Output ''
    $Choice = (Read-Host "Please enter a choice from the above items ").ToLower()
    }

#Switch logic for $Action variable to perform the requested operation.
Write-Output ''
$Action = ''
switch ($Choice)
    {
        '1' # – Logoff Computer (Prompts user.)
                {
                    $Action = '0';
                    Write-Host "Logoff sent to $Computer."
                    Break
                }
        '2' # – Forced Logoff (No user prompt. No ability to save work.)
                {
                    $Action = '4';
                    Write-Host "Force Logoff sent to $Computer."
                    Break
                }
        '3' # – Shutdown (Prompts user.)
                {
                    $Action = '1';
                    Write-Host "Shutdown sent to $Computer."
                    Break
                }
        '4' # – Force Shutdown (No user prompt. No ability to save work.)
                {
                    $Action = '5';
                    Write-Host "Force Shutdown sent to $Computer."
                    Break
                }
        '5' # – Reboot (Prompts user.)
                {
                    $Action = '2';
                    Write-Host "Reboot sent to $Computer."
                    Break
                }
        '6' # – Force Reboot (No user prompt. No ability to save work.)
                {
                    $Action = '6';
                    Write-Host "Force Reboot sent to $Computer."
                    Break
                }
        'x' # - Exit the script
                {
                    $Action = 'x';
                    Write-Host "You have chosen to exit the script."
                    Exit
                }
        }

    #Ping Computer to see if its online. If so, it will perform the Action entered, else will display message not available and script will end.
    If (Test-Connection -computerName $Computer -Quiet -count 1){
        (gwmi win32_operatingsystem -ComputerName $Computer).Win32Shutdown($Action)
        Write-Host "The operation has been sent to the target computer: $Computer"
        Break
    }
    Else {
        Write-Host "The computer did not respond and may be offline. The script will now end."
        Break
    }
}
