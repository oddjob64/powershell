Get-ADUser -Filter {Enabled -eq $True -and PasswordNeverExpires -eq $False} -Properties "DisplayName", "msDS-UserPasswordExpiryTimeComputed"

where {
    $Difference = New-TimeSpan (Get-Date) ([datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")) 
    $Difference.Days -le 7 -and $Difference.Days -ge 0
}

Select-Object -Property "DisplayName" @{Name="Password Expires";Expression={[datetime]::FromFileTime(($_."msDS-UserPasswordExpiryTimeComputed"))}} | 

Export-Csv "\\dc1\Storage\ExpiringPasswords.csv"

