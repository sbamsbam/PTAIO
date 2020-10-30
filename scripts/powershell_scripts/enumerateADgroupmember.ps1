$domainObj  =  [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain() 

$PDC = ($domainObj.PdcRoleOwner).Name

$SearchString = “LDAP://”

$SearchString += $PDC + “/”

$DistinguishedName = “DC=$($domainObj.Name.Replace(',', ‘,DC=’))”

$SearchString += $DistinguishedName

$SearchString

$Searcher = New-Object System.DirectoryServices.DirectorySearcher([ADSI]$SearchString)

$objDomain = New-Object system.DirectoryServices.DirectoryEntry

$Searcher.SearchRoot = $objDomain

$Searcher.filter="(name=secret_Group)"

$Result = $Searcher.FindAll()

Foreach($obj in $Result)
{
        $obj.Properties.member
        
}
        
