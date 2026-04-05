# CAM-101 Tool Rename Script
# Run this from: C:\projects\Skagit Community College
# Purpose: rename HTML tools to human-readable filenames, commit, push

Set-Location "C:\projects\Skagit Community College"

$toolDir = "Tools\Html_tools"

# Rename map: old name -> new name
$renames = @{
    "cam-light-meter.html"      = "light-meter.html"
    "cam-04-triangle.html"      = "exposure-triangle.html"
    "cam-04-v6-2.html"          = "exposure-triangle-comprehensive.html"
    "CAM-04a-aperture.html"     = "aperture.html"
    "CAM-04b-shutter.html"      = "shutter-speed.html"
    "CAM-04c-iso.html"          = "iso-grain.html"
    "cam-contact-sheet.html"    = "contact-sheet.html"
    "Comprehensive_exposure.html" = $null  # delete -- duplicate of cam-04-v6-2
}

# Perform git mv for each rename
foreach ($old in $renames.Keys) {
    $new = $renames[$old]
    $oldPath = "$toolDir\$old"
    
    if ($null -eq $new) {
        # Delete the file
        if (Test-Path $oldPath) {
            git rm "$oldPath"
            Write-Host "Deleted: $old"
        }
    } else {
        $newPath = "$toolDir\$new"
        if (Test-Path $oldPath) {
            git mv "$oldPath" "$newPath"
            Write-Host "Renamed: $old -> $new"
        } else {
            Write-Host "SKIPPED (not found): $old"
        }
    }
}

# Commit and push
git commit -m "Rename HTML tools to human-readable filenames"
git push

Write-Host ""
Write-Host "Done. GitHub Pages will rebuild in ~60 seconds."
Write-Host ""
Write-Host "New URLs:"
Write-Host "  https://staffordsquier.github.io/cam-101-tools/Tools/Html_tools/light-meter.html"
Write-Host "  https://staffordsquier.github.io/cam-101-tools/Tools/Html_tools/exposure-triangle.html"
Write-Host "  https://staffordsquier.github.io/cam-101-tools/Tools/Html_tools/exposure-triangle-comprehensive.html"
Write-Host "  https://staffordsquier.github.io/cam-101-tools/Tools/Html_tools/aperture.html"
Write-Host "  https://staffordsquier.github.io/cam-101-tools/Tools/Html_tools/shutter-speed.html"
Write-Host "  https://staffordsquier.github.io/cam-101-tools/Tools/Html_tools/iso-grain.html"
Write-Host "  https://staffordsquier.github.io/cam-101-tools/Tools/Html_tools/contact-sheet.html"
Write-Host "  https://staffordsquier.github.io/cam-101-tools/Tools/Html_tools/photographers-eye.html"
