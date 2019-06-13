# This function lets you easily move environment variables from one build process to another.
# It publishes them in .txt files, which can be published as build artifacts then imported at release time.
function Export-EnvironmentVariables {
    [CmdletBinding()]
    param(
        # Names of the environment variables to export.
        [Parameter(Mandatory)]
        [string[]]$names,

        # Directory where to export the variables.
        # Each variable will become a new text file.
        [Parameter(Mandatory)]
        [string]$path
    )

    # Ensure the directory exists.
    New-Item -ItemType Directory -Path $path -ErrorAction Ignore | Out-Null

    foreach ($name in $names) {
        $value = Get-ChildItem "env:$name"
        Set-Content -Path (Join-Path $path "$name.txt") -Value $value.Value
    }
}