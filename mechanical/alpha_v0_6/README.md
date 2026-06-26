# Hound Alpha v0.6

Alpha v0.6 is the correction pass after comparing the OpenSCAD leg mock against the original concept art.

## Goal

Regain the original long dark alien-machine profile while keeping the model grounded in hobby robotics hardware envelopes.

## Files

- `hound_alpha_v0_6_assembly.scad` — whole concept assembly with separated hardware and shell views.

## PART modes

- `assembly` — full concept.
- `hardware` — frame, board volumes, servos, hubs, legs.
- `shell` — faceted shell, armor panels, red channels.
- `legset` — all four legs.
- `one_leg` — one front leg.
- `print_layout` — candidate physical test pieces.

## What changed from v0.5

- Longer body line.
- More side armor to hide rectangular hardware.
- Visible circular hubs closer to the original concept sheet.
- Separate hardware and shell layers.
- Board and battery volumes remain visible in hardware mode.
- Link plates keep real pivot holes instead of pure visual rods.

## Review order

1. `PART = "shell"`
2. `PART = "hardware"`
3. `PART = "legset"`
4. `PART = "assembly"`
5. `PART = "print_layout"`
