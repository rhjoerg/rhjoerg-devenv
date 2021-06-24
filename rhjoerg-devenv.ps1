Write-Host "Creating Directories" -ForegroundColor Green
New-Item -Name "downloads" -ItemType "directory" -ErrorAction Ignore
New-Item -Name "jdk" -ItemType "directory" -ErrorAction Ignore
New-Item -Name "workspace" -ItemType "directory" -ErrorAction Ignore
New-Item -Name "workspace\.metadata" -ItemType "directory" -ErrorAction Ignore
New-Item -Name "workspace\.metadata" -ItemType "directory" -ErrorAction Ignore
New-Item -Name "workspace\.metadata\.plugins" -ItemType "directory" -ErrorAction Ignore
New-Item -Name "workspace\.metadata\.plugins\org.eclipse.core.runtime" -ItemType "directory" -ErrorAction Ignore
New-Item -Name "workspace\.metadata\.plugins\org.eclipse.core.runtime\.settings" -ItemType "directory" -ErrorAction Ignore

Write-Host "Installing JDK-11" -ForegroundColor Green

$jdk11ExePath = "jdk\jdk-11\bin\java.exe"
$jdk11ZipPath = "downloads\jdk-11.zip"
$jdk11Uri = "https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_windows-x64_bin.zip"

if (-Not (Test-Path $jdk11ExePath))
{
    if (-Not (Test-Path $jdk11ZipPath))
    {
        Invoke-WebRequest -OutFile $jdk11ZipPath -Uri $jdk11Uri
    }

    Expand-Archive -Path $jdk11ZipPath -DestinationPath "jdk" -Force
}

Write-Host "Installing JDK-16" -ForegroundColor Green

$jdk16ExePath = "jdk\jdk-16\bin\java.exe"
$jdk16ZipPath = "downloads\jdk-16.zip"
$jdk16Uri = "https://download.java.net/openjdk/jdk16/ri/openjdk-16+36_windows-x64_bin.zip"

if (-Not (Test-Path $jdk16ExePath))
{
    if (-Not (Test-Path $jdk16ZipPath))
    {
        Invoke-WebRequest -OutFile $jdk16ZipPath -Uri $jdk16Uri
    }

    Expand-Archive -Path $jdk16ZipPath -DestinationPath "jdk" -Force
}

Write-Host "Installing Ant 1.10" -ForegroundColor Green

$antCmdPath = "ant\bin\ant.cmd"
$antZipPath = "downloads\ant.zip"

if (-Not (Test-Path $antCmdPath))
{
    if (-Not (Test-Path $antZipPath))
    {
        Invoke-WebRequest -OutFile $antZipPath -Uri "https://downloads.apache.org//ant/binaries/apache-ant-1.10.10-bin.zip"
    }

    Expand-Archive -Path $antZipPath -DestinationPath "." -Force
    Remove-Item -Path "ant" -Recurse -Force -ErrorAction Ignore
    Move-Item -Path "apache-ant-1.10.10" -Destination "ant"
}

Write-Host "Installing Eclipse" -ForegroundColor Green

$eclipseExePath = "eclipse\eclipse.exe"
$eclipseZipPath = "downloads\eclipse.zip"
$eclipseZipUri = "https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/2021-06/R/eclipse-rcp-2021-06-R-win32-x86_64.zip&r=1"

if (-Not (Test-Path $eclipseExePath))
{
    if (-Not (Test-Path $eclipseZipPat))
    {
        Invoke-WebRequest -OutFile $eclipseZipPath -Uri $eclipseZipUri
    }
    Expand-Archive -Path $eclipseZipPath -DestinationPath "." -Force
}

Write-Host "Configuring Eclipse" -ForegroundColor Green

$eclipseIniPath = "eclipse\eclipse.ini"
$eclipseIniLength = (Get-Item -Path $eclipseIniPath).Length
$eclipseIniUri = "https://github.com/rhjoerg/rhjoerg-devenv/releases/download/latest/eclipse.ini"

if ($eclipseIniLength -eq 714)
{
    Remove-Item -Path $eclipseIniPath
    Invoke-WebRequest -OutFile $eclipseIniPath -Uri $eclipseIniUri
}

$antPrefsPath = "workspace\.metadata\.plugins\org.eclipse.core.runtime\.settings\org.eclipse.ant.core.prefs"
$antPrefsUri = "https://github.com/rhjoerg/rhjoerg-devenv/releases/download/latest/org.eclipse.ant.core.prefs"

if (-Not (Test-Path $antPrefsPath))
{
    Invoke-WebRequest -Outfile $antPrefsPath -Uri $antPrefsUri
}
