Write-Host "Creating Directories" -ForegroundColor Green
New-Item -Name "downloads" -ItemType "directory" -ErrorAction Ignore
New-Item -Name "jdk" -ItemType "directory" -ErrorAction Ignore

Write-Host "Installing JDK-11" -ForegroundColor Green
if (-Not (Test-Path "jdk\jdk-11\bin\java.exe"))
{
    if (-Not (Test-Path "downloads\jdk-11.zip"))
    {
        Invoke-WebRequest -Uri "https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_windows-x64_bin.zip" -OutFile "downloads\jdk-11.zip"
    }
    Expand-Archive -Path "downloads\jdk-11.zip" -DestinationPath "jdk" -Force
}

Write-Host "Installing JDK-16" -ForegroundColor Green
if (-Not (Test-Path "jdk\jdk-16\bin\java.exe"))
{
    if (-Not (Test-Path "downloads\jdk-16.zip"))
    {
        Invoke-WebRequest -Uri "https://download.java.net/openjdk/jdk16/ri/openjdk-16+36_windows-x64_bin.zip" -OutFile "downloads\jdk-16.zip"
    }
    Expand-Archive -Path "downloads\jdk-16.zip" -DestinationPath "jdk" -Force
}
