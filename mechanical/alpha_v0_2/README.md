# Hound Alpha v0.2 Refined Assembly

This is the first elegance pass after reviewing the v0.1 OpenSCAD assembly.

## Why v0.2 exists

The v0.1 assembly proved that the repo had a coherent part library, but the visual result was too blocky: stacked trays, square modules, vertical stick legs, and a large faceted head/body that did not yet match the original alien-hoof concept sheet.

v0.2 shifts the design language toward:

- lower stance
- longer body line
- tucked hip modules
- angled legs
- cleaner alien exoshell
- visible sensor slit instead of a readable face
- v0.2 alien hoof feet

## Files

- `hound_alpha_v0_2_assembly.scad` — refined whole-hound concept assembly.
- `../body/alpha_exoshell_v02.scad` — new body shell used by the refined assembly.

## OpenSCAD PART options

- `assembly` — full refined concept.
- `bare_frame` — rails, spine, hip modules, angled legs, feet.
- `silhouette` — exoshell, sensor cluster, audio panel.
- `print_layout` — representative printable parts on one plane.

## Current limitation

The assembly still restates globals required by modules imported through OpenSCAD `use`. This is acceptable for v0.2 but should be replaced by parameterized modules later.

## Design target

The robot should read less like a stack of brackets and more like one coherent alien mechanical animal.
