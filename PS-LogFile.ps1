$computer = gc env:computername

$onetcp = ((get-childitem c:\windows\system32\drivers\tcpip.sys).Versioninfo.ProductMajorPart).tostring() $twotcp = ((get-childitem c:\windows\system32\drivers\tcpip.sys).Versioninfo.ProductMinorPart).tostring() $threetcp = ((get-childitem c:\windows\system32\drivers\tcpip.sys).Versioninfo.ProductBuildPart).tostring() $fourtcp = ((get-childitem c:\windows\system32\drivers\tcpip.sys).Versioninfo.ProductPrivatePart).tostring()


$onedfsr = ((get-childitem c:\windows\system32\dfsrs.exe).Versioninfo.ProductMajorPart).tostring() $twodfsr = ((get-childitem c:\windows\system32\dfsrs.exe).Versioninfo.ProductMinorPart).tostring() $threedfsr = ((get-childitem c:\windows\system32\dfsrs.exe).Versioninfo.ProductBuildPart).tostring() $fourdfsr = ((get-childitem c:\windows\system32\dfsrs.exe).Versioninfo.ProductPrivatePart).tostring()

write-host TCPIP.sys Version on $computer is: "$onetcp.$twotcp.$threetcp.$fourtcp" Write-Host write-host DFSRS.exe Version on $computer is: "$onedfsr.$twodfsr.$threedfsr.$fourdfsr"

Write-Host

If (get-wmiobject win32_share | where-object {$_.Name -eq "REMINST"}) {   Write-Host "The REMINST share exists on $computer" } Else {   Write-Host "The REMINST share DOES NOT exist on $computer - Please create as per standards"  }   Write-Host

$hotfix1 = Get-HotFix -Id KB2450944 -ErrorAction SilentlyContinue $hotfix2 = Get-HotFix -Id KB2582284 -ErrorAction SilentlyContinue $hotfix3 = Get-HotFix -Id KB979808 -ErrorAction SilentlyContinue

If ($hotfix1) {     Write-Host "Hotfix KB2450944 is installed"
-BackgroundColor Green -ForegroundColor Black   } else {    Write-Host "Hotfix KB2450944 is NOT installed - Please ensure you install this hotfix" -ForegroundColor "red"   }


If ($hotfix2) {     Write-Host "Hotfix KB2582284 is installed"
-BackgroundColor Green -ForegroundColor Black   } else {    Write-Host "Hotfix KB2582284 is NOT installed - Please ensure you install this hotfix" -ForegroundColor "red"   }

If ($hotfix3) {     Write-Host "Hotfix KB979808 is installed"
-BackgroundColor Green -ForegroundColor Black   } else {    Write-Host "Hotfix KB979808 is NOT installed - Please ensure you install this hotfix" -ForegroundColor "red"    }