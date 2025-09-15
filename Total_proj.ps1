

#############################################DAY-1 LEARNING ABOUT -PSCUSTOMOBJECT - SELECTOBJECT WHEREOBJECT ROUNDVALUE EXPORTING AND TASK SCHEDULING ############################################################
        $cmp=$env:COMPUTERNAME
        $name=(Get-CimInstance Win32_processor).Name
        $manf=(Get-CimInstance Win32_processor).Manufacturer
        $os=(Get-CimInstance Win32_OperatingSystem).SystemDirectory
        $os_ver= (Get-CimInstance Win32_OperatingSystem).Version
        $Cores=(Get-CimInstance Win32_processor).NumberOfCores
        $t_Mem = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory
        $memo = [math]::Round($t_Mem/1GB,2)
        $full=(Get-CimInstance Win32_LogicalDisk).Size
        $FULL_MEM = [math]::Round($full/1GB,2)
        $used=(Get-CimInstance Win32_LogicalDisk).FreeSpace
        $USED_MEM = [math]::Round($used/1GB,2)




$Prop=[PSCustomObject]@{
        Time = Get-Date
        Comp_Name = $cmp
        NAME = $name
        MANFAC = $manf
        OPSY = $os
        OSVERS = $os_ver
        SYSTEM_CORES = $Cores
        Total_RAM = $memo
        Total_Disk = $FULL_MEM
        free_Space = $USED_MEM
        

}

$prop | Export-Csv -Path "C:\Users\bandaru.nihanthsai\Downloads\examplefile.csv" -NoTypeInformation -Append

#################################################################DAY_2 LEARNED ABOUT  -like TEST-path TOLOWER NEW-item Move-ITEM get-childitem################################################################################

if(-not(Test-Path -Path "C:\Users\bandaru.nihanthsai\Downloads\PDF_FOLDER")){
        New-Item -Path "C:\Users\bandaru.nihanthsai\Downloads\PDF_FOLDER" -ItemType Directory
    }
if(-not(Test-Path -Path "C:\Users\bandaru.nihanthsai\Downloads\PEM_FOLDER")){
        New-Item -Path "C:\Users\bandaru.nihanthsai\Downloads\PEM_FOLDER" -ItemType Directory
    }
if(-not(Test-Path -Path "C:\Users\bandaru.nihanthsai\Downloads\TEXT_FOLDER")){
        New-Item -Path "C:\Users\bandaru.nihanthsai\Downloads\TEXT_FOLDER" -ItemType Directory
    }
$Items = Get-ChildItem -path "C:\Users\bandaru.nihanthsai\Downloads" -file
foreach($Item in $Items){
    $lowerd_one=$Item.Name.ToLower()
    if($lowerd_one -like "*.pdf"){
                Move-Item -Path $Item.FullName -Destination "C:\Users\bandaru.nihanthsai\Downloads\PDF_FOLDER"
            }
    elseif($lowerd_one -like "*.pem"){
                Move-Item -Path $Item.FullName -Destination "C:\Users\bandaru.nihanthsai\Downloads\PEM_FOLDER"
        }
    elseif($lowerd_one -like "*.txt"){
                Move-Item -Path $Item.FullName -Destination "C:\Users\bandaru.nihanthsai\Downloads\TEXT_FOLDER"
        }
    }

###############################################################DAY_3 learned about test-connection,![string]::IsNullOrWhiteSpace,get-content, send-mailMessage######################################################################################################################
  $servers = Get-Content -path "C:\Users\Administrator.DEMO\Downloads\Server_names.txt"
 foreach($server in $servers){
    if(![string]::IsNullOrWhiteSpace($server)){
        try{
            $name=Test-Connection -ComputerName $server -Count 1 -ErrorAction Stop
            if($name){
                
                write-host $server "is reachable"
                $Responsee_Time = $name.ResponseTime
                $prop = [PSCustomObject]@{
                        TIME_STAMP = Get-Date
                        Server_name = $server
                        Status = "UP"
                        Response_Time = $Responsee_Time
                        }
                $prop | Export-csv -path "C:\Users\Administrator.DEMO\Downloads\log_data.csv" -Append -NoTypeInformation

  
            }
            else{
                Write-Host $server "not reachable"
                $prop = [PSCustomObject]@{
                        TIME_STAMP = Get-Date
                        Server_name = $server
                        Status = "DOWN"
                        Response_Time = "N/A"
                        }
                $prop | Export-csv -path "C:\Users\Administrator.DEMO\Downloads\log_data.csv" -Append -NoTypeInformation
                $cred = Get-Credential
                Send-MailMessage -To "nihanths17@gmail.com" -from "thenihanth@gmail.com" -Subject "SERVER DOWN" -Body $server "IS DOWN" -SmtpServer "smtp.gmail.com" -Port 587 -UseSsl -Credential $cred
                    

            }
        }
        catch{
            Write-Host "Server Down or Server doesn't exist"
            $prop = [PSCustomObject]@{
                        TIME_STAMP = Get-Date
                        Server_name = $server
                        Status = "DOWN"
                        Response_Time = "N/A"
                        }
                $prop | Export-csv -path "C:\Users\Administrator.DEMO\Downloads\log_data.csv" -Append -NoTypeInformation
        }
    }
    
  
 }
 
#########################################################################Day-4 (Get-Date).AddDays(-7),compress-archive, Remove-item, "$($path.fullName).zip"#####################################################################################################
cd C:\Users\bandaru.nihanthsai\Downloads
$acd = ls
$b = (Get-Date).AddDays(-7)
foreach($ac in $acd){
    if($ac.Name -like "*.pdf"){
       if($ac.LastWriteTime -le $b){
          $path = $ac.FullName
          Compress-Archive -Path $path -DestinationPath "$($path).zip"
          Remove-Item -Path $path
       }
    }
}


###############################################################################DAY_5 Active Directory create delete updtae disable -users,OU,DC##################################################################################################################

 $abc = Import-Csv -Path "C:\Users\bandaru.nihanthsai\Downloads\Book(Sheet1).csv"
foreach($ab in $abc){
    $secpass = (ConvertTo-SecureString $ab.pass -AsPlainText -Force)
    #New-ADUser -name $ab.Name -SamAccountName $ab.Uname -Userprincipalname $ab.UPname -path "OU=$($ab.path_ou),dc=$($ab.path_dc1),dc=$($ab.path_dc2)" -AccountPassword $secpass -Enabled $true 
    Set-ADAccountPassword -Identity $ab.Uname -NewPassword $secpass -Reset
    Disable-ADAccount -Identity $ab.uname 
    Remove-ADUser -Identity $ab.uname -Confirm
  
  
} 

#############################################################################DAY_6 Get-EventLog, Get-WinEvent ##########################################################################################################
Get-WinEvent -FilterHashtable @{
    LogName = 'Application'
    starttime = (Get-Date).AddDays(-7)
    endtime = (Get-Date)

}-MaxEvents 10 |Select-Object Id,ProviderName,TimeCreated | export-csv -Path "C:\Users\bandaru.nihanthsai\Downloads\scr.csv" -NoTypeInformation

#############################################################################DAY_7 Get-service, Get-Process, Function logfiles ####################################################################################################################
$abc = Get-Process
$c = 0
function logs{
  param($message) 
  $stamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
  "$stamp : $message" | Out-File -FilePath "C:\Users\bandaru.nihanthsai\Downloads\example.log" -Append

  }

foreach($ab in $abc){
    if($ab.ProcessName -eq "chrome"){
        $c=$c+1
    }
}
if($c -eq 0){
try{
   Start-Process -FilePath "chrome.exe"
   logs "Stared chrome"
   }
   catch{
     logs "Unable to start the chrome"

   }
}
else{

  logs "Chrome is already running"
}


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
        $file_name = Get-date -Format 'yyyy-MM-dd'
        $path = "C:\Users\bandaru.nihanthsai\Downloads\LOGS\LOG_$file_name.log"
        $Check = Get-ChildItem -Path "C:\Users\bandaru.nihanthsai\Downloads\LOGS"
        $ac = Get-ChildItem -Path "C:\Users\bandaru.nihanthsai\Downloads\LOGS"
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

###################################################################DAY-9 AWS Module installation,EC2 interact##########################################################################################################
Install-Module -Name AWS.Tools.Common -Scope CurrentUser -Force
Install-Module -Name AWS.Tools.EC2 -Scope CurrentUser -Force
Import-Module AWS.Tools.Common
Import-Module AWS.Tools.EC2
Set-AWSCredential -AccessKey  -SecretKey  -StoreAs default
Get-EC2Instance -Region ap-southeast-2
Get-EC2Instance -Region ap-southeast-2 | Select-Object -ExpandProperty Instances |
    Select-Object InstanceId, State, InstanceType, PrivateIpAddress, PublicIpAddress
Stop-EC2Instance -Region ap-southeast-2 -InstanceId i-010b59e51988e0dd4
(Get-EC2Instance -Region ap-southeast-2 -InstanceId i-010b59e51988e0dd4).Instances.state

###########################################################################Extra project#######################################################################################################
$services = @("WlanSvc","XboxNetApiSvc")
$process = @("brave")
<#foreach($ser in $services){
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
