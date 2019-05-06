# Import required modules
Import-Module ActiveDirectory
$exit = ""

while($exit -ne "q") {
    # Store users first name into variable
    $firstname = Read-Host -Prompt "Please enter your first name"
    $lastname = Read-Host -Prompt "Please enter your last name"
    $password = "Password01"

    # Output users information
    echo "Your full name is $firstname, $lastname. Your password is $password."

    # Specify where to store the user account
    $OUpath = "OU=PowerShellUsers,DC=syswire,DC=com"

    # Convert password to secure string
    $securePassword = ConvertTo-SecureString $password -AsPlainText -Force


    # Create user account
    New-ADUser -Name "$firstname $lastname" -GivenName $firstname -Surname $lastname -UserPrincipalName "$firstname, $lastname" -Path $OUpath -AccountPassword $securePassword -ChangePasswordAtLogon $true -Enabled $true

    # Exit the loop
    $exit = Read-Host -Prompt "Type 'q' to stop creating user accounts."
}