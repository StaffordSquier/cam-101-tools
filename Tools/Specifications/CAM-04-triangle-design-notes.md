# CAM-04 Triangle — Exposure Triangle Simulator (Simplified)
## Design Notes — v1.0 (April 2026)

---

## What this file is

Standalone interactive teaching tool for CAM-101 Week 2. Teaches the three-way relationship between aperture, shutter speed, and ISO through a live exposure triangle. Built to Rookery UI v1.0.

**File:** `Tools/Html_tools/cam-04-triangle.html`
**Live URL:** `https://staffordsquier.github.io/cam-101-tools/Tools/Html_tools/cam-04-triangle.html`
**Canvas page slug:** `interactive-tool-the-exposure-triangle`
**Canvas module:** Week 1 — Getting Started: Lab (ID 218160), position 3

---

## Relationship to other tools

This is a deliberate simplification of the comprehensive CAM-04 tool (cam-04-v6-2.html), which includes a viewfinder scene simulation, DOF top-down diagram, and iris animation. Those elements were removed because:

- A first-week student is overwhelmed by too many simultaneous visuals
- The triangle relationship is the core lesson; everything else is distraction
- The light meter tool (cam-light-meter.html) handles scene reading — this tool handles the response

**Sequence in Canvas:** Light Meter → Exposure Triangle (this tool)

---

## Layout

**Left panel (flex column, centered):**
- Exposure triangle SVG — dominant visual, fills available height
- Reciprocity callout (hidden in Manual mode, appears in priority modes)
- Ambient light accordion (collapsed by default, EV 12 overcast)
- Exposure meter bar

**Right panel (300px, scrollable):**
- Aperture slider + pills
- Shutter speed slider + pills
- ISO discrete selector (6 buttons) + pills

No summary bar. Removed in final revision — duplicated slider information.

---

## Design decisions

### Background color
`#F0F0F0` — neutral light gray. Departs from Rookery `--bg` parchment (#F4F2EE) at Stafford's explicit direction. Parchment read as too warm/taupe in this context.

### ISO as discrete selector, not slider
Film ISO is a discrete physical choice made before loading the camera — not a continuous variable. Buttons (100, 200, 400, 800, 1600, 3200) reflect this reality. The slider metaphor was wrong for film.

### No edge labels on triangle
Attempted, caused confusion. The edge between Aperture and Shutter Speed nodes cannot be meaningfully labeled as either variable — it represents the trade-off between them, not one of them. Labels removed entirely. Sliders on the right panel carry all labeling.

### No vertex labels
Attempted vertex labels (APERTURE / SHUTTER / ISO). Caused the same confusion as edge labels from a different angle — which vertex belongs to which label when looking at the triangle? Students make the connection from slider → node value rather than from label → node.

### Center ring
Shows only the EV number — large, centered, no surrounding text. Color communicates status:
- Solid forest green fill + white text = correct exposure for current light
- Warm orange-red tint = overexposed
- Cool blue tint = underexposed
The ring pulses when at correct exposure.

### Draggable markers
Two draggable dots (aperture, shutter) in `#7A4A1E` amber with white fill and drop shadow — visually distinct from the green triangle edges, reads immediately as interactive.

ISO marker is an outlined circle (white fill, green border) — non-draggable, reflects that ISO is a fixed film choice not a continuous adjustment.

Markers are clamped so they never travel behind vertex node circles — always visible on the edge.

### Reciprocity callout
Appears below the triangle only in priority modes. Updates live as the slider moves:
- Av: "You set f/4 — camera set 1/250 to keep correct exposure."
- Tv: "You set 1/125 — camera set f/5.6 to keep correct exposure."

Styled with a green left border (accent color), sits where the student's eyes already are. Replaces the static hint bar that previously appeared at the top of the screen.

### Ambient light accordion
Collapsed by default (Overcast, EV 12 — appropriate Pacific Northwest baseline). Six named presets + continuous EV 5–16 slider. All EV math runs against `ambientEV` so the meter and center ring reflect whether settings match the actual scene, not an abstract EV 0.

---

## EV math

Uses real photographic values — not integer approximations:

```javascript
function calcEV(apI, shI, iso_idx) {
  var N = AP_VAL[apI], t = SH_VAL[shI], S = ISO[iso_idx];
  return Math.round(Math.log2((N * N) / t) - Math.log2(S / 100));
}
```

`diff = calcEV(...) - ambientEV` drives the meter needle and center ring state.

Priority mode compensation finds the shutter/aperture index that minimizes `Math.abs(calcEV(...) - ambientEV)` across all 9 possible values.

---

## Mode behavior

**Manual:** All three controls active. Needle shows exposure relative to ambient EV.

**Aperture Priority:** Aperture and ISO user-controlled. Shutter speed locked and auto-compensated. Reciprocity callout: "You set [aperture] — camera set [shutter]."

**Shutter Priority:** Shutter speed and ISO user-controlled. Aperture locked and auto-compensated. Reciprocity callout: "You set [shutter] — camera set [aperture]."

ISO is always user-controlled in all modes.

---

## Rookery UI compliance

| Token | Used for |
|---|---|
| `--bg` (#F0F0F0, modified) | Page background |
| `--surface` (#FFFFFF) | Control panel, cards, meter bar, reciprocity box |
| `--text` (#121212) | Primary text |
| `--text-2` (#4A4A4A) | Labels, descriptions, secondary text |
| `--divider` (#E2E0DA) | All borders |
| `--accent` (#2F4A3F) | Active buttons, ISO selector active, slider fill, green left border on callout, ISO marker outline |
| `--warn` (#7A4A1E) | Draggable marker dot border — signals interactivity |

IBM Plex Mono for all data values, labels, node text.
IBM Plex Sans for body copy, button text, descriptions.
