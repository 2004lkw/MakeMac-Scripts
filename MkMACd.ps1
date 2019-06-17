# ----------------------------------------------------------------------------
# Written By Larry Williams.
#
#  This script will take a mac address and insert the correct semicolons in
#  to the mac address and output it to the screen and to the clipboard.
#
#  Press enter without anything to exit the script.  Otherwise enter your MAC
#  and it will be formatted.
# ----------------------------------------------------------------------------


<#
.SYNOPSIS
    Takes a MAC address without semi-colons and inserts them.
.DESCRIPTION
    Takes a MAC address at the command line or as a prompt and outputs the new MAC with semicolons to the clipboard.
.NOTES
    Original Filename:    MkMAC.PS1
    Author           :    Larry Williams II
    WARNING          :    Use at your own risk.  You accept all responsibilities.  
.EXAMPLE
    MkMAC.ps1 192312a1ccca
        will output 19:23:12:a1:cc:ca (To the clipboard)
#>


param (
    # If a parameter was used at the start of the script (from the CLI)
    [string] $mac1
)

# Notify area.
Write-Host " ----------------------------------------------------------------------------"
Write-Host " Written By Larry Williams."
Write-Host ""
Write-Host "  This script will take a mac address and insert the correct semicolons in"
Write-Host "  to the mac address and output it to the screen and to the clipboard."
Write-Host ""
Write-Host "  Press enter without anything to exit the script.  Otherwise enter your MAC"
Write-Host "  and it will be formatted."
Write-Host " ----------------------------------------------------------------------------"


# Length of a mac address.
[Int] $MacLength = 12
# Continue in the loop?
[Bool] $LoopControl = $true


# Contine to loop until we are told not to.
while ($LoopControl) {
    if ($mac1 -eq "") {
        [string] $mac1 = Read-Host 'MAC ADDRESS [blank to exit]'
    }
    if ($mac1.Length -eq $MacLength) {
        # Got a good MAC.  Insert the :'s and put in the clipboard.  
        [int] $flipflop=0
        [string] $outMac = ""
        for ([int]$count = 0; $count -lt $mac1.Length; $count++) {
            if (($flipflop -eq 2) -and ($count -lt 12)) {
                $outMac = $outMac + "-"
                $flipflop = 0
            }
            $outMac = $outMac + $mac1.Substring($count, 1)
            $flipflop++       
        }
        $mac1=$outMac
        Write-Host "MAC!  $mac1"
        # Just for fun, lets output it to the screen.
        Set-Clipboard -Value $mac1
        # and now to the clipboard.
        $mac1 = ""
        # Lastly, set the mac to no contents so that we can restart the loop.
    } else {
        # So there was content entered in but it wasn't the right length.
        # TRY AGAIN!
        if ($mac1.Length -gt 0) {
            Write-host "Your mac is not the right length!"
            # set mac to nothing.
            $mac1 = ""
        } else {
            $LoopControl = $false
            #Exit the program.
        }
    }
}