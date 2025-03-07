﻿##############################
#   Load general functions   #
##############################
$repoRootPath = (Get-Item $PSScriptRoot).Parent.Parent.Parent.Parent.FullName

. (Join-Path $repoRootPath 'utilities' 'pipelines' 'sharedScripts' 'Get-NestedResourceList.ps1')
. (Join-Path $repoRootPath 'utilities' 'pipelines' 'sharedScripts' 'Get-ScopeOfTemplateFile.ps1')

####################################
#   Load test-specific functions   #
####################################

<#
.SYNOPSIS
Get the index of a header in a given markdown array

.DESCRIPTION
Get the index of a header in a given markdown array

.PARAMETER ReadMeContent
Required. The content to search in

.PARAMETER MarkdownSectionIdentifier
Required. The header to search for. For example '*# Parameters'

.EXAMPLE
Get-MarkdownSectionStartIndex -ReadMeContent @('# Parameters', 'other content') -MarkdownSectionIdentifier '*# Parameters'

Get the index of the '# Parameters' header in the given markdown array @('# Parameters', 'other content')
#>
function Get-MarkdownSectionStartIndex {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [array] $ReadMeContent,

        [Parameter(Mandatory = $true)]
        [string] $MarkdownSectionIdentifier
    )

    $sectionStartIndex = 0
    while ($ReadMeContent[$sectionStartIndex] -notlike $MarkdownSectionIdentifier -and -not ($sectionStartIndex -ge $ReadMeContent.count)) {
        $sectionStartIndex++
    }

    return $sectionStartIndex
}

<#
.SYNOPSIS
Get the last index of a section in a given markdown array

.DESCRIPTION
Get the last index of a section in a given markdown array. The end of a section is identified by the start of a new header.

.PARAMETER ReadMeContent
Required. The content to search in

.PARAMETER SectionStartIndex
Required. The index where the section starts

.EXAMPLE
Get-MarkdownSectionEndIndex -ReadMeContent @('somrthing', '# Parameters', 'other content', '# Other header') -SectionStartIndex 2

Search for the end index of the section starting in index 2 in array @('somrthing', '# Parameters', 'other content', '# Other header'). Would return 3.
#>
function Get-MarkdownSectionEndIndex {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [array] $ReadMeContent,

        [Parameter(Mandatory = $true)]
        [int] $SectionStartIndex
    )

    $sectionEndIndex = $sectionStartIndex + 1
    while ($readMeContent[$sectionEndIndex] -notlike '*# *' -and -not ($sectionEndIndex -ge $ReadMeContent.count)) {
        $sectionEndIndex++
    }

    return $sectionEndIndex
}

<#
.SYNOPSIS
Get the start & end index of a table in a given markdown section, indentified by a header

.DESCRIPTION
Get the start & end index of a table in a given markdown section, indentified by a header.

.PARAMETER ReadMeContent
Required. The content to search in

.PARAMETER MarkdownSectionIdentifier
Required. The header of the section containing the table to search for. For example '*# Parameters'

.EXAMPLE
$tableStartIndex, $tableEndIndex = Get-TableStartAndEndIndex -ReadMeContent @('# Parameters', '| a | b |', '| - | - |', '| 1 | 2 |', 'other content') -MarkdownSectionIdentifier '*# Parameters'

Get the start & end index of the table in section '# Parameters' in the given ReadMe content. Would return @(1,3)
#>
function Get-TableStartAndEndIndex {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [array] $ReadMeContent,

        [Parameter(Mandatory = $true)]
        [string] $MarkdownSectionIdentifier
    )

    $sectionStartIndex = Get-MarkdownSectionStartIndex -ReadMeContent $ReadMeContent -MarkdownSectionIdentifier $MarkdownSectionIdentifier

    $tableStartIndex = $sectionStartIndex + 1
    while ($readMeContent[$tableStartIndex] -notlike '*|*' -and -not ($tableStartIndex -ge $readMeContent.count)) {
        $tableStartIndex++
    }

    $tableEndIndex = $tableStartIndex + 2
    while ($readMeContent[$tableEndIndex] -like '|*' -and -not ($tableEndIndex -ge $readMeContent.count)) {
        $tableEndIndex++
    }

    return $tableStartIndex, $tableEndIndex
}
