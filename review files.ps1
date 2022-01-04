#Parameters
param([string]$source="",[string]$destination="",[string]$Days)

$Days = Read-Host "Please enter a day count"
$source = Read-Host "Please enter a source file path"
$destination = Read-Host "Please enter a destination file path for files not opened for $Days."

#Functions
#Make sure the path exists
function Check-Folder([string]$path, [switch]$create){
    $exists = Test-Path $path

    if(!$exists -and $create){
        #create the directory because it doesn't exist
        mkdir $path | out-null
        $exists = Test-Path $path
    }
    return $exists
}

$sourceexists = Check-Folder $source

if (!$sourceexists){
    Write-Host "The source directory is not found. Script can not continue."
    Exit
}

$files = dir $source -Recurse | where {!$_.PSIsContainer}

foreach ($file in $files){

    $FileInfo = Get-ItemProperty -Path $file 

   $FileAccesstime = $($FileInfo).LastAccessTime
   $ALLFILEINFO = $FileInfo | Select-Object `
   @{Exp=($_.Name);label="File Name"}, `
   @{Exp=($_.CreattionTime);label="Date of creation"}, `
   @{Exp=($_.LastAccessTime);label="Last Access time"}, `
   @{Exp=($_.directory);label="Path"}

   $ALLFILEINFO | Export-Csv -Path <#ENTER PATH BEFORE USE#>
}

