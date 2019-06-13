function Set-XmlContent {
    [CmdletBinding()]
    param (
        # Path to the XML file.
        [Parameter(Mandatory)]
        [string]$path,

        # XPath to the element (e.g. /configuration/appSettings).
        [Parameter(Mandatory)]
        [string]$element,

        # Whatever XML you want to replace the existing element contents with.
        [Parameter(Mandatory)]
        [string]$innerXml
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

    $newElement = $document.CreateDocumentFragment()
    $newElement.InnerXml = $innerXml

    Write-Verbose "Performing XPath query: $element"
    $parent = $document.SelectSingleNode($element)

    while ($parent.FirstChild) {
        $parent.RemoveChild($parent.FirstChild) | Out-Null
    }

    $parent.AppendChild($newElement) | Out-Null

    # Be sure to format the XML on save, otherwise it will be nasty and everyone will hate touching/viewing it.
    $xmlSettings = New-Object System.Xml.XmlWriterSettings
    $xmlSettings.Indent = $true
    $xmlSettings.IndentChars = "`t"
    $xmlSettings.Encoding = [Text.Encoding]::UTF8
    $xmlWriter = [Xml.XmlWriter]::Create($path, $xmlSettings)
    $document.Save($xmlWriter)
    $xmlWriter.Dispose()
}