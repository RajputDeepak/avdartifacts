######################
#    Chrome Variables   ##
######################
$Localchromepath            = "c:\temp\chrome\"
$ChromeURI              = 'https://github.com/RajputDeepak/avdartifacts/blob/main/Software/Chrome/version/ChromeStandaloneSetup64.exe'
$ChromeInstaller             = 'ChromeStandaloneSetup64.exe'


####################################
#    Test/Create Temp Directory    #
####################################
if((Test-Path c:\temp) -eq $false) {
    Add-Content -LiteralPath C:\chrome.log "Create C:\temp Directory"
    Write-Host `
        -ForegroundColor Cyan `
        -BackgroundColor Black `
        "creating temp directory"
    New-Item -Path c:\temp -ItemType Directory
}
else {
    Add-Content -LiteralPath C:\chrome.log "C:\temp Already Exists"
    Write-Host `
        -ForegroundColor Yellow `
        -BackgroundColor Black `
        "temp directory already exists"
}
if((Test-Path $Localchromepath) -eq $false) {
    Add-Content -LiteralPath C:\chrome.log "Create C:\temp\chrome Directory"
    Write-Host `
        -ForegroundColor Cyan `
        -BackgroundColor Black `
        "creating c:\temp\chrome directory"
    New-Item -Path $Localchromepath -ItemType Directory
}
else {
    Add-Content -LiteralPath C:\chrome.log "C:\temp\chrome Already Exists"
    Write-Host `
        -ForegroundColor Yellow `
        -BackgroundColor Black `
        "c:\temp\chrome directory already exists"
}



#################################
#    Download Chrome    #
#################################
Add-Content -LiteralPath C:\chrome.log "Downloading Chrome Installer"
    Invoke-WebRequest -Uri $ChromeURI -OutFile "$Localchromepath$ChromeInstaller"


########################
#    Chrome Install    #
#########################
Add-Content -LiteralPath C:\chrome.log "Installing Chrome"
# $Chrome_deploy_status = Start-Process `
#     -FilePath "$Localchromepath\$ChromeInstaller" `
#     -ArgumentList "/install /quiet" `
#     -Wait `
#     -Passthru
