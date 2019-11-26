REM Create Logfile Directories 
IF NOT EXIST "C:\Temp\ApplicationLogs" MD "C:\Temp\ApplicationLogs"
REM Define Logfiles
set LOGFILE1=%SystemDrive%\Temp\ApplicationLogs\WSO_Client.log
set LOGFILE2=%SystemDrive%\Temp\ApplicationLogs\AV_Client.log

REM Install MSI
echo Install VM Ware Workspace One Client >> %LOGFILE1%
msiexec /i "AirWatchAgent.msi" /q ENROLL=Y SERVER=users.somobile.sodexonet.com LGName=WKSWSO USERNAME=staging@wkswso.com PASSWORD=E+9kxu DOWNLOADWSBUNDLE=TRUE /LOG %LOGFILE1%
echo result: %ERRORLEVEL% >> %LOGFILE1%

REM Install MSI
echo Install AV Client >> %LOGFILE2%
msiexec /i "GRP.HQ_SmartScan.msi" /qn /norestart /l
echo result: %ERRORLEVEL% >> %LOGFILE2%

