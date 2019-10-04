Write-Host "Check version of PowerShell"

$PSVersionTable.PSVersion

$LiveCred = Get-Credential 
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri

https://ps.outlook.com/powershell/ -credential $LiveCred -Authentication-Basic -AllowRederection

Import-PSSession

# Install Modules
Install-Module AzureAD
Install-Module AzureADPreview
Install-Module MSOnline -Force


Connect-MsolService -Credential $LiveCred