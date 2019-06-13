function Add-XmlContent {
    [CmdletBinding()]
    param (
        # Path to the XML file
        [Parameter(Mandatory)]
        [string]$path,

        # XPath to the element (e.g. /configuration/appSettings)
        [Parameter(Mandatory)]
        [string]$element,

        # whatever XML you want to add to the end of the element's content
        [Parameter(Mandatory)]
        [string]$appendXml
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
    $newElement.InnerXml = $appendXml

    Write-Verbose "Performing XPath query: $element"
    $document.SelectSingleNode($element).AppendChild($newElement) | Out-Null

    # Be sure to format the XML on save, otherwise it will be nasty and everyone will hate touching/viewing it.
    $xmlSettings = New-Object System.Xml.XmlWriterSettings
    $xmlSettings.Indent = $true
    $xmlSettings.IndentChars = "`t"
    $xmlSettings.Encoding = [Text.Encoding]::UTF8
    $xmlWriter = [Xml.XmlWriter]::Create($path, $xmlSettings)
    $document.Save($xmlWriter)
    $xmlWriter.Dispose()
}