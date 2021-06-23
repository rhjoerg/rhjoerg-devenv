Write-Host "Creating Directories" -ForegroundColor Green
New-Item -Name "downloads" -ItemType "directory" -ErrorAction Ignore


Write-Host "Installing JDK-1" -ForegroundColor Green
if (-Not (Test-Path "jdk\jdk-11\bin\java.exe"))
{
    if (-Not (Test-Path "downloads\jdk-11.zip"))
    {
        Invoke-WebRequest -Uri "https://download.java.net/openjdk/jdk11/ri/openjdk-11+28_windows-x64_bin.zip" -OutFile "downloads\jdk-11.zip"
    }
    Expand-Archive -Path "downloads\jdk-11.zip" -DestinationPath "jdk" -Force
}
