# Script to export focused post metadata to a CSV file

$dataForCsv = @()
$posts = Get-ChildItem -Path "_posts" -Recurse -File

foreach ($post in $posts) {
    $postRecord = [ordered]@{
        filename   = $post.Name
        title      = ""
        date       = ""
        author     = ""
        categories = ""
        tags       = ""
        tag_count  = 0
    }

    $content = Get-Content -Path $post.FullName -Raw

    # Extract front matter block
    $frontMatterMatch = [regex]::Match($content, '(?sm)^---\s*$(.*?)^---\s*$')
    if ($frontMatterMatch.Success) {
        $frontMatter = $frontMatterMatch.Groups[1].Value
        $frontMatterLines = $frontMatter.Split([System.Environment]::NewLine)

        # Extract simple key-value pairs
        $titleLine = $frontMatterLines | Where-Object { $_ -match '^\s*title:' } | Select-Object -First 1
        if ($titleLine) { $postRecord.title = ($titleLine -split ':', 2)[1].Trim().Trim("'").Trim('"') }

        $dateLine = $frontMatterLines | Where-Object { $_ -match '^\s*date:' } | Select-Object -First 1
        if ($dateLine) { $postRecord.date = ($dateLine -split ':', 2)[1].Trim().Trim("'").Trim('"') }

        $authorLine = $frontMatterLines | Where-Object { $_ -match '^\s*author:' } | Select-Object -First 1
        if ($authorLine) { $postRecord.author = ($authorLine -split ':', 2)[1].Trim().Trim("'").Trim('"') }

        # Extract tags and categories (handles multi-line lists)
        $inTags = $false
        $inCategories = $false
        $tagList = New-Object System.Collections.Generic.List[string]
        $categoryList = New-Object System.Collections.Generic.List[string]

        foreach ($line in $frontMatterLines) {
            if ($line -match '^\s*tags:') { $inTags = $true; $inCategories = $false; continue }
            if ($line -match '^\s*categories:') { $inCategories = $true; $inTags = $false; continue }
            
            # If we encounter another key, reset the section
            if ($line -notmatch '^\s*-' -and $line -match ':') {
                 $inTags = $false; $inCategories = $false
            }

            if ($line -match '^\s*-\s*(.*)') {
                $value = $matches[1].Trim().Trim("'").Trim('"')
                if ($inTags) { $tagList.Add($value) }
                if ($inCategories) { $categoryList.Add($value) }
            }
        }
        $postRecord.tags = $tagList -join ", "
        $postRecord.tag_count = $tagList.Count
        $postRecord.categories = $categoryList -join ", "
    }
    
    $dataForCsv += [PSCustomObject]$postRecord
}

# Export to CSV
$outputPath = "metadata.csv"
Write-Host "Exporting focused metadata to $outputPath..." -ForegroundColor Cyan
$dataForCsv | Export-Csv -Path $outputPath -NoTypeInformation -Force

Write-Host "Successfully created $outputPath" -ForegroundColor Green
