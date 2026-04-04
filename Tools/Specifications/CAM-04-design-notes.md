# CAM-04 — Exposure Triangle Simulator
## Design Notes — v6 (April 2026)

---

## What this file is

Interactive HTML learning module for Week 2 of CAM-101 (Introduction to Photography, B&W Film). Teaches the exposure triangle — aperture, shutter speed, ISO — and their relationships. Built to the Rookery UI v1.0 design standard.

Companion file: `cam-04-exposure-triangle-rookery.html`

---

## Layout

Two-row canvas layout inside the left panel:

**Top 58% — Viewfinder scene (full width)**
The dominant visual. A perspective scene showing five identical posts receding from lower-left (near, huge) to upper-right (far, tiny). This is the hero — it gets the most space.

**Bottom 42% — split 50/50:**
- Left half: Depth of field top-down schematic (camera → 5 labeled objects → sharp zone band)
- Right half: Exposure triangle SVG (Rookery white panel with accent-green lines)

Right panel: three control sections (Aperture, Shutter Speed, ISO) with sliders, iris visualization, and pill indicators.

Bottom strip: three-column summary bar (Aperture | Shutter Speed | ISO).

---

## What was tried and rejected

**Three horizontal bands** (viewfinder / green triangle / DOF schematic stacked vertically) — bad. Each section too short. The green band created jarring visual weight. Abandoned.

**Triangle overlaid on scene** (position:absolute card floating top-right of viewfinder) — looked slapped on. The triangle needs its own space, not a layered card.

**Dark photographic background** for the main scene — violated Rookery ("no dark mode"). Made DOF hard to read. Abandoned.

**Three anonymous blurry pillars** for the viewfinder — no spatial logic. Viewer can't tell near from far. Replaced with proper perspective scene.

**Left-to-right flat arrangement** — looked like objects side by side at the same depth. DOF blur on flat-arranged objects reads as "blurry for no reason," not "spatially distant."

**Camera body illustration** in the aperture control section — heavy, unnecessary. Replaced with just the iris canvas.

---

## Viewfinder scene design

Five posts on a single perspective line from anchor point (W*0.06, bottom) toward vanishing point at (W*0.90, horizon).

Parametric positions `s`: 0.06, 0.20, 0.38, 0.57, 0.73 (near to far).

Depth assignments: s=0.06 → depth +2 (nearest foreground), s=0.73 → depth -2 (far background).

Size: `width = maxW * (1-s)^0.85`, `height = maxH * (1-s)^0.80` — non-linear for convincing perspective.

**Atmospheric perspective** (critical depth cue):
- Near post: warm near-black, high contrast — close to `--text` (#4a4844)
- Far post: warm light grey, low contrast — close to `--divider` (#ccc8c0)
- Subject post: `--bg` (#F4F2EE) parchment — the correctly-exposed reference object matches the page background

**Sky**: warm pale (#e8e2d8) — NO cool/blue tones. Rookery palette is entirely warm.
**Ground**: warm parchment-tan (#cec4a4), harmonizes with `--bg`.
**Ground lines**: radiate from VP, very subtle (rgba 0.18 opacity).

Subject post gets focus bracket indicator (four corner L-shapes in `--accent`).

---

## Blur physics

```javascript
function calcBlur(depth, t) {
  if (depth === 0) return 0;          // focal plane: always sharp
  var openness = 1 - t;               // 0 at f/22, 1 at f/1.4
  return Math.min(Math.abs(depth) * openness * (depth > 0 ? 9 : 7), 20);
}
```

`t = apI / 8` (aperture slider index / max index).

**Key guarantee**: at `t=1` (f/22), `openness=0`, so `blur=0` for every object regardless of depth. f/22 = tack sharp everywhere. Earlier versions failed this test.

Foreground scale (9) slightly higher than background (7) — foreground blurs faster in real lenses.

Applied via `ctx.filter = 'blur(Xpx)'` per post, saved/restored around each draw call.

---

## Exposure triangle SVG

Vertices: Aperture top (190,16), Shutter bottom-left (16,276), ISO bottom-right (364,276).
ViewBox: `-14 -24 408 334`.

Edge line weight and opacity both scale with each variable's value. Moving markers slide along each edge.

Center circle changes:
- EV 0: `--accent` green stroke, pulsing animation
- Overexposed: warm orange-red
- Underexposed: deep blue

**Rookery compliance**: `--surface` (#FFFFFF) panel background, `--accent` (#2F4A3F) lines and markers, `--divider` (#E2E0DA) node borders, `--text-2` (#4A4A4A) edge labels.

The triangle position is set in JavaScript in `resize()` — not CSS percentages — because it needs to align with the canvas coordinate system:

```javascript
triSec.style.top    = vfH + 'px';
triSec.style.left   = dofW + 'px';
triSec.style.width  = (cv.width - dofW) + 'px';
triSec.style.height = (cv.height - vfH) + 'px';
```

---

## DOF top-down schematic

Camera body (forest green, rendered with pentaprism bump) on far left. Five dots along a horizontal centerline representing: Near foreground, (unnamed mid), Subject, (unnamed mid), Far background.

Sharp zone band calculated from blur physics threshold (0.8px):
```javascript
var fgLimitDepth = t >= 1 ? 99 : 0.8 / (9 * (1 - t));
var bgLimitDepth = t >= 1 ? 99 : 0.8 / (7 * (1 - t));
```

At f/1.4: zone is essentially a line at focal plane.
At f/22: zone covers entire diagram.

Out-of-focus dots render with concentric blur rings (bokeh circles).

---

## Rookery UI v1.0 — key rules for this file

| Token | Used for |
|---|---|
| `--bg` (#F4F2EE) | Canvas backgrounds, subject post color |
| `--surface` (#FFFFFF) | Triangle panel, control panels |
| `--text` (#121212) | Primary labels, EV display |
| `--text-2` (#4A4A4A) | Section labels, edge labels, pill text |
| `--divider` (#E2E0DA) | All borders, node circles, separators |
| `--accent` (#2F4A3F) | Triangle lines, markers, iris, camera body, active pills |

**No dark fills.** `--accent` is for lines, buttons, and small elements — not large background panels. The green triangle band (v5) violated this and was removed.

**No cool colors.** The entire Rookery palette is warm. Sky, ground, and any illustration tones should sit in the warm-grey to parchment range.

**IBM Plex Mono** for all data values, section labels, node text, status strings.
**IBM Plex Sans** for body copy, button labels, descriptions.

---

## Mode logic

Four modes: Manual, Av (Aperture Priority), Tv (Shutter Priority), ISO Priority.

In priority modes, the non-selected variable(s) are locked and auto-compensated to hit EV=0. Scene: ISO 400 baseline, overcast afternoon.

Compensation uses `isoEV(i) = i - 2` (ISO 400 = index 2 = 0 contribution), `apEV(i) = 4 - i`, `shEV(i) = 4 - i`.

---

## File location

`C:\projects\Skagit Community College\` (or wherever the HTML lives)

Canvas LMS assignment ID for Week 2 Lab: **741049**
