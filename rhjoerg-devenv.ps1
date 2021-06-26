
#------------------------------------------------------------------------------

$devenv = (Get-Item -Path ".").FullName

#------------------------------------------------------------------------------

function Test-Missing
{
    param ($Path)

    -Not (Test-Path $Path)
}

#------------------------------------------------------------------------------

Write-Host "Creating Directories" -ForegroundColor Green
New-Item -Name "downloads" -ItemType "directory" -ErrorAction Ignore
New-Item -Name "jdk" -ItemType "directory" -ErrorAction Ignore
New-Item -Name "git" -ItemType "directory" -ErrorAction Ignore
New-Item -Name "maven" -ItemType "directory" -ErrorAction Ignore
New-Item -Name "maven\repository" -ItemType "directory" -ErrorAction Ignore
New-Item -Name "workspace" -ItemType "directory" -ErrorAction Ignore
New-Item -Name "workspace\.metadata" -ItemType "directory" -ErrorAction Ignore
New-Item -Name "workspace\.metadata" -ItemType "directory" -ErrorAction Ignore
New-Item -Name "workspace\.metadata\.plugins" -ItemType "directory" -ErrorAction Ignore
New-Item -Name "workspace\.metadata\.plugins\org.eclipse.core.runtime" -ItemType "directory" -ErrorAction Ignore
New-Item -Name "workspace\.metadata\.plugins\org.eclipse.core.runtime\.settings" -ItemType "directory" -ErrorAction Ignore

#------------------------------------------------------------------------------

Write-Host "Installing JDK-11" -ForegroundColor Green

$jdk11ExePath = "jdk\jdk-11\bin\java.exe"
$jdk11ZipPath = "downloads\jdk-11.zip"
$jdk11Uri = "https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_windows-x64_bin.zip"

if (Test-Missing -Path $jdk11ExePath)
{
    if (Test-Missing -Path $jdk11ZipPath)
    {
        Invoke-WebRequest -OutFile $jdk11ZipPath -Uri $jdk11Uri
    }

    Expand-Archive -Path $jdk11ZipPath -DestinationPath "jdk" -Force
}

#------------------------------------------------------------------------------

Write-Host "Installing JDK-16" -ForegroundColor Green

$jdk16ExePath = "jdk\jdk-16\bin\java.exe"
$jdk16ZipPath = "downloads\jdk-16.zip"
$jdk16Uri = "https://download.java.net/openjdk/jdk16/ri/openjdk-16+36_windows-x64_bin.zip"

if (Test-Missing -Path $jdk16ExePath)
{
    if (Test-Missing -Path $jdk16ZipPath)
    {
        Invoke-WebRequest -OutFile $jdk16ZipPath -Uri $jdk16Uri
    }

    Expand-Archive -Path $jdk16ZipPath -DestinationPath "jdk" -Force
}

#------------------------------------------------------------------------------

Write-Host "Installing Maven settings" -ForegroundColor Green

$mavenSettingsPath = "maven/settings.xml"
$mavenSettingsUri = "https://github.com/rhjoerg/rhjoerg-devenv/releases/download/latest/settings.xml"

Remove-Item -Path $mavenSettingsPath -ErrorAction Ignore
Invoke-WebRequest -OutFile $mavenSettingsPath -Uri $mavenSettingsUri
(Get-Content -path $mavenSettingsPath -Raw) -replace "%DEVENV%", $devenv | Set-Content -Path $mavenSettingsPath

#------------------------------------------------------------------------------

Write-Host "Installing Eclipse 2021-06" -ForegroundColor Green

$eclipseExePath = "eclipse\eclipse.exe"
$eclipseZipPath = "downloads\eclipse.zip"
$eclipseZipUri = "https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/2021-06/R/eclipse-rcp-2021-06-R-win32-x86_64.zip&r=1"

if (Test-Missing -Path $eclipseExePath)
{
    if (Test-Missing -Path $eclipseZipPath)
    {
        Invoke-WebRequest -OutFile $eclipseZipPath -Uri $eclipseZipUri
    }
    Expand-Archive -Path $eclipseZipPath -DestinationPath "." -Force
}

#------------------------------------------------------------------------------

Write-Host "Configuring Eclipse" -ForegroundColor Green

$eclipseIniPath = "eclipse\eclipse.ini"
$eclipseIniLength = (Get-Item -Path $eclipseIniPath).Length
$eclipseIniUri = "https://github.com/rhjoerg/rhjoerg-devenv/releases/download/latest/eclipse.ini"

if ($eclipseIniLength -eq 714)
{
    Remove-Item -Path $eclipseIniPath -ErrorAction Ignore
    Invoke-WebRequest -OutFile $eclipseIniPath -Uri $eclipseIniUri
    (Get-Content -path $eclipseIniPath -Raw) -replace "%DEVENV%", $devenv | Set-Content -Path $eclipseIniPath
}

$jdtPrefsPath = "workspace\.metadata\.plugins\org.eclipse.core.runtime\.settings\org.eclipse.jdt.launching.prefs"
$jdtPrefsUri = "https://github.com/rhjoerg/rhjoerg-devenv/releases/download/latest/org.eclipse.jdt.launching.prefs"

Remove-Item -Path $jdtPrefsPath -ErrorAction Ignore
Invoke-WebRequest -Outfile $jdtPrefsPath -Uri $jdtPrefsUri

#------------------------------------------------------------------------------

Write-Host "Installing additional Eclipse features" -ForegroundColor Green

Set-Location eclipse
.\eclipsec.exe -noSplash -application org.eclipse.equinox.p2.director -repository https://download.eclipse.org/releases/2021-06/202106161001/ -installIU org.eclipse.jdt.feature.group
Set-Location ..

#------------------------------------------------------------------------------
