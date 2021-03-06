$ErrorActionPreference = "Stop"

. (Join-Path $PSScriptRoot "Add-XmlContent.ps1")
. (Join-Path $PSScriptRoot "Expand-Tokens.ps1")
. (Join-Path $PSScriptRoot "Export-EnvironmentVariables.ps1")
. (Join-Path $PSScriptRoot "Get-FileEncoding.ps1")
. (Join-Path $PSScriptRoot "Get-FileNewlineCharacters.ps1")
. (Join-Path $PSScriptRoot "Get-HttpResponseBodyFromErrorRecord.ps1")
. (Join-Path $PSScriptRoot "Import-EnvironmentVariablesAsProcessVariables.ps1")
. (Join-Path $PSScriptRoot "Publish-AzureBlob.ps1")
. (Join-Path $PSScriptRoot "Remove-ExpiredAzureBlobs.ps1")
. (Join-Path $PSScriptRoot "Set-DotNetBuildAndVersionStrings.ps1")
. (Join-Path $PSScriptRoot "Set-NpmVersionString.ps1")
. (Join-Path $PSScriptRoot "Set-NuGetVersionString.ps1")
. (Join-Path $PSScriptRoot "Set-PowerShellModuleBuildString.ps1")
. (Join-Path $PSScriptRoot "Set-PowerShellModuleMetadataBeforeBuild.ps1")
. (Join-Path $PSScriptRoot "Set-VersionStringBranchPrefix.ps1")
. (Join-Path $PSScriptRoot "Set-XmlAttribute.ps1")
. (Join-Path $PSScriptRoot "Set-XmlContent.ps1")