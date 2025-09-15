#######################################################################Day_8 INVOKE-COMMAND#############################################################################################
$abc = @("windows powershell", "application")
$check_name = Get-date -Format 'yyyy-MM-dd'
if(!(Test-Path -Path "C:\Users\bandaru.nihanthsai\Downloads\LOGS\LOG_$check_name.log")){
    foreach($ab in $abc){
        $me = Get-WinEvent -FilterHashtable @{
                 Logname = $ab
                 Starttime = (get-date).AddDays(-1)
                 endtime = (get-date)

        }
        foreach($mee in $me){
        $mess = ($mee.Message -split "`r`n")[0]
        $date = $mee.TimeCreated
        $cdate = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
        $path = "C:\Users\bandaru.nihanthsai\Downloads\LOGS\LOG_$file_name.log"
        
        "$cdate : $date :$mess" | Out-File -FilePath $path -Append
    
        }}
}

else{

Write-Host "File already exists"
}
$pqr = Get-ChildItem -Path "C:\Users\bandaru.nihanthsai\Downloads\LOGS"
foreach($pq in $pqr){
    $b=Get-Date
    if($pq.LastWriteTime.Date -ne $b.Date){
        Remove-Item -Path $pq.FullName
    }  
}



$cred = Get-Credential
Invoke-Command -ComputerName "JUMPHOST" -ScriptBlock {Get-date | out-file -path "C:\Users\Administrator.DEMO\Downloads\example.txt"} -Credential $cred

