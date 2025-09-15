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

