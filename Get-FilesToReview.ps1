#Get-FilesToReview

function Get-FilesToReview {
    param (
        [String[]]$Path,
        [int]$DaysSinceAccess)
    $AccessDate = (Get-Date).AddDays(-$DaysSinceAccess)
    Get-ChildItem -Path $Path -Recurse | Where-Object {$_.LastAccessTime -le $AccessDate} | Select-Object Name,Directory,CreationTime,LastAccessTime
}

