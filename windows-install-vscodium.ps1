#Requires -RunAsAdministrator

# PowerShell script to install VSCodium via chocolatey on Windows

function main {
    write-host "VSCodium installer for Windows."

    # check if chocolatey is installed or not
    if ( Test-Path -Path 'C:\ProgramData\chocolatey' ) {
        # it means that choco is installed
        write-host ""
    } else {
        # not installed, so install it
        write-host "Installing chocolatey ..."
        Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    }

    write-host "Installing VSCodium ..."
    choco install vscodium
}

main
