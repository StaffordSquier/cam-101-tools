# Session Handoff — Exposure Triangle Tool
## Date: April 4, 2026

---

## What Was Accomplished This Session

### Exposure Triangle Tool — Complete and Live

Built `cam-04-triangle.html` from scratch as a simplified, focused replacement for the comprehensive CAM-04 tool.

**Live URL:** `https://staffordsquier.github.io/cam-101-tools/Tools/Html_tools/cam-04-triangle.html`
**Local file:** `C:\projects\Skagit Community College\Tools\Html_tools\cam-04-triangle.html`
**Design notes:** `C:\projects\Skagit Community College\Tools\Specifications\CAM-04-triangle-design-notes.md`

### Canvas — Deployed

- Canvas page created: "Interactive Tool — The Exposure Triangle"
- Page slug: `interactive-tool-the-exposure-triangle`
- Added to Week 1 Lab module (ID 218160) at position 3
- Module sequence: Tuesday Lab → Light Meter → **Exposure Triangle** → Thursday Lab
- Pushed to GitHub, Pages building confirmed live (HTTP 200)

---

## Tool Feature Summary

**Left panel:**
- Interactive exposure triangle SVG
  - Amber draggable dots on aperture and shutter edges
  - Green outlined fixed dot on ISO edge (non-draggable — ISO is a film choice)
  - Dots clamped so they never disappear behind vertex nodes
  - No edge labels (caused confusion — removed deliberately)
  - No vertex labels (same reason)
  - Center ring: solid green + white text at correct exposure; orange-red (over) or blue (under) otherwise; pulses at EV 0
- Reciprocity callout (below triangle, hidden in Manual, live-updates in priority modes)
- Ambient light accordion (collapsed by default, EV 12 overcast)
  - 6 named presets + continuous EV 5–16 slider
  - All EV math runs against ambientEV — meter reflects real scene matching
- Exposure meter bar

**Right panel:**
- Aperture slider + effect pills
- Shutter speed slider + effect pills
- ISO discrete selector (100 / 200 / 400 / 800 / 1600 / 3200) — buttons not slider
- ISO effect pills

**Header:**
- Manual / Aperture Priority / Shutter Priority tabs
- Priority modes lock the camera-controlled variable, ISO always user-controlled

**Removed vs. comprehensive tool:**
- No viewfinder scene
- No DOF top-down diagram
- No iris animation
- No summary bar
- No Av/Tv/ISO priority mode combination
- No hint bar (replaced by reciprocity callout below triangle)

---

## Design Decisions Locked

- Background: `#F0F0F0` (neutral gray, not Rookery parchment — Stafford preference)
- ISO as discrete selector, not slider — film is a discrete physical choice
- Edge labels removed — caused confusion about which variable an edge represented
- Vertex labels removed — same confusion from different angle
- Reciprocity callout: below triangle not in header — student eyes are already there
- Draggable dots: `#7A4A1E` amber border, white fill, drop shadow
- ISO dot: green outlined circle, non-draggable, visually distinct
- Summary bar: removed — duplicated slider information

---

## GitHub Repo State

```
Tools/Html_tools/
  cam-light-meter.html         ← live, embedded in Canvas position 2
  cam-04-triangle.html         ← live, embedded in Canvas position 3  ← NEW
  cam-04-v6-2.html
  cam-04-v6.html
  CAM-04a-aperture.html
  CAM-04b-shutter.html
  CAM-04c-iso.html
Tools/Specifications/
  CAM-04-design-notes.md       ← comprehensive tool notes
  CAM-04-triangle-design-notes.md  ← this tool  ← NEW
  CAM-04-technical-reference.md
```

---

## Known Issues / Pending

- Week 1 online module page is still thin and needs expansion to match Weeks 2-10 structure (see `CAM101_online_modules_handoff.md`)
- Szarkowski tool exists locally at `C:\projects\Skagit Community College\history\szarkowski\` — not yet moved into `Tools/` or pushed to GitHub
- Weeks 8-10 lab pages in Canvas may need revision against confirmed template
- Light meter tool: confirm iframe still rendering correctly after today's Canvas changes
