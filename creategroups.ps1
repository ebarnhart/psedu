# Import Active Directory Module
Import-Module ActiveDirectory

#Import User Data
$csv = Import-Csv -Path C:\temp\adusers.csv

# Path to Security Groups OU
$groupOU = "OU=Groups,OU=Corp,DC=acme,DC=local"

#Import Unique Department Names
$groups = $csv.Department | Select-Object -Unique

foreach ($group in $groups) {

    #Info for Global group creation
    $GlobalGroupInfo = @{
        Name            = "$group Users"
        SamAccountName  = $group.ToLower() + "_users"
        Path            = $groupOU
        GroupScope      = "Global"
        GroupCategory   = "Security"
        Description    = "This group works in the $group Department"
    }

    #Info for Domain Local group creation
    $DomainLocalGroupInfo = @{
        Name            = "$group Resources"
        SamAccountName  = $group.ToLower() + "_resources"
        Path            = $groupOU
        GroupScope      = "DomainLocal"
        GroupCategory   = "Security"
        Description    = "This group manageds $group Department resources"
    }
    
    New-ADGroup @GlobalGroupInfo
    New-AdGroup @DomainLocalGroupInfo
    

}

