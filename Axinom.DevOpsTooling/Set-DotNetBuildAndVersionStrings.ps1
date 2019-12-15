# Generates a version string in one of the following formats:
# a) 11.22.33-123456-abcdef0 - when using Azure DevOps pipelines
# b) 11.22.33-123456789012-abcdef0 - when doing any other kind of build process
# The middle part is the build ID in Azure DevOps (always incrementing value)
# In other environments there is often no equivalent, so it is just a timestamp (yymmddhhmmss)
# The middle part is useful for ordering builds by time.
# Returns the version string as the PowerShell output value

function Set-DotNetBuildAndVersionStrings {
    [CmdletBinding()]
    param(
        # This file must contain the AssemblyFileVersion (preferred) or AssemblyVersion attribute.
        [Parameter(Mandatory)]
        [string]$assemblyInfoPath,

        # Azure DevOps build ID. If not present, a timestamp will be generated instead.
        [Parameter()]
        [int]$buildId,

        # Git commit ID.
        [Parameter(Mandatory)]
        [string]$commitId,

        # Name of the primary branch. Builds in any other branch get the branch name as a version string prefix.
        [Parameter()]
        [string]$primaryBranchName = "master"
    )

    if (!(Test-Path $assemblyInfoPath)) {
        Write-Error "AssemblyInfo file not found at $assemblyInfoPath."
    }

    if ($commitId.Length -lt 7) {
        Write-Error "The Git commit ID is too short to be a valid commit ID."
    }

    # Convert to absolute paths because .NET does not understand PowerShell relative paths.
    $assemblyInfoPath = Resolve-Path $assemblyInfoPath

    # All versions built using this process must be release versions. There is no concept of a debug version.
    # Try to ensure this is so by looking for the BuildConfiguration environment variable that is present in automated builds.
    if ($env:BuildConfiguration -and $env:BuildConfiguration -ne "Release") {
        Write-Error "Only release-mode builds are compatible with build automation."
    }

    $assemblyInfo = [System.IO.File]::ReadAllText($assemblyInfoPath)

    # We prefer AssemblyFileVersion because for libraries in oldschool .NET Framework, there was some funny business
    # where you had to keep AssemblyVersion out of date for proper library upgrade functionality. Not relevant on Core.
    $primaryRegex = New-Object System.Text.RegularExpressions.Regex('AssemblyFileVersion(?:Attribute)?\("(.*)"\)')
    $fallbackRegex = New-Object System.Text.RegularExpressions.Regex('AssemblyVersion(?:Attribute)?\("(.*)"\)')

    $versionMatch = $primaryRegex.Matches($assemblyInfo)

    if (!$versionMatch.Success) {
        $versionMatch = $fallbackRegex.Matches($assemblyInfo)

        if (!$versionMatch.Success) {
            Write-Error "Unable to find AssemblyFileVersion or AssemblyVersion attribute."
        }
    }

    $version = $versionMatch.Groups[1].Value

    Write-Host "AssemblyInfo version is $version"

    # Shorten the commit ID. 7 characters seem to be the standard.
    $commitId = $commitId.Substring(0, 7)

    if ($buildId) {
        if ($buildId -gt 999999) {
            Write-Error "Build ID too large! Values over 999999 are not supported."
        }

        # Zero-pad the build ID to 6 digits.
        $temporalIdentifier = $buildId.ToString("000000")
    } else {
        $temporalIdentifier = [DateTimeOffset]::UtcNow.ToString("yyMMddHHmmss")
    }

    $version = "$version-$temporalIdentifier-$commitId"
    Write-Host "Version string is $version"

    # VSTS does not immediately update it, so update it manually to pass along to the next script.
    $env:BUILD_BUILDNUMBER = $version
    $version = Set-VersionStringBranchPrefix -primaryBranchName $primaryBranchName -skipBuildNumberUpdate

    Write-Output $version

    # Publish to Azure Pipelines.
    # NB! In Azure YAML pipelines, a followup pipeline (e.g. a release) does NOT pick up the updated build number!
    # Microsoft says this is by design.
    Write-Host "##vso[build.updatebuildnumber]$version"

    Write-Host "Version string set!"
}