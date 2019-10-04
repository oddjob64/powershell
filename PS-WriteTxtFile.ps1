#Get-Date | Out-File -FilePath $env:USERPROFILE%\Documents\Output.txt -Append

Add-Content -Path C:\PS-Admin\Output.txt -Value "Log entry created on"

Get-Date -Format MM/dd/yyyy-hh:mm:ss | Add-Content -Path C:\PS-Admin\Output.txt 