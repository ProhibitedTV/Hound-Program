# Alpha v0.3 Revision Notes

## Trigger

OpenSCAD review of Alpha v0.2 showed the body was improving, but the legs felt wrong.

User observation:

> legs feel wrong. like they should have an extra joint maybe?

## Design response

Created Alpha v0.3 with a new articulated leg module.

New files:

- `mechanical/legs/articulated_leg_v03.scad`
- `mechanical/alpha_v0_3/hound_alpha_v0_3_assembly.scad`
- `mechanical/alpha_v0_3/README.md`
- `mechanical/alpha_v0_3/OPENSCAD_REVIEW_PROMPT.md`
- `mechanical/legs/README.md`
- `docs/LEG_DESIGN_NOTES.md`

Updated:

- `mechanical/README_PARTS_INDEX.md`
- `.github/workflows/openscad-ci.yml`

## Key change

The leg now reads as:

`hip pod -> upper link -> knee -> lower link -> ankle/pastern -> hoof`

The ankle/pastern may remain fixed or passive for Alpha, but visually and mechanically it makes the hoof feel connected to a believable limb instead of a stick.

## Next review

Open `mechanical/alpha_v0_3/hound_alpha_v0_3_assembly.scad` and start with `PART="leg_layout"` before checking the full assembly.
