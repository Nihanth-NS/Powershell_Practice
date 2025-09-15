#################################################################DAY_2 LEARNED ABOUT  -like, TEST-path, TOLOWER ,NEW-item, Move-ITEM, get-childitem################################################################################

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
