#*************************************************************************************************************
#* RemoteLogoffRebootShutdown-ComputerGUI.ps1                                                                *
#* By: Daveeatworld                                                                                          *
#* Date: 3/20/2017                                                                                           *
#* Modified: 3/23/2017                                                                                       *
#* I originally created this script in 2012 with VBScript.                                                   *
#* Version 1.1 (GUI Added via InputBoxes for user input rather than typing into the command line window.)    *
#* Version Changes: Switch logic improved for beter menu, code better written for readability and better     *
#* practices. Error handling improved and option for user to exit the script.                                *
#* Script Function:                                                                                          *
#* Script that is able to remotely: Logoff, Shutdown, or Reboot a computer. Can be forced or user confirmed. *
#* Force versions of Logoff, Shutdown, and Reboot do not notify user or allow them to save anything.         *
#* User inputs into script a computer name  or IP Address as well as the action to perform.                  *
#*                                                                                                           *
#* Operation arguments for Win32Shutdown method (Action to perform on target computer):                      *
#*                                                                                                           *
#* 0 – Log Off Computer (Prompts user.)                                                                     *
#* 4 – Forced Log Off (No user prompt. No ability to save work.)                                            *
#* 1 – Shutdown (Prompts user.)                                                                             *
#* 5 – Force Shutdown (No user prompt. No ability to save work.)                                            *
#* 2 – Reboot (Prompts user.)                                                                               *
#* 6 – Forced Reboot (No user prompt. No ability to save work.)                                             *
#* 8 – Power Off Forced Power Off (Not used in script. No code for it. Just listed for documentation)       *
#* 12 – Forced Power Off (Not used in script. No code for it. Just listed for documentation)                *
#*************************************************************************************************************

#Variable for Popup MessageBox
$wShell = New-Object -ComObject WScript.Shell

#User Input for name or IP Address of the target computer.
[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
$title = 'Remote Logoff-Reboot-Shutdown Tool'
$Computer = 'Enter the name of the computer you wish to logoff / reboot / shutdown: '
$ComputerText = [Microsoft.VisualBasic.Interaction]::InputBox($Computer,$title).ToUpper()

#Convert input to uppercase
#$ComputerText.ToUpper()

#If user input for Computer name is blank/empty/null, exit script.
if ($ComputerText -eq [string]::Empty) {
  $wShell.Popup("You did not enter a correct parameter. The Script will now end.")
  exit
}
#Ping Computer to see if its online. If so, it will execute the script, otherwise it will quit.
if (Test-Connection -ComputerName $ComputerText -Quiet -Count 1) {
  #User Input for the operation the wish to perform. Valid arguments are listed above at the top of the script for the Win32Shutdown method. $Choice is the variable that holds the argument.
  [void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
  $title = 'Remote Logoff-Reboot-Shutdown Tool'
  $Choice = 'Please enter a choice to perform on the target computer:

    1 - Logoff
    2 - Force Logoff
    3 - Shutdown
    4 - Force Shutdown
    5 - Reboot
    6 - Force Reboot
x - Press "x" to exit the script.'
  $ActionText = [Microsoft.VisualBasic.Interaction]::InputBox($Choice,$title)
  $Action = '' #variable for switch logic
  #Switch logic for $Action variable to perform the requested operation.
  switch ($ActionText)
  {
    '1' # Logoff Computer (Prompts user.)
    {
      $Action = '0';
      $wShell.Popup("Logoff sent to $ComputerText.")
      break
    }
    '2' #  Force Logoff (No user prompt. No ability to save work.)
    {
      $Action = '4';
      $wShell.Popup("Force Logoff sent to $ComputerText.")
      break
    }
    '3' # Shutdown (Prompts user.)
    {
      $Action = '1';
      $wShell.Popup("Shutdown sent to $ComputerText.")
      break
    }
    '4' # Force Shutdown (No user prompt. No ability to save work.)
    {
      $Action = '5';
      $wShell.Popup("Force Shutdown sent to $ComputerText.")
      break
    }
    '5' # Reboot (Prompts user.)
    {
      $Action = '2';
      $wShell.Popup("Reboot sent to $ComputerText.")
      break
    }
    '6' # Force Reboot (No user prompt. No ability to save work.)
    {
      $Action = '6';
      $wShell.Popup("Force Reboot sent to $ComputerText.")
      break
    }
    'x' # - Exit the script
    {
      $Action = 'x';
      $wShell.Popup("You have chosen to exit the script.")
      exit
    }
    default
    { $wShell.Popup("You did not enter a correct choice from the menu. Please hit ok and then choose a command from the menu.")
      $ActionText = [Microsoft.VisualBasic.Interaction]::InputBox($Choice,$title)
    }
  }
  (gwmi win32_operatingsystem -ComputerName $ComputerText).Win32Shutdown($Action)
  $wShell.Popup("The Script has finished and will now end.")
  exit
}
else {
  $wShell.Popup("The computer did not respond and may be offline. The script will now end.")
  exit
}
