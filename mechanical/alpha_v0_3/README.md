# Hound Alpha v0.3 Articulated-Leg Assembly

This revision responds to the v0.2 OpenSCAD review.

## Problem observed in v0.2

The body direction was better, but the legs still felt wrong:

- too boxy at the hip
- too much like vertical sticks
- not enough visible articulation
- feet did not feel connected through a believable ankle/pastern segment

## v0.3 changes

- Adds `mechanical/legs/articulated_leg_v03.scad`.
- Adds a visible hip pod, upper link, knee, lower link, ankle/pastern, and hoof.
- Uses paired rods instead of single stick legs.
- Tucks the leg modules under the side cowls.
- Makes the front sensor pod smaller so it no longer reads as a giant blocky snout.
- Forces the exoshell to dark colors in the assembly so the preview is closer to the intended concept.

## OpenSCAD PART options

- `assembly` — full refined v0.3 concept.
- `bare_frame` — rails, spine, legs.
- `leg_layout` — all four articulated legs.
- `silhouette` — body shell, front sensor cluster, rear audio panel.
- `print_layout` — representative printable pieces.

## Design note

The added ankle/pastern segment does not have to be powered in Alpha. It can be fixed or passive at first. The important change is that the limb now has a more believable mechanical chain and the hoof no longer appears stuck directly to a stick.
