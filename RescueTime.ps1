# Download data from rescue time and cleanup format.
# $apiKey = "YourSecretHere"
# . .\RescueTime.ps1
# GetRescueData($apiKey) | ConvertTo-Csv -NoTypeInformation | % {$_ -replace'"' '' | out-file c:\temp\foo.csv
# WriteRescueDataToFileInTableauCompatibleFormat "key" "c:\temp\rescue.csv"
# Import into tableau, and set encoding to UTF16
 
function GetRescueData  ($apiKey)
{
    # Download CSV from RescueTime
    $dateRangeParams = "&rb=$(((Get-Date)-(New-TimeSpan -Days 30)).ToString('yyyy-MM-dd'))&re=$((Get-Date).ToString('yyyy-MM-dd'))"
    $url = "https://www.rescuetime.com/anapi/data?format=csv&by=interval&key=$apiKey$dateRangeParams"

    $tempFile = [IO.Path]::GetTempFileName()
    $wget = new-object System.Net.WebClient
    $wget.DownloadFile( $url, $tempFile )

    # add and cleanup columns to simplify analysis
    $addAnalysisColumnsToRescueTimeObject = {  $_ | Add-Member  @{DateTime =[datetime]$_.Date; TableauDate = ([datetime]$_.Date).ToString("yyyy-MM-dd HH:mm");TimeSpentHours = $_.'Time Spent (seconds)'/3600.0} -Pass }

    #remove some html encoding before converting to objects (XXX: figure out "real" converter)
    Get-Content -Path $tempFile | % {$_-replace '&amp;','&'} |ConvertFrom-Csv | % $addAnalysisColumnsToRescueTimeObject 
}

function WriteRescueDataToFileInTableauCompatibleFormat($apiKey, $outfile)
{
    GetRescueData($apiKey) | ConvertTo-Csv -NoTypeInformation | % {$_ -replace '"','' }| out-file -filePath $outfile -Force
}