function Set-XmlAttribute {
    [CmdletBinding()]
    param (
        # Path to the XML file
        [Parameter(Mandatory)]
        [string]$path,

        # XPath to the element (e.g. /configuration/appSettings/add[@key='DatabasePath']); must exist already
        [Parameter(Mandatory)]
        [string]$element,

        # The name of the attribute; will be created if it does not exist
        [Parameter(Mandatory)]
        [string]$name,

        # new value of the attribute
        [Parameter(Mandatory)]
        [string]$value
    )

    if (!(Test-Path -PathType Leaf $path)) {
        Write-Error "File not found: $path"
        return
    }

    $path = Resolve-Path $path

    $document = [xml](Get-Content $path)

    if ($document -eq $null) {
        Write-Error "File not a valid XML document: $path"
    }

    Write-Verbose "Performing XPath query: $element"
    $elementNode = $document.SelectSingleNode($element)

    if ($elementNode -eq $null) {
        Write-Error "Element not found: $element"
    }

    $elementNode.SetAttribute($name, $value)

    # Be sure to format the XML on save, otherwise it will be nasty and everyone will hate touching/viewing it.
    $xmlSettings = New-Object System.Xml.XmlWriterSettings
    $xmlSettings.Indent = $true
    $xmlSettings.IndentChars = "`t"
    $xmlSettings.Encoding = [Text.Encoding]::UTF8
    $xmlWriter = [Xml.XmlWriter]::Create($path, $xmlSettings)
    $document.Save($xmlWriter)
    $xmlWriter.Dispose()
}
