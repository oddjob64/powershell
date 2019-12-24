<#
.SYNOPSIS

Install Office365 PowerShell Modules


#>


# Check exection policies to enable scripting

Write-Host "List execution policies"

Get-ExecutionPolicy -List

Set-ExecutionPolicy RemoteSigned

Install-Module -Name MsolService

Install-Module -Name AzureAD

$credential = Get-Credential

Connect-AzureAD -Credential $credential

Function Load-Module ($m) {
    
    # Check Module imported
    if (Get-Module | Where-Object {$_.Name -EQ $m}) {
        Write-Host "Module $m is already imported."
    }

    else {
        # If module is not imported, check disk availability
        if (Get-Module -ListAvailable | Where-Object {$_.Name -eq $m}) {
            Import-Module $m -Verbose
        }

        else {


            if (Find-Module -Name $m | Where-Object {$_.Name -eq $m}) {
                Install-Module -Name $m -Verbose -Scope CurrentUser
                Import-Module $m -Verbose
            }

            else {

                Write-Host "Module $m unavailable."
                EXIT 1
            }
        }
    }
}

Load-Module "ModuleName" 


#Connect-MsolService
if (Get-Module -ListAvailable -Name AzureAD) {
    Write-Host "Module currently installed"
} 

else {
    Write-Host "Module is not installed"
}


try {


    Import-Module AzureAD
    Write-Host "Module exists"
} 

catch {
    Write-Host "Module does not exist."
}

Write-Host "Check for Module Installation"

Get-Module -Name Microsoft.OnlineSharePoint.PowerShell -ListAvailable | Select Name,Version

Install-Module -Name Microsoft.Online.SharePoint.PowerShell

Import-Module Microsoft.Online.SharePoint.PowerShell -DisableNameChecking 

Write-Host "Import, Install, or Connect to Exchange Server"

$exchangeSession = New-PSSession -ConfigurationName Microsoft.Echange -ConnectionUri "https://outlook.office365.com/powershell-liveid/" -Credential $credential -Authentication Basic -AllowRedirection

Write-Host "Connect to Security and Compliance Center" 
$SccSession = New-PSSession -ConfigurationName 

$orgName = "https://billingsutility-admin.sharepoint.com/"

$credential = Get-Credential
Connect-AzureAD -Credential $credential
Import-Module Microsoft.OnlineSharePoint.PowerShell -DisableNameChecking

Get-AzureAdUser | ForEach{ 

    $licensed=$False ; For ($i=0; $i -le ($_.AssignedLicenses | Measure).Count ; $i++) { 


    If( [string]::IsNullOrEmpty(  $_.AssignedLicenses[$i].disabledplans ) -ne $True) { $licensed=$true } } ; 


    If( $licensed -eq $false) { Write-Host $_.UserPrincipalName} }



Function Office365-License {

    Get-AzureADUser | ForEach { 

        $licensed=$False ; For ($i=0; $i -le ($_.AssignedLicenses | Measure).Count ; $i++) {

        If ( [string]::IsNullOrEmpty( $_.AssignedLicense[$i].disabledplans ) -ne $True) { $licensed=$true } } ;

        If ( $licensed -eq $false) {Write-Host $_.UserPrincipalName} 

    }
}

                

