#######################################################################################
# Script    : Install_AdobeReader.ps1
# Name      : Tyler Billings
# Date      : 20 August 2019
# Objective : Install Adobe Reader - used in non-profit agency Windows 10 Deployment. 
#############################
##### PowerShell Script #####
#############################

# Check execution policies
$Policy = Get-ExecutionPolicy 

If ($Policy -eq "RemoteSigned") {

    Write-Host "Set Execution Policies to RemoteSigned"
    Set-ExecutionPolicy RemoteSigned
}


Else {

    Write-Host "Execution Policies have been set."
}

If ($remSigned -eq $True) {
    Write-Host "Set Execution Policies to run script"
    Set-ExecutionPolicy RemoteSigned
}

$workdir = "c:\installer\"

If (Test-Path -Path $workdir -PathType Container)
{
    Write-Host "$workdir already exists" -ForegroundColor Red
}

Else {

    New-Item -Path $workdir -ItemType Directory 
}

$source = "http://ardownload.adobe.com/pub/adobe/reader/win/AcrobatDC/1502320053/AcroRdrDC1502320053_en_US.exe"
$destination = "$workdir\adobeDC.exe" 
Invoke-WebRequest $source -OutFile $destination 

# Begin installation
Start-Process -FilePath "$workdir\adobeDC.exe" -ArgumentList "/sPB /rs"

# Wait for installation to complete
Start-Sleep -s 35 

# Remove installer
rm -Force $workdir\adobe*
