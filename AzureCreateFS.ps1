$resourceGroup = "rgbillutil01a" 

$storAcct = "billutilstore1"

$location = "East US"


$storAcct = New-AzStorageAccount -ResourceGroupName "rgbillutil01a" -Name $storAcct -SkuName Standard_LRS -Location $region -Kind StorageV2

$share = New-AzStorageShare -Context $storAcct.Context -Name $shareName 

$shareName = "FS1"

$storageAcct = New-AzStorageAccount `
                  -ResourceGroupName "rgbillutil01a" `
                  -Name "billutilstore2$(Get-Random)" `
                  -Location eastus `
                  -SkuName Standard_LRS

New-AzStorageShare `
    -Name FS1 `
    -Context $storAcct.Context


$connectTestResult = Test-NetConnection -ComputerName billutilstore1.file.core.windows.net -Port 445
if ($connectTestResult.TcpTestSucceeded) {
    # Save the password so the drive will persist on reboot
    cmd.exe /C "cmdkey /add:`"billutilstore1.file.core.windows.net`" /user:`"Azure\billutilstore1`" /pass:`"22iMgMIYe6Pe3v20G88DzrHNlAqczJ16TqTbzCdaAE2AgJ4NnSfEUczxCBK88wPXxDUxHK/CT9ZSiodwLrW42A==`""
    # Mount the drive
    New-PSDrive -Name Z -PSProvider FileSystem -Root "\\billutilstore1.file.core.windows.net\fs1"-Persist
}
else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}