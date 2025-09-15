##############################################################################DAY_5 Active Directory create delete updtae disable -users,OU,DC##################################################################################################################

 $abc = Import-Csv -Path "C:\Users\bandaru.nihanthsai\Downloads\Book(Sheet1).csv"
foreach($ab in $abc){
    $secpass = (ConvertTo-SecureString $ab.pass -AsPlainText -Force)
    #New-ADUser -name $ab.Name -SamAccountName $ab.Uname -Userprincipalname $ab.UPname -path "OU=$($ab.path_ou),dc=$($ab.path_dc1),dc=$($ab.path_dc2)" -AccountPassword $secpass -Enabled $true 
    Set-ADAccountPassword -Identity $ab.Uname -NewPassword $secpass -Reset
    Disable-ADAccount -Identity $ab.uname 
    Remove-ADUser -Identity $ab.uname -Confirm
  
  
} 
