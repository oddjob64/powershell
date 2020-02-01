[CmdletBinding()]
param (
	
	[Parameter( Mandatory=$false)]
	[string]$Computer

	)

#A useful API for retrieving your public IP address
$url = "https://api.ipify.org/?format=json"

#If a remote computer was specified then a PS remote session is used. Otherwies the query
#is run locally.
if ($Computer)
{
    $credential = Get-Credential -Message "Enter credentials for remoting to $Computer"
    $ip = Invoke-Command -ComputerName $Computer -Credential $credential -ScriptBlock {(Invoke-RestMethod $using:url).ip}
}
else
{
    
    $ip = (Invoke-RestMethod $url).ip
}

#Kill a puppy with Write-Host, but you can repurpose this code to use $ip
#any way you like.
if ($Computer)
{
    Write-Host "The public IP address of computer $computer is $ip"
}
else
{
    Write-Host "The public IP address of the local computer is $ip"
}
