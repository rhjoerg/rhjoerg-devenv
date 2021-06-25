
$contentPath = "downloads\content.jar"
$contentUri = "https://download.eclipse.org/releases/2021-06/202106161001/content.jar"
$contentXmlPath = "downloads\content.xml"
$contentAllIdsPath = "downloads\content-all-ids.txt"
$contentGroupIdsPath = "downloads\content-group-ids.txt"

if (-Not (Test-Path -Path $contentPath))
{
    Invoke-WebRequest -Outfile $contentPath -Uri $contentUri
}

Remove-Item -Path $contentXmlPath -Force -ErrorAction Ignore
Expand-Archive -Path $contentPath -DestinationPath ".\downloads" -Force

$xml = [xml] (Get-Content $contentXmlPath)
$ids = $xml.repository.units.unit.id | Sort-Object
$ids | Set-Content -Path $contentAllIdsPath

# $ids | Get-Member

$ids = $ids | Where-Object { $_.EndsWith(".feature.group") }
$ids | Set-Content -Path $contentGroupIdsPath
