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
if (-Not (Test-Path "jdk\jdk-11\bin\java.exe"))
{
    if (-Not (Test-Path "downloads\jdk-11.zip"))
    {
        Invoke-WebRequest -OutFile "downloads\jdk-11.zip" -Uri "https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_windows-x64_bin.zip"
    }
    Expand-Archive -Path "downloads\jdk-11.zip" -DestinationPath "jdk" -Force
}

Write-Host "Installing JDK-16" -ForegroundColor Green
if (-Not (Test-Path "jdk\jdk-16\bin\java.exe"))
{
    if (-Not (Test-Path "downloads\jdk-16.zip"))
    {
        Invoke-WebRequest -OutFile "downloads\jdk-16.zip" -Uri "https://download.java.net/openjdk/jdk16/ri/openjdk-16+36_windows-x64_bin.zip"
    }
    Expand-Archive -Path "downloads\jdk-16.zip" -DestinationPath "jdk" -Force
}

Write-Host "Installing Ant 1.10" -ForegroundColor Green
if (-Not (Test-Path "ant\bin\ant.cmd"))
{
    if (-Not (Test-Path "downloads\ant.zip"))
    {
        Invoke-WebRequest -OutFile "downloads\ant.zip" -Uri "https://downloads.apache.org//ant/binaries/apache-ant-1.10.10-bin.zip"
    }
    Expand-Archive -Path "downloads\ant.zip" -DestinationPath "." -Force
    Remove-Item -Path "ant" -Recurse -Force -ErrorAction Ignore
    Move-Item -Path "apache-ant-1.10.10" -Destination "ant"
}

Write-Host "Installing Eclipse" -ForegroundColor Green
if (-Not (Test-Path "eclipse\eclipse.exe"))
{
    if (-Not (Test-Path "downloads\eclipse.zip"))
    {
        Invoke-WebRequest -OutFile "downloads\eclipse.zip" -Uri "https://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/2021-06/R/eclipse-rcp-2021-06-R-win32-x86_64.zip&r=1"
    }
    Expand-Archive -Path "downloads\eclipse.zip" -DestinationPath "." -Force
}
Remove-Item -Path "eclipse\eclipse.ini"
Invoke-WebRequest -OutFile "eclipse\eclipse.ini" -Uri "https://github.com/rhjoerg/rhjoerg-devenv/releases/download/latest/eclipse.ini"

Write-Host "Configuring Eclipse" -ForegroundColor Green
Remove-Item -Path "eclipse\eclipse.ini"
Invoke-WebRequest -OutFile "eclipse\eclipse.ini" -Uri "https://github.com/rhjoerg/rhjoerg-devenv/releases/download/latest/eclipse.ini"
Invoke-WebRequest -Outfile "workspace\.metadata\.plugins\org.eclipse.core.runtime\.settings\org.eclipse.ant.core.prefs" -Uri "https://github.com/rhjoerg/rhjoerg-devenv/releases/download/latest/org.eclipse.ant.core.prefs"
