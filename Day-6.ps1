#############################################################################DAY_6 Get-EventLog, Get-WinEvent ##########################################################################################################
Get-WinEvent -FilterHashtable @{
    LogName = 'Application'
    starttime = (Get-Date).AddDays(-7)
    endtime = (Get-Date)

}-MaxEvents 10 |Select-Object Id,ProviderName,TimeCreated | export-csv -Path "C:\Users\bandaru.nihanthsai\Downloads\scr.csv" -NoTypeInformation
