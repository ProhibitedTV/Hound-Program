# Engineering Log

Record design decisions, failures, measurements, and revision notes here.

## Log Entry Template

Date:
Subsystem:
Revision:

Objective:

Changes:

Print / Build Settings:

Observed Result:

Failures / Issues:

Next Action:

## Initial Repository Setup

Subsystem: Program
Revision: repo-0001

Objective:
Set up the Hound Program repository to receive mechanical, electronics, firmware, HoundOS, docs, and fleet files.

Changes:
- Expanded README.
- Added design rules.
- Added engineering log template.
- Added initial OpenSCAD prototype folders.

Next Action:
Inspect first head and alien hoof prototypes, then revise based on print reality.

## Alpha v0.3 Leg Refinement

Subsystem: Mechanical / Legs
Revision: Alpha v0.3

Objective:
Fix the v0.2 leg silhouette after OpenSCAD review showed the legs still looked wrong and needed another visible articulation point.

Observed Result:
- v0.2 body direction improved.
- v0.2 legs still looked too blocky and stick-like.
- Hooves appeared attached directly to vertical supports.
- Hip modules read as large external boxes.

Changes:
- Added articulated leg v0.3 with hip pod, upper link, knee, lower link, ankle/pastern, and hoof.
- Added Alpha v0.3 assembly using the new leg module.
- Added review notes and leg design documentation.
- Updated CI to render Alpha v0.3 and the new leg module.

Next Action:
Open `mechanical/alpha_v0_3/hound_alpha_v0_3_assembly.scad`, inspect `PART="leg_layout"`, then inspect `PART="assembly"`.
