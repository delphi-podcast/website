# Script to export focused post metadata to a CSV file

$dataForCsv = @()
$posts = Get-ChildItem -Path "_posts" -Recurse -File

foreach ($post in $posts) {
    $postRecord = [ordered]@{
        filename  = $post.Name
        title     = ""
        date      = ""
        author    = ""
        categories = ""
        tags      = ""
        tag_count = 0
    }

    $content = Get-Content -Path $post.FullName -Raw

    # Extract front matter block
    $frontMatterMatch = [regex]::Match($content, '(?sm)^---\s*$(.*?)^---\s*$')
    if ($frontMatterMatch.Success) {
        $frontMatter = $frontMatterMatch.Groups[1].Value

        # Extract simple key-value pairs
        $postRecord.title = ($frontMatter | Select-String -Pattern '^\s*title:\s*(.*)').Matches.Groups[1].Value.Trim().Trim("'"').Trim('"')
        $postRecord.date = ($frontMatter | Select-String -Pattern '^\s*date:\s*(.*)').Matches.Groups[1].Value.Trim().Trim("'"').Trim('"')
        $postRecord.author = ($frontMatter | Select-String -Pattern '^\s*author:\s*(.*)').Matches.Groups[1].Value.Trim().Trim("'"').Trim('"')

        # Extract categories
        $categoriesMatch = [regex]::Match($frontMatter, '(?sm)categories:\s*(.*?)(?:\r?\n\S|$)' )
        if ($categoriesMatch.Success) {
            $categoryBlock = $categoriesMatch.Groups[1].Value
            $categoryList = $categoryBlock -split "\n" | ForEach-Object { $_.Trim() -replace '-\s*', '' } | Where-Object { $_ -ne '' }
            $postRecord.categories = $categoryList -join ", "
        }

        # Extract tags and count them
        $tagsMatch = [regex]::Match($frontMatter, '(?sm)tags:\s*(.*?)(?:\r?\n\S|$)' )
        if ($tagsMatch.Success) {
            $tagBlock = $tagsMatch.Groups[1].Value
            $tagList = $tagBlock -split "\n" | ForEach-Object { $_.Trim() -replace '-\s*', '' } | Where-Object { $_ -ne '' }
            $postRecord.tags = $tagList -join ", "
            $postRecord.tag_count = $tagList.Count
        }
    }
    
    $dataForCsv += [PSCustomObject]$postRecord
}

# Export to CSV
$outputPath = "metadata.csv"
Write-Host "Exporting focused metadata to $outputPath..." -ForegroundColor Cyan
$dataForCsv | Export-Csv -Path $outputPath -NoTypeInformation -Force

Write-Host "Successfully created $outputPath" -ForegroundColor Green