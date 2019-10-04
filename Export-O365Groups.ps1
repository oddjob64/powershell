]param([parameter(Mandatory=$True, HelpMessage='Please enter filename for CSV file to export')]$CSVFilename) 

Write-Host -ForegroundColor Green "Loading all Office 365 Groups"
$Groups = Get-UnifiedGroup -ResultSize Unlimited 

$GroupsCSV = @()
Write-Host -ForegroundColor Green "Processing Groups"
foreach ($Member in $Members) {
    $MemberSMTP+=$Member.PrimarySmtpAddress
}
