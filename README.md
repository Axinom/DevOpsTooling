# DevOps tools

This is a random assortment of DevOps tools used in Axinom projects. It is not expected that anyone else uses them, just published here for ease of troubleshooting since some of Axinom's open source libraries are generated using these tools.

# Installation

`Install-Module Axinom.DevOpsTooling -Scope CurrentUser -Force`

You may need to do `Set-ExecutionPolicy RemoteSigned` first if your PowerShell security configuration is set to a very restricted level.

# Usage

1. Execute `Import-Module Axinom.DevOpsTooling`
1. Execute commands provided

You need to re-import the module at the start of every PowerShell session.
