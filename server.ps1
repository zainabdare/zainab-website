# Simple static HTTP server for local preview
$ports = @(8000, 8080, 5500, 3000, 8081)
$listener = $null
$port = 0

foreach ($p in $ports) {
    try {
        $tempListener = New-Object System.Net.HttpListener
        $tempListener.Prefixes.Add("http://localhost:$p/")
        $tempListener.Start()
        $listener = $tempListener
        $port = $p
        break
    } catch {
        if ($tempListener) { $tempListener.Close() }
    }
}

if (-not $listener) {
    Write-Error "Could not bind to any test ports ($($ports -join ', '))."
    exit 1
}

$url = "http://localhost:$port/"
Write-Host "=========================================="
Write-Host " Local Preview Server running!"
Write-Host " URL: $url"
Write-Host " Press Ctrl+C in terminal to stop."
Write-Host "=========================================="

# Automatically launch the site in user's default web browser
Start-Process "$url"

$mimeMap = @{
    ".html" = "text/html; charset=utf-8"
    ".css"  = "text/css; charset=utf-8"
    ".js"   = "application/javascript; charset=utf-8"
    ".json" = "application/json; charset=utf-8"
    ".png"  = "image/png"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".gif"  = "image/gif"
    ".svg"  = "image/svg+xml"
    ".ico"  = "image/x-icon"
    ".woff" = "font/woff"
    ".woff2"= "font/woff2"
}

try {
    while ($listener.IsListening) {
        $context = $listener.GetContext()
        $request = $context.Request
        $response = $context.Response

        $rawPath = $request.Url.LocalPath.TrimStart('/')
        if ([string]::IsNullOrWhiteSpace($rawPath)) {
            $rawPath = "index.html"
        }

        # Security & resolution
        $safePath = $rawPath.Replace('/', '\')
        $fullPath = Join-Path (Get-Location) $safePath

        # Append .html if extension is omitted
        if (-not (Test-Path $fullPath) -and (Test-Path "$fullPath.html")) {
            $fullPath = "$fullPath.html"
        }

        if (Test-Path $fullPath -PathType Leaf) {
            $bytes = [System.IO.File]::ReadAllBytes($fullPath)
            $ext = [System.IO.Path]::GetExtension($fullPath).ToLower()
            $contentType = $mimeMap[$ext]
            if (-not $contentType) {
                $contentType = "application/octet-stream"
            }

            $response.ContentType = $contentType
            $response.ContentLength64 = $bytes.Length
            $response.StatusCode = 200
            $response.OutputStream.Write($bytes, 0, $bytes.Length)
        } else {
            $response.StatusCode = 404
            $notFoundMsg = [System.Text.Encoding]::UTF8.GetBytes("<h1>404 Not Found</h1><p>The file '$rawPath' does not exist.</p>")
            $response.ContentType = "text/html; charset=utf-8"
            $response.ContentLength64 = $notFoundMsg.Length
            $response.OutputStream.Write($notFoundMsg, 0, $notFoundMsg.Length)
        }

        $response.OutputStream.Close()
    }
} finally {
    if ($listener) {
        $listener.Stop()
        $listener.Close()
    }
}
