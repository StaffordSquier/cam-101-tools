# CAM-04 & Optics Module — Session Handoff
## Date: April 3, 2026

---

## What was completed this session

**CAM-04 Exposure Triangle simulator — v6, considered done.**

File: `cam-04-exposure-triangle-rookery.html`
Design notes: `CAM-04-design-notes.md`

Both files are in Claude.ai outputs and need to be copied to:
`C:\projects\Skagit Community College\` (exact subfolder TBD — likely alongside other CAM-series modules)

---

## State of CAM-04

The simulator is functionally complete and Rookery-compliant. Do not redesign the layout without reading `CAM-04-design-notes.md` first — it documents 10+ iterations of what was tried and why it failed.

**Layout (do not change without good reason):**
- Top 58%: Viewfinder perspective scene, full width, hero visual
- Bottom-left 21%: Depth of field top-down schematic
- Bottom-right 21%: Exposure triangle SVG on white `--surface` panel
- Right column: Three control sections (Aperture / Shutter / ISO)
- Bottom strip: Three-column summary bar

**Known acceptable state:**
- Blur physics correct at all apertures including f/22 (tack sharp)
- Five posts in proper single-point perspective, atmospheric perspective applied
- All colors Rookery-compliant (warm palette only, no cool tones, no dark fills)
- All four modes work: Manual, Av, Tv, ISO Priority
- Triangle edge weights and markers respond to all sliders

**If revisiting, start by reading:**
1. `CAM-04-design-notes.md` — full design rationale
2. `ROOKERY_UI_DESIGN_ARCHITECTURE_v1.md` — color/type/spacing spec

---

## Next module: How a Lens Works (optics)

**This was discussed but not started.** Stafford wants a new interactive module illustrating lens optics — probably for Week 1 or early in the course.

**Candidates discussed — Stafford did not choose yet:**

1. **Ray diagram** — object left, convex lens center, inverted image right. Three canonical rays. Interactive: slide object distance, watch image plane shift and image size change. Most directly shows inversion.

2. **Pinhole camera** — no lens, just a hole. Shows geometrically *why* inversion happens before any lens math. Could show pinhole size tradeoff (bigger = more light but blurrier). Simpler, more intuitive.

3. **Focal length and angle of view** — same subject, different focal lengths. Directly useful for portrait/landscape weeks (Week 3, 5).

4. **Circle of confusion / film plane** — cone of light converging exactly on film vs. missing. Connects to DOF work in CAM-04.

**Stafford's instinct** (paraphrased): Ray diagram + pinhole could be one module — pinhole explains the intuition first, then the lens shows how it does the same thing faster.

**Next step:** Show Stafford the candidates again, get a decision, then build. Do not start building until he picks one.

---

## CAM-101 online modules — current state

From `CAM101_online_modules_handoff.md`:

- Weeks 2–10: Complete (all ~6,000 chars, full structure)
- **Week 1 is thin** — only core paragraph, missing green header banner, "Why This Week," "Watch First," "Then Read" sections
- All quizzes published and auto-graded
- Canvas course ID: **46686** at skagit.instructure.com
- Week 1 page slug: `week-1-the-rupture-1839`

**Outstanding task:** Expand Week 1 online module to match Weeks 2–10 structure. Python snippet for Canvas API update is in `CAM101_online_modules_handoff.md`. Canvas token is in project file `Canvas_Token`.

---

## Rookery design system — key rules (summary)

Full spec: `ROOKERY_UI_DESIGN_ARCHITECTURE_v1.md`

- `--bg` #F4F2EE — warm parchment, page/canvas backgrounds only
- `--surface` #FFFFFF — panels, cards, control areas
- `--accent` #2F4A3F — forest green, lines/buttons/markers ONLY, never large fills
- `--divider` #E2E0DA — all borders and separators
- IBM Plex Mono for all data, labels, status
- IBM Plex Sans for body copy and buttons
- No dark mode. No cool/blue tones. No gradients. No decorative chrome.
- Section labels: uppercase mono 11px `--text-2` with `letter-spacing: 0.06em`

---

## Working preferences (Stafford)

- Explain each step before executing
- Confirm completion before moving on
- Do not rewrite large documents from partial feedback
- Do not make editorial/design decisions unilaterally — ask first
- Works on iPhone via voice-to-text — interpret charitably if transcription is garbled
- Do exactly what is asked; do not add unrequested steps
