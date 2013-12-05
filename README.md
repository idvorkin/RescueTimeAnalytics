RescueTimeAnalytics
===================


Telemetry Download and Import To Tableau
-------------------------

Custom Analytics for Rescue Time Data (http://www.rescuetime.com)

Use Powershell API to download rescue time data and convert to a tableau compatible file format

    PS> . .\RescueTime.ps1
    PS> WriteRescueDataToFileInTableauCompatibleFormat "myapiKey" 'c:\temp\rescue2.csv'

Then import this data into this taleau work book

