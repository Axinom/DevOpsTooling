# Takes the output of Export-EnvironmentVariables and makes VSTS build process variables out of them.
function Import-EnvironmentVariablesAsProcessVariables {
    [CmdletBinding()]
    param(
        # Directory where to import the variables from.
        # Every .txt file is assumed to be a variable to import.
        [Parameter(Mandatory)]
        [string]$path
    )

    $ErrorActionPreference = "Stop"

    foreach ($item in Get-ChildItem "$path/*.txt") {
        $value = Get-Content $item
        $name = [IO.Path]::GetFileNameWithoutExtension($item.Name)

        Write-Host "Importing $name"
        Write-Host "##vso[task.setvariable variable=$name;]$value"
    }
}