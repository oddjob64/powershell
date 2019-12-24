Write-Host "List Execution Policies" 
Get-ExecutionPolicy -List
Set-ExecutionPolicy RemoteSigned
$credential = Get-Credential
$orgName = "BillingsUtility.com"
#Install-Module -Name Az -AllocClober 
#Install-Module -Name AzureAD
Connect-MsolService -Credential $credential 
Connect-AzureAD -Credential $credential
Connect-SPOService -Url https://billingsutility-admin.sharepoint.com/ -Credential $credential 
Import-Module Microsoft.Online.SharePoint.PowerShell -DisableNameChecking

Import-Module SkypeOnlineConnector
$sfboSession = New-CsOnlineSession -Credential $credential
Import-PSSession $sfboSession

$exchangeSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri "https://outlook.office365.com/powershell-liveid/" -Credential $credential -Authentication "Basic" -AllowRedirection

Import-PSSession $exchangeSession -DisableNameChecking 

$SccSession = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://ps.compliance.protection.outlook.com/powershell-liveid/ -Credential $credential -Authentication "Basic" -AllowRedirection
Import-PSSession $SccSession -Prefix cc