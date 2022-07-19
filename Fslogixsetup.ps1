######################
#    avd Variables   ##
######################
$Localavdpath            = "c:\temp\avd\"
$FSLogixURI              = 'https://aka.ms/fslogix_download'
$FSInstaller             = 'FSLogixAppsSetup.zip'


####################################
#    Test/Create Temp Directory    #
####################################
if((Test-Path c:\temp) -eq $false) {
    Add-Content -LiteralPath C:\New-avdSessionHost.log "Create C:\temp Directory"
    Write-Host `
        -ForegroundColor Cyan `
        -BackgroundColor Black `
        "creating temp directory"
    New-Item -Path c:\temp -ItemType Directory
}
else {
    Add-Content -LiteralPath C:\New-avdSessionHost.log "C:\temp Already Exists"
    Write-Host `
        -ForegroundColor Yellow `
        -BackgroundColor Black `
        "temp directory already exists"
}
if((Test-Path $Localavdpath) -eq $false) {
    Add-Content -LiteralPath C:\New-avdSessionHost.log "Create C:\temp\avd Directory"
    Write-Host `
        -ForegroundColor Cyan `
        -BackgroundColor Black `
        "creating c:\temp\avd directory"
    New-Item -Path $Localavdpath -ItemType Directory
}
else {
    Add-Content -LiteralPath C:\New-avdSessionHost.log "C:\temp\avd Already Exists"
    Write-Host `
        -ForegroundColor Yellow `
        -BackgroundColor Black `
        "c:\temp\avd directory already exists"
}



#################################
#    Download avd Componants    #
#################################
Add-Content -LiteralPath C:\New-avdSessionHost.log "Downloading FSLogix"
    Invoke-WebRequest -Uri $FSLogixURI -OutFile "$Localavdpath$FSInstaller"


##############################
#    Prep for avd Install    #
##############################
Add-Content -LiteralPath C:\New-avdSessionHost.log "Unzip FSLogix"
Expand-Archive `
    -LiteralPath "C:\temp\avd\$FSInstaller" `
    -DestinationPath "$Localavdpath\FSLogix" `
    -Force `
    -Verbose
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
cd $Localavdpath 
Add-Content -LiteralPath C:\New-avdSessionHost.log "UnZip FXLogix Complete"


#########################
#    FSLogix Install    #
#########################
Add-Content -LiteralPath C:\New-avdSessionHost.log "Installing FSLogix"
$fslogix_deploy_status = Start-Process `
    -FilePath "$Localavdpath\FSLogix\x64\Release\FSLogixAppsSetup.exe" `
    -ArgumentList "/install /quiet" `
    -Wait `
    -Passthru
