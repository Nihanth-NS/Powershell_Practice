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
