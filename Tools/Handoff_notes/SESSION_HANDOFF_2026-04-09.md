# Session Handoff — April 9, 2026
## ART 181 — Week 1 Thursday — First Class Night

---

## Context

Stafford is teaching ART 181 Photography I at Skagit Valley College (Canvas course ID: 46686). Tonight is Week 1 Thursday — the second class meeting. The first meeting (Tuesday) ran long on introductions and the changing bag drill. Students have not shot anything yet. Cameras have not been assigned yet.

---

## What Happened in Class Tuesday

- Introductions only
- Changing bag drill — blindfolded film loading onto Paterson reels
- Did not get to: camera anatomy, exposure triangle, light meter, composition, chemistry walkthrough
- No cameras assigned yet
- No film shot yet

---

## Tonight's Run of Show (Week 1 Thursday)

The Thursday Lab Canvas page has been updated to reflect the actual agenda. Students can see it. The order:

1. Course logistics — Canvas structure, module unlock cadence (every Thursday at noon), lab hour scheduling (poll class on before vs. after, explain inverted option)
2. Camera anatomy and controls — finish what Tuesday started
3. Manual exposure basics — aperture, shutter speed, ISO, in-camera meter
4. Exposure guardrails — sunny 16 and the four light conditions
5. Safety rule — when in doubt overexpose one stop
6. Film stock — Kodak Tri-X 400 in D-76
7. The changing bag drill — reinforce from Tuesday
8. Chemistry walkthrough — developer, stop bath, fixer, wash, why each step in sequence
9. Cameras go home loaded, shoot before next Tuesday
10. Assign cameras to students (last item — end of class)

Plan B if time allows: basic composition — rule of thirds, horizon placement, leading lines, positive and negative space

---

## Canvas State

### Module Structure (as of tonight)

| Position | Module | Status |
|----------|--------|--------|
| 1 | Course Information | Published, always on |
| 2 | Tools and References | Published, always on |
| 3 | Week 1 Online: The Rupture, 1839 | Published |
| 4 | Week 1 Lab: Getting Started | Published |
| 5 | Week 2 Online: Photography Finds Itself | Published |
| 6 | Week 2 Lab: Exposure | Published |
| 7 | Week 3 through Week 10 | Unpublished, auto-unlock Thursdays at noon |

### Module Unlock Schedule

Every Thursday at noon Pacific, the following week's two modules unlock automatically. No action required from Stafford.

| Date | Modules Unlocking |
|------|------------------|
| Apr 16 noon | Week 3 Online + Lab |
| Apr 23 noon | Week 4 Online + Lab |
| Apr 30 noon | Week 5 Online + Lab |
| May 7 noon | Week 6 Online + Lab |
| May 14 noon | Week 7 Online + Lab |
| May 21 noon | Week 8 Online + Lab |
| May 28 noon | Week 9 Online + Lab |
| Jun 4 noon | Week 10 Online + Lab |

### Tools and References Module (ID: 220177)

Four tool pages, always published, always accessible:

| Tool | Canvas Slug | GitHub Pages URL |
|------|-------------|-----------------|
| Light Meter | tool-light-meter | https://staffordsquier.github.io/cam-101-tools/Tools/Html_tools/light-meter.html |
| Exposure Triangle | tool-exposure-triangle | https://staffordsquier.github.io/cam-101-tools/Tools/Html_tools/exposure-triangle.html |
| Film Development Process | tool-film-development-process | https://staffordsquier.github.io/cam-101-tools/Tools/Html_tools/cam-film-development.html |
| Paper Development | tool-paper-development | https://staffordsquier.github.io/cam-101-tools/Tools/Html_tools/cam-paper-development.html |

Links to all four tools appear at the top of the Week 1 Thursday Lab page.

### Week 1 Pages Updated This Session

- Week 1 Thursday Lab — full rewrite to match tonight's actual agenda
- Week 2 Tuesday Lab — rewritten: composition lecture + film development (rolls shot this week)
- Week 2 Thursday Lab — rewritten: enlarger intro, contact sheets, first print, Assignment 1 due

---

## Curriculum Adjustment — Week 1 is Running One Week Behind

The curriculum doc assumes students shot a roll in Week 1 and developed it in Week 1 Thursday. That did not happen. Actual timeline:

- Week 1 Thursday (tonight): cameras assigned, film loaded, students go home to shoot
- Week 2 Tuesday: composition lecture + develop the rolls students shot this week
- Week 2 Thursday: enlarger, contact sheets, first print — Assignment 1 issued
- Everything else downstream is intact — no cascade beyond Week 2

---

## GitHub Repo

- Repo: `https://github.com/StaffordSquier/cam-101-tools`
- Branch: master
- GitHub Pages: `https://staffordsquier.github.io/cam-101-tools/`
- Local root: `C:\projects\Skagit Community College\`
- Git push workflow: `git add -f Tools/Html_tools/filename.html` then `git commit -m "message"` then `git push`
- Note: new HTML files require `git add -f` due to gitignore ordering — the `*` catch-all fires before `!Tools/**` for untracked files

### Tools Currently in Repo

All in `Tools/Html_tools/`:
- light-meter.html
- exposure-triangle.html
- exposure-triangle-comprehensive.html
- cam-film-development.html (built this session)
- cam-paper-development.html (built this session)
- aperture.html
- shutter-speed.html
- iso-grain.html
- camera-anatomy.html / camera-anatomy-1.html / camera-anatomy-2.html
- camera-basics.html
- contact-sheet.html
- photographers-eye.html
- Comprehensive_exposure.html

---

## Interactive Tools Built This Session

### cam-film-development.html

Seven-step film development walkthrough. Fixed viewport layout — illustration left, expandable params right. Each step has a purpose-built SVG illustration. Key features:
- Load step: changing bag illustration with arm openings, three-step sequence cards
- Developer/Stop Bath: animated tank with chemical color, rising bubbles
- Wash: animated water flowing in from top, fixer particles rising out, drain streams at bottom
- Photo-Flo: surface tension comparison diagram
- Dry: hanging film strips with emulsion warning
- Opens on Load step automatically (no blank state)
- Mobile: illustration sticky at top, params scroll beneath, nav sticky at bottom

### cam-paper-development.html

Paper development tool — unified darkroom experience, two modes in one file.

Mode 1 (Overview): Darkroom scene with all four trays on a bench under safelight. Trays unlock sequentially — you cannot skip ahead. Each tray illuminates when active, dims when done. Click "Go Deeper" to expand detail params in the right panel without leaving the screen. Click "Next Tray" to advance.

Mode 2 (Detail): Full tray illustration with expandable param rows. Same dark aesthetic, same screen. Toggle between Overview and Detail via tabs at top.

Navigation: numbered step dots in header track progress. Locked trays are visually inaccessible. Once a tray is visited it can be revisited freely.

Design: neutral gray shell (not parchment) with forest green Rookery accents. Darkroom scene stays dark throughout. Safelight amber is the only warm color.

---

## Immediate Next Tasks for New Chat

1. Build tonight's lecture — Stafford needs a PowerPoint or structured lecture notes for the run of show above. Priority items to cover with visual support: camera anatomy, exposure triangle, film development chemistry sequence, camera assignment logistics.

2. Separate instructor notes from student-facing Canvas pages — the Thursday lab page currently serves as both. Need either a hidden instructor page or a clearly marked instructor section.

3. gitignore fix — new HTML files require `git add -f` every time. Consider updating the gitignore pattern so new files in Tools/ are tracked automatically without the force flag.

4. Composition lecture — not covered tonight, moves to Week 2 Tuesday. Needs to be built as a coherent standalone lecture segment: rule of thirds, horizon placement, leading lines, positive and negative space.

5. Facebook post — a draft was written in Steinbeck style about the blindfolded film loading drill. It is in this chat. Stafford needs to post it with the three B&W photos from class (IMG_0912, IMG_0913, IMG_0914).

---

## Working Preferences Reminder

- Stafford works by voice-to-text on iPhone — interpret charitably
- Binary responder — answer the question directly, do not editorialize
- No em dashes or en dashes in any writing
- Writing avatar is John Steinbeck
- Proceeds one step at a time with confirmation before moving on
- Canvas strips style block CSS — all styling must be fully inline
- New HTML files in the repo require `git add -f` not `git add .`
