# Rookery UI Design Architecture
## Version 1.1 — Added neutral surface tokens
## Date: 2026-04-05

---

## Changelog

### v1.1 (2026-04-05)
Added two neutral surface tokens to support multi-context page design (e.g. differentiated banners for online vs. in-person content). Both additions extend the existing neutral ramp rather than introducing new hues -- consistent with the restrained Dieter Rams / Tivoli Audio design language the palette is built on.

- `--surface-dark: #444441` -- dark warm-neutral gray for alternative banner/header backgrounds
- `--bg-neutral: #F0EFED` -- cool-neutral light gray, same luminosity as parchment without the yellow cast; use where `--bg` reads muddy on screen

### v1.0 (2026-03-10)
Initial release derived from HIS (mrs-compiler/ui/index.html).

---

## Overview

Rookery UIs use a light, calm, professional aesthetic. The dominant metaphor is a well-lit document workspace — warm off-white surfaces, dark forest green accents, and monospaced type for data and code. No dark mode. No gradients. No decorative chrome.

---

## Color Palette

```css
:root {
  --bg:           #F4F2EE;  /* Page background — warm parchment */
  --bg-neutral:   #F0EFED;  /* Page background — cool neutral, use where parchment reads muddy */
  --surface:      #FFFFFF;  /* Cards, panels, sidebars, headers */
  --surface-dark: #444441;  /* Dark banner/header backgrounds — in-person/lab context */
  --text:         #121212;  /* Primary text */
  --text-2:       #4A4A4A;  /* Secondary text, labels, metadata */
  --divider:      #E2E0DA;  /* Borders, separators, inactive elements */
  --accent:       #2F4A3F;  /* Forest green — primary action color */
  --accent-dim:   #3d5e51;  /* Accent hover state */
  --danger:       #5C2F2F;  /* Error, destructive actions */
  --warn:         #7A4A1E;  /* Warning text */
  --warn-bg:      #FDF6EE;  /* Warning background */
  --warn-border:  #E8C8A0;  /* Warning border */
}
```

### Usage Rules

| Token | Use for |
|---|---|
| `--bg` | Page/app background — warm parchment |
| `--bg-neutral` | Page/app background — cool neutral alternative to `--bg` |
| `--surface` | Any elevated panel: cards, sidebar, header, input bar |
| `--surface-dark` | Dark banner or header backgrounds; use only for deliberate content-type differentiation (e.g. lab vs. online module banners). Text on this background must be white. |
| `--text` | All body copy, active labels |
| `--text-2` | Section labels, metadata, placeholder-adjacent text |
| `--divider` | All borders, horizontal rules, inactive step indicators |
| `--accent` | Primary buttons, active tab underlines, active step numbers, links, focus rings |
| `--accent-dim` | Accent hover state only |
| `--danger` | Destructive button text, error states, failure indicators |
| `--warn` | Warning button text and icons |
| `--warn-bg` | Warning panel background |
| `--warn-border` | Warning panel border |

---

## Typography

```css
--mono: 'IBM Plex Mono', monospace;
--sans: 'IBM Plex Sans', sans-serif;
```

Google Fonts import:
```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;500&family=IBM+Plex+Sans:wght@300;400;500;600&display=swap" rel="stylesheet">
```

### Type Scale

| Role | Font | Size | Weight | Notes |
|---|---|---|---|---|
| Page title / H1 | IBM Plex Sans | 18px | 600 | `letter-spacing: -0.3px` |
| Section label | IBM Plex Mono | 11px | 600 | `text-transform: uppercase; letter-spacing: 0.06em` |
| Body text | IBM Plex Sans | 14px | 400 | Base size |
| Button text | IBM Plex Sans | 13px | 500 | |
| Subtitle / path | IBM Plex Mono | 12px | 400 | Used for file paths, run IDs, metadata |
| Status / mono data | IBM Plex Mono | 12px | 400 | Pipeline status, audit output |
| Micro label | IBM Plex Mono | 10-11px | 400-500 | Tags, pills, timestamps |
| Input text | IBM Plex Mono | 12px | 400 | All text inputs use mono |

---

## Spacing & Shape

```css
border-radius: 4px;   /* Cards, panels, status blocks */
border-radius: 3px;   /* Buttons, inputs, smaller elements */
border-radius: 2px;   /* Tags, pills, inline badges */
border-radius: 50%;   /* Circular step numbers / avatars only */
```

### Standard Spacing

| Context | Value |
|---|---|
| Page padding (top/sides) | `32px 24px` |
| Card / panel padding | `20px` |
| Section padding (sidebar) | `16px 20px` |
| Input padding | `8px 12px` |
| Button padding | `0 14px` (height fixed at 34px) |
| Gap between cards | `12px` |
| Gap between form rows | `8-10px` |

---

## Components

### Header

```css
background: var(--surface);
border-bottom: 1px solid var(--divider);
padding: 16px 24px;
```

- H1: 18px / 600 / `letter-spacing: -0.3px`
- Subtitle (path, version): IBM Plex Mono 12px / `--text-2`
- Status indicator (right-aligned): dot + label in IBM Plex Mono 11px

### Canvas Module Banners

Two banner variants for Canvas course pages. Both use the same icon-left layout and type scale. Color encodes content type.

**Online module banner** — `--accent` background (#2F4A3F), monitor icon:
```html
<div style="background:#2F4A3F; border-radius:4px; padding:20px 24px; margin-bottom:28px; display:flex; align-items:center; gap:20px;">
  <!-- monitor SVG icon -->
  <div>
    <p style="font-family:'IBM Plex Mono',monospace; font-size:11px; color:rgba(255,255,255,0.6); margin:0 0 6px 0;">Week N</p>
    <p style="font-family:'IBM Plex Sans',sans-serif; font-size:22px; color:#ffffff; margin:0 0 10px 0;">Online Module</p>
    <p style="font-family:'IBM Plex Sans',sans-serif; font-size:14px; color:rgba(255,255,255,0.9); margin:0;">Complete this independently, on your own time, <strong style="color:#ffffff;">before Tuesday's class.</strong></p>
  </div>
</div>
```

**In-person lab banner** — `--surface-dark` background (#444441), apron-person icon:
```html
<div style="background:#444441; border-radius:4px; padding:20px 24px; margin-bottom:28px; display:flex; align-items:center; gap:20px;">
  <!-- apron-person SVG icon -->
  <div>
    <p style="font-family:'IBM Plex Mono',monospace; font-size:11px; color:rgba(255,255,255,0.6); margin:0 0 6px 0;">Week N — Lab</p>
    <p style="font-family:'IBM Plex Sans',sans-serif; font-size:22px; color:#ffffff; margin:0 0 10px 0;">Tuesday — In Person</p>
    <p style="font-family:'IBM Plex Sans',sans-serif; font-size:14px; color:rgba(255,255,255,0.9); margin:0;">In-person lab session. This page is a reference for what we cover in class.</p>
  </div>
</div>
```

### Cards

```css
background: var(--surface);
border: 1px solid var(--divider);
border-radius: 4px;
padding: 20px;
```

Active card state:
```css
.card.active .step-num { background: var(--accent); color: #fff; }
.card.active .card-title { color: var(--text); }
```

Inactive step number:
```css
background: var(--divider); color: var(--text-2);
width: 24px; height: 24px; border-radius: 50%;
font-size: 11px; font-weight: 600;
```

### Buttons

Four variants. All: `height: 34px; border-radius: 3px; font-family: var(--sans); font-size: 13px; font-weight: 500; cursor: pointer;`

```css
/* Primary — main action */
.btn-primary {
  background: var(--accent); color: #fff;
  border: 1px solid var(--accent);
}
.btn-primary:not(:disabled):hover { background: var(--accent-dim); }

/* Secondary — neutral action */
.btn-secondary {
  background: transparent; color: var(--text);
  border: 1px solid var(--divider);
}
.btn-secondary:not(:disabled):hover { border-color: #999; }

/* Danger — destructive action */
.btn-danger {
  background: transparent; color: var(--danger);
  border: 1px solid var(--divider);
}
.btn-danger:not(:disabled):hover { border-color: var(--danger); }

/* Warn — caution action */
.btn-warn {
  background: transparent; color: var(--warn);
  border: 1px solid var(--warn-border);
}
.btn-warn:not(:disabled):hover { background: var(--warn-bg); border-color: var(--warn); }

/* Disabled state — all variants */
button:disabled { opacity: 0.4; cursor: not-allowed; }
```

Transition on all buttons: `transition: background 0.15s, opacity 0.15s;`

### Text Inputs

```css
height: 36px; padding: 0 10px;
border: 1px solid var(--divider); border-radius: 3px;
background: var(--bg); color: var(--text);
font-family: var(--mono); font-size: 12px;
outline: none; transition: border-color 0.15s;
```

Focus state:
```css
input:focus { border-color: var(--accent); }
```

Textareas follow the same pattern with `resize: none` and auto-height expansion.

### Status / Pipeline Blocks

```css
/* Default */
border: 1px solid var(--divider);
background: var(--surface);
border-radius: 4px; padding: 16px 20px;
transition: background 0.3s, border-color 0.3s;

/* Running / Success */
background: var(--accent); border-color: var(--accent);

/* Failure */
background: var(--danger); border-color: var(--danger);
```

When colored (running/success/failure), text inside inverts to white. Sub-text uses `rgba(255,255,255,0.7)`.

### Gate Pills (inside status blocks)

```css
font-size: 10px; font-family: var(--mono);
padding: 2px 7px; border-radius: 2px;
background: rgba(255,255,255,0.12); color: rgba(255,255,255,0.5);
border: 1px solid rgba(255,255,255,0.18);

.gate-pill.done    { background: rgba(255,255,255,0.25); color: #fff; }
.gate-pill.current { background: rgba(255,255,255,0.9); color: var(--accent); font-weight: 600; }
```

### Inline Tags / Badges

```css
background: var(--bg);
border: 1px solid var(--divider);
color: var(--accent);               /* or --danger for error tags */
font-family: var(--mono);
font-size: 10px;
padding: 2px 8px;
border-radius: 2px;
letter-spacing: 0.04em;
```

### Error / Failure Detail Panels

```css
background: var(--surface);
border: 1px solid #d4b0b0;
border-radius: 4px;
padding: 16px 20px;
```

Error label:
```css
font-size: 11px; font-weight: 600; text-transform: uppercase;
letter-spacing: 0.08em; color: var(--danger); margin-bottom: 10px;
```

Error code block (monospaced pre):
```css
background: #fdf6f6; border: 1px solid #e8cccc; border-radius: 3px;
padding: 10px 12px; font-family: var(--mono); font-size: 11px; color: var(--danger);
```

### Dividers

Always: `border-bottom: 1px solid var(--divider);` — never use `<hr>` elements.

---

## Scrollbar Styling

```css
::-webkit-scrollbar { width: 5px; }
::-webkit-scrollbar-track { background: transparent; }
::-webkit-scrollbar-thumb { background: var(--divider); border-radius: 3px; }
::-webkit-scrollbar-thumb:hover { background: #ccc; }
```

---

## Transitions

| Element | Transition |
|---|---|
| Buttons | `background 0.15s, opacity 0.15s` |
| Inputs | `border-color 0.15s` |
| Status blocks | `background 0.3s, border-color 0.3s` |
| Step numbers, card titles | `background 0.2s, color 0.2s` |

---

## Layout Principles

- **Page background** (`--bg`) is always parchment. Use `--bg-neutral` where the warm cast reads muddy on screen. Only panels and cards use white (`--surface`).
- **No shadows.** Elevation is expressed through borders only (`1px solid var(--divider)`).
- **No gradients** anywhere in the base UI.
- **Mono for data, sans for prose.** File paths, IDs, status strings, inputs — mono. Labels, buttons, body copy — sans.
- **Section labels** are always uppercase mono 11px `--text-2` with `letter-spacing: 0.06em`. They introduce blocks of content, not headings.
- **Panels are white on parchment.** Sidebar, header, input bar, cards: all `--surface`. Page body: `--bg`.
- **Active states use `--accent` fill** (step numbers, tab underlines, connection dots). Never a border-only active state for primary actions.
- **Dark backgrounds** (`--accent`, `--surface-dark`) are used only for deliberate content-type signaling (banners, status blocks). All text on dark backgrounds must be white or `rgba(255,255,255,N)`.

---

## Application to New Panels

When adding a new panel to HIS:

1. Wrap in `--surface` background with `border: 1px solid var(--divider)`
2. Use section labels (uppercase mono 11px) to introduce each content area
3. Primary action button: `btn-primary` (green fill)
4. Destructive or exit action: `btn-danger`
5. Neutral / secondary action: `btn-secondary`
6. All text inputs: mono font, `--bg` background, accent focus border
7. Phase/step indicators: circular `--divider` background inactive, `--accent` fill active
8. Do not introduce new colors outside the token set above
