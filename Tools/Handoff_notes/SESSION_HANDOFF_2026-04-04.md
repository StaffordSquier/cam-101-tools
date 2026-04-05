# Session Handoff — GitHub Pages Setup
## Date: April 4, 2026

---

## What Was Accomplished This Session

### GitHub Repo — Complete
- Repo: `https://github.com/StaffordSquier/cam-101-tools`
- Branch: `master`
- GitHub Pages: **enabled** at `https://staffordsquier.github.io/cam-101-tools/`
- Pages may take a few minutes to finish building on first deploy

### Local Repo Location
`C:\projects\Skagit Community College\` — this is the git root. The `.gitignore` blocks everything except the `Tools/` folder.

### Folder Structure on Disk
```
C:\projects\Skagit Community College\
    .gitignore
    Tools\
        Html_tools\        <- HTML teaching tools (tracked by git)
            cam-light-meter.html
            cam-04-v6-2.html
            cam-04-v6.html
            CAM-04a-aperture.html
            CAM-04b-shutter.html
            CAM-04c-iso.html
        Specifications\    <- design docs (tracked by git)
            CAM-04-design-notes.md
            CAM-04-technical-reference.md
        Canvas_lasses\     <- not yet populated
        Papers\            <- not yet populated
    Norman's Picture Library\   <- ignored by git, local only
    (all other project folders) <- ignored by git, local only
```

### .gitignore Logic
```
*                    <- block everything
!Tools/              <- unblock Tools folder
!Tools/**            <- unblock everything inside it
!.gitignore          <- unblock the gitignore itself
```

Anything placed inside `Tools/` or any subfolder goes to GitHub automatically on next commit/push. Nothing else is ever touched.

---

## Tool URLs (once Pages finishes building)

| Tool | URL |
|------|-----|
| Light Meter | `https://staffordsquier.github.io/cam-101-tools/Tools/Html_tools/cam-light-meter.html` |
| Exposure Triangle v6.2 | `https://staffordsquier.github.io/cam-101-tools/Tools/Html_tools/cam-04-v6-2.html` |

---

## Immediate Next Task

**Embed the light meter tool in the Week 1 Tuesday Lab Canvas page via iframe.**

The temporary broken inline page (`interactive-tool-reading-your-light-meter-2`) is already in the Week 1 Lab module (ID 218160) as item 2. It needs to be replaced with a proper iframe pointing at the GitHub Pages URL above.

Canvas iframe embed code:
```html
<iframe 
  src="https://staffordsquier.github.io/cam-101-tools/Tools/Html_tools/cam-light-meter.html" 
  width="100%" 
  height="700px" 
  frameborder="0" 
  style="border:none;">
</iframe>
```

Canvas API details:
- Base URL: `https://skagit.instructure.com/api/v1`
- Course ID: `46686`
- Week 1 Lab module ID: `218160`
- Token: in project file `Canvas_Token`

---

## Git Workflow Going Forward

```powershell
# After making changes to any file in Tools/
git add .
git commit -m "description of change"
git push
```

GitHub Pages rebuilds automatically on every push. No other steps needed.

---

## Known Issues / Pending

- Week 1 online module page is thin and needs expansion (separate task, noted in `CAM101_online_modules_handoff.md`)
- Light meter tool was confirmed working with correct EV math in a previous session
- Szarkowski tool exists locally at `C:\projects\Skagit Community College\history\szarkowski\` — not yet moved into `Tools/` or pushed to GitHub
