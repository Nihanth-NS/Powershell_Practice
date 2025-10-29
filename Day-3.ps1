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
 ####################################USING MAILKIT with MIME######################################
 $cred = get-credential
 $from = [Mimekit.MailboxAddress]::new("Nihanth","nihanths17@gmail.com")
 $to = [Mimekit.InternetAddressList]::new()
 $to.add([Mimekit.InternetAddress]::new("thenihanth@gmail.com"))
 $cc = [Mimekit.InternetAddressList]::new()
 $cc.add([Mimekit.InternetAddress]::new("some@gmail.com"))
 $Bcc = [Mimekit.InternetAddressList]::new()
 $Bcc.add([Mimekit.InternetAddress]::new("some@gmail.com"))
 $subject = "TESTING"
 $html_body = "<h2> THIS IS GOOD </h2>
               <p> Mail SENT </p>"
$attachments = @("path/to/file",path/to/file)
Send-mailKitMessage -SMTPServer "smtp.gmail.com"
                    - port 587
                    - credential $cred
                    - From $from
                    - Receipient $to
                    - CCReceipient $cc
                    - BccReceipient $bcc
                    - Subject $subject
                    - HTML Body $html_body
                    - Attachment $attachments
