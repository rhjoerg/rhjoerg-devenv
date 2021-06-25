
$contentPath = "downloads\content.jar"
$contentUri = "https://download.eclipse.org/releases/2021-06/202106161001/content.jar"
$contentXmlPath = "downloads\content.xml"
$contentIdsPath = "downloads\content.txt"

if (-Not (Test-Path -Path $contentPath))
{
    Invoke-WebRequest -Outfile $contentPath -Uri $contentUri
}

Remove-Item -Path $contentXmlPath -Force -ErrorAction Ignore
Expand-Archive -Path $contentPath -DestinationPath ".\downloads" -Force

$xml = Select-Xml -Path $contentXmlPath -XPath "/repository/units/unit[contains(@id, '.feature.group')]/@id"
$xml | Set-Content -Path $contentIdsPath
