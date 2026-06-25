# Hound Alpha v0.1 Assembly

This folder defines the first coherent mechanical assembly checkpoint for Alpha.

## Files

- `hound_alpha_v0_1_assembly.scad` — full conceptual mechanical assembly.

## How to inspect

Open the file in OpenSCAD and change the `PART` selector:

- `assembly` — full v0.1 concept.
- `bare` — body, rails, leg placeholders, mounts, feet.
- `exploded` — separated view for sanity checking.
- `print_layout` — representative printable parts arranged on one plane.

## What v0.1 proves

- The repo has organized part categories.
- Parts can be brought into one assembly using `use`.
- The first head, foot, mounts, spine plate, battery sled, and controller tray have a shared coordinate story.
- The design has a place for boring internals and alien exterior identity.

## What v0.1 does not prove yet

- Final servo fit.
- Final chassis geometry.
- Final center of gravity.
- Final leg kinematics.
- Real-world strength.

## Viability gate

Alpha v0.1 is viable as a **conceptual and printable prototype set** when:

- OpenSCAD preview loads without obvious file path issues.
- `print_layout` shows no part collisions.
- Alien hoof prints successfully.
- One mount/bracket prints successfully.
- Head shell previews in a recognizable alien-animal direction.

The next phase is measurement-driven: choose actual servos, tubes, controller, battery, and update dimensions from real hardware.
