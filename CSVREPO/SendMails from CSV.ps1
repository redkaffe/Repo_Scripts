#Raw script to send mails for deployments schedules
#PEJ-05/03/2019 - Eramet -in progress
#needs logging and CRED secure storage

#Script variables (mail, csv repo...)
#$smtpcred = (Get-Credential)
$fromAddress = "ext-pejoubert@eramet.com"
$SMTPServer = "EFP-MSGDAGP-01.ecm.era"
$SMTPPort = "587"
$CSVREPO= "C:\temp\CSVREPO\"


$Today= Get-Date -Format FileDate
$BATCH = Get-ChildItem -Path $CSVREPO -Recurse -Filter "$Today*"

Foreach($File in $BATCH){
    $F = import-csv -Path $CSVREPO\$file -Delimiter ";"
    $Project_t = $File.BaseName -split "_"
    $ProjectName = $($Project_t[1])
    
    foreach($L in $F)
        {
        If($L.lang = "EN"){
        $htmlbody = get-content "$($CVSREPO)Body_$($ProjectName)_EN.html" -Raw  

        Send-MailMessage -Credential $smtpcred –From $fromAddress –To $($L.MailAddress) –Subject "$ProjectName : Your attention is needed"`
         -BodyAsHtml $htmlbody –attachment "$($CVSREPO)$($ProjectName)_EN.pdf" -SmtpServer $SMTPServer #-Port $SMTPPort -UseSsl -verbose
        }
        If($L.lang = "FR"){
        $htmlbody = get-content "$($CVSREPO)Body_$($ProjectName)_FR.html" -Raw 
        Send-MailMessage -Credential $smtpcred –From $fromAddress –To $($L.MailAddress) –Subject "$ProjectName : Message important" `
         -BodyAsHtml $htmlbody  –attachment "$($CVSREPO)$($ProjectName)_FR.pdf" -SmtpServer $SMTPServer #-Port $SMTPPort -UseSsl -verbose
        }
        }
    $Project_t = $null
    $ProjectName = $null
    }
