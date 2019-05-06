# Import required modules
Import-Module ActiveDirectory


# Create a new password
$securePassword = ConvertTo-SecureString "TESTpassw0rd!123" -AsPlainText -Force

# Prompt user for csv file path
$filepath = Read-Host -Prompt"Please enter path of CSV file"

# Import file into variable
$users = Import-Csv $filepath

# Loop through each row and gather info
ForEach ($user in $users) {
    # Gather user information
    $fname = $user. 'First Name'
    $lname = $user.'Last Name'
    $jtitle = $user.'Job Title'
    $officephone = $user.'Office Phone'
    $emailaddress = $user.Description
    $OUpath = $user.'Organizational Unit'

    # Create new AD user for each new user in CSV file
    New-ADUser -Name "$fname $lname" -GivenName $fname -Surname $lname -UserPrincipalName "$fname.$lname" -Path $OUpath -AccountPassword $securePassword -ChangePasswordAtLogon $true -OfficePhone $officephone -Description $description -Enabled $true -EmailAddress $emailaddress

    # Echo output for each new user
    echo "Account created for $fname $lname $jtitle $officephone"
}

