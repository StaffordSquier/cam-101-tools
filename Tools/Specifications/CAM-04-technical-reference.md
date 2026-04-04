# CAM-04 Exposure Triangle — Technical Reference
## Skagit Valley College / CAM-101
## Last updated: April 2026

---

## File Inventory

| File | Purpose | Week |
|---|---|---|
| `CAM-04-exposure-triangle.html` | Full interactive triangle — all three variables, mode switching | Week 2 |
| `CAM-04a-aperture.html` | Aperture standalone — iris + DOF diagram | Week 1 |
| `CAM-04b-shutter.html` | Shutter speed standalone — horse + panning mode | Week 1 |
| `CAM-04c-iso.html` | ISO standalone — scene + grain swatch | Week 1 |

Local path: `C:\projects\Skagit Community College\` (or wherever these land in the project folder)

Lecture sequence: 04a → 04b → 04c → full triangle (04). Each standalone introduces one variable in isolation before the triangle shows all three interacting.

---

## Design System

All four tools are built to the **Rookery UI v1.0** spec. Do not introduce colors or fonts outside this system.

### Color tokens

```css
--bg:         #F4F2EE  /* parchment — page background only */
--surface:    #FFFFFF  /* panels, header, control strip */
--text:       #121212
--text-2:     #4A4A4A  /* labels, metadata */
--divider:    #E2E0DA  /* all borders */
--accent:     #2F4A3F  /* forest green — buttons, active states, slider fill */
--accent-dim: #3d5e51  /* hover */
--warn:       #7A4A1E  /* used as horse color — see note below */
```

### Typography
Google Fonts: IBM Plex Mono (400, 500, 600) + IBM Plex Sans (300, 400, 500, 600)

- Section labels: IBM Plex Mono, 10–11px, 600, uppercase, letter-spacing 0.06em, `--text-2`
- Body: IBM Plex Sans, 13–14px, 400
- Large values (header, slider current value): IBM Plex Mono, 22px, 500, `--accent`
- Canvas data labels: IBM Plex Mono, 9–14px

### Rules
- No shadows anywhere. Elevation expressed by `1px solid var(--divider)` borders only.
- No gradients in UI chrome. Gradients only inside canvas visualizations.
- No new colors outside the token set.

---

## Common Architecture

All four tools share the same HTML skeleton:

```
.page (flex column, 100vh)
  header (52px, --surface, bottom border)
    h1 | .sub (mono 12px) | [mode buttons if present] | .hdr-val (current value, accent, mono 22px)
  .hint (optional — hidden by default, shown in panning mode)
  .body (flex:1, flex column)
    .viz (flex:1, position:relative)
      canvas#cv (position:absolute, fills .viz)
    .strip (--surface, top border, fixed height)
      .sl-row: .sl-lbl | .sl-val | .sl-wrap (input[range] + .sl-ends) | .sl-desc
      .pills
```

The canvas is sized to its parent in `resize()` via `cv.width = p.offsetWidth; cv.height = p.offsetHeight`. A `ResizeObserver` triggers `resize()` on layout changes.

### Slider gradient fill

The range input uses a CSS custom property `--p` to show fill progress:

```css
input[type=range] {
  background: linear-gradient(90deg, var(--accent) var(--p, 50%), var(--divider) var(--p, 50%));
}
```

Updated in JS: `sl.style.setProperty('--p', (idx/8*100)+'%')`

### Pills

Pills are `.pill` spans that gain class `.on` when their condition is true. Active state: slight green bg, accent border and text color, full opacity. Inactive: 45% opacity, divider border.

---

## CAM-04a — Aperture

### Canvas layout
Split canvas: left 42% dark panel (iris) | right 58% parchment panel (DOF diagram)

### Left panel — Iris
Draws a 7-blade diaphragm using canvas geometry. Key variables:
- `openR` = how wide the aperture hole is. `openR = R*0.88 - (fIdx/8)*R*0.82`
  - At f/1.4 (fIdx=0): `openR = R*0.88` (nearly full opening)
  - At f/22 (fIdx=8): `openR = R*0.06` (tiny pinhole)
- Each blade drawn as a path: inner arc from `openR`, outer arc from `R`, connected with quadratic curve at midpoint
- Blade gradient: alternating dark blue-grey tones (`#3a4a5e` / `#48586e`)
- Center opening: radial gradient that becomes brighter and more blue as aperture opens (`g = 1-(fIdx/8)`)
- F-stop value printed in white mono below the iris, sized proportionally to iris radius

Light indicator: 5 dots below the f-stop value, filled proportionally to how many stops above minimum. Quick visual of relative light gathering.

### Right panel — DOF top-down diagram
Camera body at left, 5 objects at increasing distances (Near, [unlabeled], Subject, [unlabeled], Far).

Sharp zone band: bounded by `zL` (near limit) and `zR` (far limit), calculated from blur physics:
```javascript
var THRESH = 0.8;
var fgD = t >= 1 ? 99 : THRESH / (9 * (1-t));  // foreground sharp distance
var bgD = t >= 1 ? 99 : THRESH / (7 * (1-t));  // background sharp distance
```
`t = idx/8` where t=0 is wide open, t=1 is f/22.

Objects outside the sharp zone get blur rings (concentric circles). Objects inside are rendered in accent green. Subject always renders larger, with dashed vertical guideline.

### Slider direction
Left = f/1.4 (wide open, more light, shallow DOF) → Right = f/22 (stopped down, less light, deep DOF). Slider value index 0→8 maps directly to AP array.

---

## CAM-04b — Shutter Speed

### Canvas layout
Left 63% — scene (sky + ground + trees + fence + horse) | Right 37% — exposure duration bar (dark panel)

### Mode toggle
Two buttons in header: **Static Camera** | **Panning**. Uses same `.modes` / `.mbtn` / `.mbtn.active` pattern as the original CAM-04 tool. A `.hint` bar drops in below the header in panning mode explaining what panning is.

### Scene — color palette
These are scene-specific constants, not UI tokens:

```javascript
var SKY    = '#dde2e8'; // clean cool-warm light
var GROUND = '#5c6450'; // distinctly darker olive
var TRACK  = '#726e5c'; // slightly lighter running surface strip
var TREE_C = '#2a3220'; // dark forest green canopy
var TREE_T = '#1e2418'; // near-black trunk
var FENCE  = '#c8c0a0'; // weathered light wood posts — high contrast against ground
var FENCE2 = '#b4ac8c'; // fence rails
var HORSE  = '#7A4A1E'; // Rookery --warn color — dark reddish-brown (bay/chestnut)
```

**Why `--warn` for the horse:** The trees are dark cool green. A near-black horse blends into them. The Rookery warn color (#7A4A1E) is dark warm brown — a natural bay/chestnut horse tone — and creates hue contrast against the cool green trees without conflicting with the white surface panels or the parchment background. It's the only palette color that solves all three constraints simultaneously.

### Scene layout
Trees are deliberately pushed to the far edges to create a clear open sky zone in the center:
- Left cluster: W*0.03, W*0.11, W*0.20
- Right cluster: W*0.80, W*0.89, W*0.96
- Clear zone: approximately W*0.22 to W*0.78

Horse positions:
- Static mode: `split * 0.56` — in the clear zone
- Panning mode: `split * 0.50` — centered in the clear zone

This ensures the horse body is always against clear sky with no tree overlap.

### Horse drawing — `drawHorse(cx, groundY, s, alpha)`
Muybridge-inspired galloping silhouette. Horse faces RIGHT (direction of travel).

`cx` = body center x, `groundY` = hoof ground level, `s` = scale factor.

Body center Y: `by = groundY - s*1.65`

Drawn as multiple overlapping shapes (all filled with HORSE color):
1. Body — `ctx.ellipse(0,0, s*.94, s*.32)` at slight rotation (-0.05 rad)
2. Rump bulge — smaller ellipse behind and above body center
3. Chest bulge — smaller ellipse forward and above body center
4. Neck — filled bezier path from chest area curving up to head
5. Head — closed bezier curve (muzzle, forehead, jaw loop)
6. Ear — small triangle at top of head
7. Mane — single quadratic stroke along neck
8. Four legs — thick stroked quadratic curves (lineWidth = s*0.115):
   - Front right: most forward (extends to groundY at split*~0.65 offset)
   - Front left: slightly behind
   - Hind right: angled back
   - Hind left: furthest back (Muybridge airborne spread)
9. Tail — two bezier strokes of different weights streaming back-left

### Directional motion blur — Static Camera mode

`blurAmt = Math.max(0, (5 - shIdx) / 5)` → 1.0 at 1s, 0.0 at 1/250s and above.

Horse is moving RIGHT. Blur trail extends LEFT (where the horse was).

```javascript
var copies = Math.ceil(6 + blurAmt * 38);
var spread = blurAmt * split * 0.74;
for (var i = 0; i < copies; i++) {
  var t = i / (copies - 1);  // t=1 = current/rightmost, t=0 = oldest/leftmost
  var ox = -(1 - t) * spread; // negative offset = to the left
  var a = t > 0.88
    ? Math.max(0.62, 1.0 - blurAmt * 0.28)  // current position
    : Math.max(0.008, t*t * 0.52 * (1 - blurAmt*0.28)); // trail falloff
  drawHorse(horseX + ox, groundY, s, a);
}
```

The squared falloff (`t*t`) makes the trail fade exponentially, which looks more natural than linear.

### Panning mode

Background elements (trees, fence posts) smear LEFT with the same multi-copy approach. The horse is drawn sharp (or nearly so). The spread for background: `blurAmt * W * 0.58`.

At very slow speeds (idx 0-1), even perfect panning can't freeze the subject, so a small residual horse blur is applied: `horseResidual = shIdx <= 1 ? (1.5-shIdx)/1.5 * 0.28 : 0`.

The tracking arrow annotation (dashed line + arrowhead) is drawn in the scene at 32% opacity to label camera/subject direction without dominating the visualization.

### Exposure duration bar (right panel)
Dark panel (#0d1620). Vertical bar, height proportional to index (linear, not logarithmic — chosen for visual clarity over accuracy):
- idx=0 (1s): full bar height
- idx=8 (1/2000s): 3px minimum

Duration shown in milliseconds below the bar. Both the ms value and the fractional shutter speed are displayed.

---

## CAM-04c — ISO & Grain

### Canvas layout
Left 65% — scene with grain overlay | Right 35% — grain magnification swatch (white panel)

### Scene
Same sky/ground/buildings structure (not the horse scene). Scene gradually darkens as ISO increases (`darken = isoIdx/8 * 0.32`) to suggest that higher ISO is used in lower light conditions.

### Grain — scene overlay
Uses a seeded pseudo-random number generator for stable grain patterns per ISO setting (grain doesn't shimmer on redraw):

```javascript
var grainSeed = 0;
function rand() {
  grainSeed = (grainSeed * 1664525 + 1013904223) & 0xFFFFFFFF;
  return (grainSeed >>> 0) / 4294967296;
}
```

Seed is reset to `isoIdx * 7919` at the start of each grain pass, making each ISO setting produce the same grain pattern every time.

Grain dots are tiny arcs (radius 0.35–1.2px) alternating between near-white (228) and near-black (18) at random opacity. Density: `split * H * ga * 0.014` dots where `ga = (isoIdx-1)/7`.

### Grain swatch (right panel)
White panel showing a zoomed-in mid-tone swatch — simulates a "100% crop" view of the grain texture. Drawn independently from the scene (not a literal canvas crop). Uses a separate seed (`(isoIdx+1)*3571`) and denser grain count to make texture visible at the swatch scale. Grain dot radius scales up at higher ISO.

Quality labels: Pristine → Very Clean → Clean → Fine Grain → Moderate Grain → Heavy Grain → Strong Noise → Severe Noise → Extreme Noise.

### Course standard pill
ISO 400 (idx=2) is the course film processing standard. The "Course Standard" pill lights only at idx=2.

---

## CAM-04 — Full Exposure Triangle (original tool)

### Mode switching
Four modes: Manual | Av (aperture priority) | Tv (shutter priority) | ISO Priority.

In priority modes, two of the three sliders lock (`opacity: 0.25, pointer-events: none`) and the `compensate()` function calculates the value needed to hit EV 0.

EV math:
```javascript
function apEV(i)  { return 4 - i; }   // f/1.4 = +4EV, f/22 = -4EV
function shEV(i)  { return 4 - i; }   // 1s = +4EV, 1/2000s = -4EV
function isoEV(i) { return i - 2; }   // ISO 100 = -2EV, ISO 25600 = +6EV
function totalEV(a,s,iso) { return apEV(a) + shEV(s) + isoEV(iso); }
```

Correct exposure = EV 0. The meter needle and center triangle circle respond accordingly.

### Canvas layout
Left panel: viewfinder scene (58% height) + DOF top-down + triangle overlay | Bottom: meter bar | Right: controls (320px fixed)

The triangle is an SVG overlay positioned over the bottom-right of the canvas (green panel area). Edge thickness and marker positions respond to slider values.

---

## Known Issues / Future Work

- **Horse proportions**: The bezier curves produce a good silhouette but a horse anatomy expert will find issues. Acceptable for a teaching tool.
- **ISO grain is random**: The seeded RNG produces stable grain per setting but the grain pattern is visually uniform — real film grain has clumping and texture variation. Not worth fixing for this purpose.
- **Panning blur at extreme spread**: At 1s in panning mode, the tree smear copies can extend outside the canvas bounds. No visual problem since canvas clips, but it's wasted computation.
- **The full triangle tool (CAM-04) is a separate codebase**: It was built before the standalone tools and uses a different canvas layout and more complex draw functions. If the standalone tools are ever merged with it, the viewfinder scene would need to be reconciled.
- **Mobile**: These tools are designed for projection on a widescreen display. The layout is not responsive below about 900px wide.

---

## Modification Guide

### To change the horse color
One constant: `var HORSE = '#7A4A1E';` near the top of the scene color block in CAM-04b. Must be a color with sufficient contrast from both TREE_C (#2a3220) and SKY (#dde2e8).

### To add a new shutter speed value
Extend the `SH` and `MS` arrays. Update slider `max` attribute. Update `DESC_STATIC` and `DESC_PAN` arrays to match. Blur math uses `shIdx` directly so it scales automatically.

### To reposition the trees
Edit `getSceneElements()`. The clear zone rule: left cluster should end before `W*0.25`, right cluster should start after `W*0.75`. Horse positions are set in `drawStatic()` and `drawPanning()` as fractions of `split`.

### To change the scene in CAM-04b
The background is self-contained in `drawBackground(W, H, panBlur, blurAmt)`. The panning smear loop inside it reads from `getSceneElements()`. Adding a new element type means: drawing it in the static branch, and drawing it with the copy-smear loop in the pan branch.

### To rebuild any tool from scratch in a future session
Give the assistant this document plus the Rookery UI design architecture file (`ROOKERY_UI_DESIGN_ARCHITECTURE_v1.md`). The horse drawing function is the most complex piece — if it needs to be redrawn, the bezier control points are all defined relative to `cx`, `by` (body center Y = `groundY - s*1.65`), and scale `s`. Work from those anchors.
