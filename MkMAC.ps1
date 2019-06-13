# Make a mac address have semicolons.

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
    [string] $mac1
)

[Int] $MacLength = 12

if ($mac1 -eq "") {
    Write-Host "No paramater."
    [string] $mac1 = Read-Host 'MAC '
}


if ($mac1.Length -eq $MacLength) {
    # Got a good MAC.  Insert the :'s and put in the clipboard.  
    [int] $flipflop=0
    [string] $outMac = ""
    for ([int]$count = 0; $count -lt $mac1.Length; $count++) {
        if (($flipflop -eq 2) -and ($count -lt 12)) {
            $outMac = $outMac + ":"
            $flipflop = 0
        }
        $outMac = $outMac + $mac1.Substring($count, 1)
        $flipflop++       
    }
    $mac1=$outMac
    Write-Host "MAC!  $mac1"
    # Just for fun, lets output it to the screen.
    Set-Clipboard -Value $mac1
} else {
    Write-host "Your mac is not the right length!"
}
