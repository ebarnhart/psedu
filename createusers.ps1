
# Import Active Directory Module
Import-Module ActiveDirectory

#Read in Temporary Secure Password.  Must meet company complexity requirements.
$AccountPassword = Read-Host -AsSecureString -Prompt "Enter Temporary Password for New Users"

#Import User Data
$csv = Import-Csv -Path C:\temp\adusers.csv

#Loop through Users
foreach ($user in $csv) {

    #Store User Attributes for Splatting
    $UserInfo = @{
        Name = $user.Name
        DisplayName = $user.Name
        GivenName = $user.GivenName
        Surname = $user.Surname
        SamAccountName = $user.SamAccountName
        Title = $user.Title
        Department = $user.Department
        Company = $user.Company
        EmailAddress = $user.EmailAddress
        AccountPassword = $AccountPassword
        ChangePasswordAtLogon = $true
        Path = $user.Path
        Enabled = $true
    }

    #Create New Users
    New-ADUser @UserInfo
    
}