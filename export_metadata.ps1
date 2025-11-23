# --- PASS 1: Collect all unique metadata keys ---
Write-Host "Pass 1: Discovering all metadata keys from posts..." -ForegroundColor Cyan
$allKeys = New-Object System.Collections.Generic.List[string]
$allKeys.Add("filename")
$allKeys.Add("tag_count")

$posts = Get-ChildItem -Path "_posts" -Recurse -File

foreach ($post in $posts) {
    $content = Get-Content -Path $post.FullName
    $inFrontMatter = $false
    foreach ($line in $content) {
        if ($line -eq '---') {
            if ($inFrontMatter) { break } else { $inFrontMatter = $true; continue }
        }
        if ($inFrontMatter) {
            if ($line -match '^([^:]+):') {
                $key = $matches[1].Trim()
                if (-not $allKeys.Contains($key)) {
                    $allKeys.Add($key)
                }
            }
        }
    }
}
Write-Host "Discovered $($allKeys.Count) unique keys." -ForegroundColor Green


# --- PASS 2: Extract data and build CSV content ---
Write-Host "Pass 2: Extracting metadata from all posts..." -ForegroundColor Cyan
$dataForCsv = @()

foreach ($post in $posts) {
    $postRecord = [ordered]@{}
    # Initialize all keys to ensure consistent CSV columns
    foreach ($key in $allKeys) {
        $postRecord[$key] = ""
    }

    $postRecord.filename = $post.Name

    $content = Get-Content -Path $post.FullName
    $inFrontMatter = $false
    $currentKey = ""
    $tagCount = 0

    foreach ($line in $content) {
        if ($line -eq '---') {
            if ($inFrontMatter) { break } else { $inFrontMatter = $true; continue }
        }

        if ($inFrontMatter) {
            if ($line -match '^([^:]+):\s*(.*)') {
                $currentKey = $matches[1].Trim()
                $value = $matches[2].Trim()
                if ($value) {
                    $postRecord[$currentKey] = $value.Trim("'").Trim('"')
                }
            } elseif ($line -match '^\s*-\s*(.*)') {
                $value = $matches[1].Trim().Trim("'").Trim('"')
                # Append to existing value if it's a list
                if ($postRecord[$currentKey]) {
                    $postRecord[$currentKey] += ", $value"
                } else {
                    $postRecord[$currentKey] = $value
                }
                if ($currentKey -eq "tags") {
                    $tagCount++
                }
            } else {
                # If a line doesn't match the key:value or - value patterns, it's not a simple list item
                $currentKey = ""
            }
        }
    }
    $postRecord.tag_count = $tagCount
    $dataForCsv += [PSCustomObject]$postRecord
}

# --- Export to CSV ---
$outputPath = "metadata.csv"
Write-Host "Exporting metadata to $outputPath..." -ForegroundColor Cyan
$dataForCsv | Export-Csv -Path $outputPath -NoTypeInformation

Write-Host "Successfully created $outputPath" -ForegroundColor Green
