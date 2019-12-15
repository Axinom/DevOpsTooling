@{
    # Script module or binary module file associated with this manifest.
    RootModule = 'Main.psm1'

    # Version number of this module.
    ModuleVersion = '10.1.0'

    # Supported PSEditions
    # CompatiblePSEditions = @()

    # ID used to uniquely identify this module
    GUID = '8f24e63b-fd68-48cc-8518-c1289fc7f20c'

    # Author of this module
    Author = 'Sander Saares, Anvar Sosnitski'

    # Company or vendor of this module
    CompanyName = 'Axinom'

    # Copyright statement for this module
    Copyright = '(c) 2018 Axinom. All rights reserved.'

    # Description of the functionality provided by this module
    Description = 'Useful tooling for DevOps automation.'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion = '5.0'

    # Name of the Windows PowerShell host required by this module
    # PowerShellHostName = ''

    # Minimum version of the Windows PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # DotNetFrameworkVersion = ''

    # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # CLRVersion = ''

    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = ''

    # Modules that must be imported into the global environment prior to importing this module
    # RequiredModules = @()

    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @()

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    # NestedModules = @()

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport = @(
        'Add-XmlContent',
        'Expand-Tokens',
        'Export-EnvironmentVariables',
        'Get-FileEncoding',
        'Get-FileNewlineCharacters',
        'Get-HttpResponseBodyFromErrorRecord',
        'Import-EnvironmentVariablesAsProcessVariables',
        'Publish-AzureBlob',
        'Remove-ExpiredAzureBlobs',
        'Set-DotNetBuildAndVersionStrings',
        'Set-NpmVersionString',
        'Set-NuGetVersionString',
        'Set-PowerShellModuleBuildString',
        'Set-PowerShellModuleMetadataBeforeBuild',
        'Set-VersionStringBranchPrefix',
        'Set-XmlAttribute',
        'Set-XmlContent'
    )

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport = @()

    # Variables to export from this module
    VariablesToExport = '*'

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport = @()

    # DSC resources to export from this module
    # DscResourcesToExport = @()

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    # FileList = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData = @{

        PSData = @{

            # Automated build scripts will look for this. Content of the field does not matter.
            # If there is any non-empty string in there, the package will be published as prerelease
            # and an auto-incrementing suffix will be used to ensure that each build is numbered right.
            Prerelease = 'yes'

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags = @('devops', 'docker', 'vsts', 'azure')

            # A URL to the license for this module.
            LicenseUri = 'https://raw.githubusercontent.com/Axinom/DevOpsTooling/master/LICENSE'

            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/Axinom/DevOpsTooling'

            # A URL to an icon representing this module.
            # IconUri = ''

            # ReleaseNotes of this module
            # ReleaseNotes = ''

        } # End of PSData hashtable

    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''
}