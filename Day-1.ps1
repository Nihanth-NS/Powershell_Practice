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

