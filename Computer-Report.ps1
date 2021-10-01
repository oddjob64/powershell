Function Get-SystemInfo {
    [cmdletbinding()]
    Param([string]$Computername = $env:COMPUTERNAME)
 
    #this function has no real error handling
    $cs = Get-CimInstance -ClassName Win32_computersystem -ComputerName $Computername  
    #this assumes a single processor
    $proc = Get-CimInstance -ClassName win32_processor -ComputerName $Computername 
 
    $data = [ordered]@{
        TotalPhysicalMemGB   = $cs.TotalPhysicalMemory / 1GB -as [int]
        NumProcessors        = $cs.NumberOfProcessors
        NumLogicalProcessors = $cs.NumberOfLogicalProcessors
        HyperVisorPresent    = $cs.HypervisorPresent
        DeviceID             = $proc.DeviceID
        Name                 = $proc.Name
        MaxClock             = $proc.MaxClockSpeed
        L2size               = $proc.L2CacheSize
        L3Size               = $proc.L3CacheSize
 
    }
 
    New-Object -TypeName PSObject -Property $data
 
}