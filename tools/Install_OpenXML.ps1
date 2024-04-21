# Define download and extraction paths
$downloadUrl = "https://www.nuget.org/api/v2/package/DocumentFormat.OpenXml"
$tempFolder = Join-Path -Path $env:TEMP -ChildPath "OpenXMLTemp"
$outputFolder = Join-Path -Path $PSScriptRoot -ChildPath "Libraries\OpenXML"

# Create the Libraries folder if it doesn't exist
if (-not (Test-Path -Path $outputFolder)) {
    New-Item -Path $outputFolder -ItemType Directory | Out-Null
}

# Create temporary folder for extraction
New-Item -ItemType Directory -Path $tempFolder -Force | Out-Null

# Download the latest version of the OpenXML SDK package
Invoke-WebRequest -Uri $downloadUrl -OutFile "$tempFolder\DocumentFormat.OpenXml.zip"

# Extract the contents of the package
Expand-Archive -Path "$tempFolder\DocumentFormat.OpenXml.zip" -DestinationPath $tempFolder

# Copy the necessary DLLs to the output folder
$sourcePath = Join-Path -Path $tempFolder -ChildPath "lib\netstandard2.0"
Copy-Item -Path $sourcePath\* -Destination $outputFolder -Force

# Clean up temporary files
Remove-Item -Path $tempFolder -Recurse -Force
