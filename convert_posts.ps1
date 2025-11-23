# Load the System.Web assembly to get access to HttpUtility for HTML decoding
try {
    Add-Type -AssemblyName System.Web
} catch {}

$posts = Get-ChildItem -Path "_posts" -Recurse -File

foreach ($post in $posts) {
    $content = Get-Content -Path $post.FullName -Raw -Encoding UTF8
    $originalContent = $content

    # Regex to find all syntax highlighter blocks, with optional language capture
    # This is complex to ensure it handles various JSON-like structures within the comment.
    $regex = '<!-- wp:syntaxhighlighter/code(?:{.*?"language":"(?<lang>\w+)"?.*?}|\s*)?--><pre class="wp-block-syntaxhighlighter-code">(?<code>[\s\S]*?)</pre><!-- /wp:syntaxhighlighter/code -->'
    
    $evaluator = {
        param($match)
        $lang = $match.Groups['lang'].Value
        $code = $match.Groups['code'].Value
        
        $decodedCode = [System.Web.HttpUtility]::HtmlDecode($code)
        
        if ($lang -eq 'delphi') {
            # Use the alias we created
        } elseif ($lang -eq 'xml') {
            # Keep xml
        } else {
            $lang = '' # Default to generic for others/unspecified
        }

        # Use single quotes and format operator to avoid PowerShell parsing issues with backticks
        '```{0}`n{1}`n```' -f $lang, $decodedCode
    }

    $content = [regex]::Replace($content, $regex, $evaluator)

    # Remove all remaining WordPress block comments
    $content = $content -replace '<!--\s*wp:.*?-->\r?\n?', ''
    $content = $content -replace '<!--\s*/wp:.*?-->\r?\n?', ''

    # Only write back to the file if content has changed
    if ($originalContent -ne $content) {
        Set-Content -Path $post.FullName -Value $content -Encoding UTF8
    }
}