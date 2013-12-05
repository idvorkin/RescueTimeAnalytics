RescueTimeAnalytics
===================

Visualize your [RescueTime](www.rescuetime.com) data in [Tableau Public](http://public.tableausoftware.com/views/ScreenTimeAnalytics/root?:embed=y&:display_count=no#1).  

This project contains:

  * A rescuse time telemetry downloader
  * A tableau workbook with an embedded dataset you can replace with your own downloaded telemetry

Telemetry Downloader
-------------------------
Use Powershell API to download rescue time data and convert to a tableau compatible file format

    PS> . .\RescueTime.ps1
    PS> WriteRescueDataToFileInTableauCompatibleFormat "myapiKey" 'c:\temp\rescue2.csv'
Import Data Into Tableau Public Work Book
----------------------------------
  TBD

