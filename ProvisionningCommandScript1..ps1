#Test PS SCript for WICD 
[CmdletBinding()]
[Alias()]
[OutputType([int])]

Param
(
 [Parameter(Mandatory=$false,
 ValueFromPipelineByPropertyName=$true,
 Position=0)]
 $Log = "$env:TEMP\Start-ProvisioningCommands.log"
)

Begin
{
 <#
 # Start logging
 #>
 Start-Transcript -Path $Log -Force -ErrorAction SilentlyContinue

<#
 # Extract the ZIP
 #> 
 $Archives = Get-ChildItem -Path $PSScriptRoot -Filter *.zip | Select-Object -Property FullName
 ForEach-Object -InputObject $Archives -Process { Expand-Archive -Path $_.FullName -DestinationPath "$env:TEMP" -Force }
}

Process
{
 <#
 # Office 2016 installation
 #> 
 $WorkingDirectory = "$env:TEMP\O365"

 # Run Office 2016 setup.exe
 Start-Process -FilePath "$WorkingDirectory\Setup.exe" -ArgumentList ('/Configure "{0}"' -f $Configuration.FullName) -WorkingDirectory $WorkingDirectory -Wait -WindowStyle Hidden

 # If you want to remove the extracted source, uncomment below
 # Remove-Item -Path $WorkingDirectory -Force
}
End
{
 <#
 # Stop logging
 #> 
 Stop-Transcript -ErrorAction SilentlyContinue
}