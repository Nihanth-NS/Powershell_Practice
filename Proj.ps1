###########################################################################Extra project#######################################################################################################
$services = @("WlanSvc","XboxNetApiSvc")
$process = @("brave")
foreach($ser in $services){
   $a=Get-Service -Name $ser
   [PSCustomObject]@{
        Time = get-date -Format "yyyy-MM-dd"
        Componet = "SERVICE"
        Name = $ser
        Status = if($a.Status -eq "Running"){
                        "Healthy"
                 }
                 else{
                   "Stopped and Restarted"
                 }
                        
   } | Out-File -FilePath "D:\DOWNLOAD\Downloads\profile.txt" -Append
   
}
if(-not(Test-Path -Path "D:\DOWNLOAD\Downloads\profile.txt")){
    "Time`tComponent`tName`tStatus" | Out-File -Filepath "D:\DOWNLOAD\Downloads\profile.txt"
  }
foreach($proc in $process){
  $a = Get-Process -Name $proc
 
  $t = get-date -Format "yyyy-MM-dd"
  $c = "Process"
  $n = $proc
  $s = if($proc){
        "Running"
        }
        else{
 
        "Stopped"
        }
 
  "$t`t$c`t$n`t$s"| out-file -FilePath "D:\DOWNLOAD\Downloads\profile.txt" -Append
 
 
}
 
$Event = Get-WinEvent -FilterHashtable @{
        LogName = 'Windows PowerShell'
        starttime = (get-date).AddDays(-1)
} | Where-Object LevelDisplayName -in "Error", "warning" | Select-Object TimeCreated,Id,LevelDisplayName,Message
$Event
Get-LocalUser | Where-Object Enabled -EQ "True" | Select-Object Name,Enabled,Description,Lastlogon
 
$a=(Get-CimInstance win32_ComputerSystem).TotalPhysicalMemory
$b=[Math]::Round($a/1GB,2)
$b
