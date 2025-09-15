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


