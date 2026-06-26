# Hound Alpha v0.4 Manufacturing Direction

Alpha v0.3 is a useful visual checkpoint. It shows the extra ankle/pastern joint helps the leg read, but the model is still a concept creature.

Alpha v0.4 starts converting the visual direction into printable subassemblies for the Kobra 2 Max workflow.

## Goals

- Keep the alien silhouette.
- Split the body into printable panels.
- Keep the frame separate from cosmetic armor.
- Keep screws reachable.
- Reserve space for battery, controller, wiring, and sensors.
- Define one printable leg and hoof test module before attempting a full body.

## Files

- `panel_split_test.scad` — first body panel split experiment.
- `leg_side_test_module.scad` — first simplified leg-side mock; useful but too toy-like.
- `leg_side_test_module_v02.scad` — refined printable-link pass with flat link plates, pivot holes, clevis-style hip bracket, and hoof adapter.

## v0.4 priorities

1. Printable leg module.
2. Hoof plus ankle interface test.
3. Split dorsal shell panels.
4. Split side cowl panels.
5. Hip module envelope with fastener access.
6. Simple mass placeholders for battery and electronics.
7. Tolerance coupons for real printer fit.

## What not to do yet

- Do not print the full robot.
- Do not buy final actuators before estimating mass and torque.
- Do not merge decorative armor into structural parts.
- Do not hide screws behind permanent panels.

## First v0.4 physical target

A single leg-side test assembly:

`hip envelope -> upper link -> knee -> lower link -> ankle/pastern -> hoof`

The first print should teach us fit, scale, stance, and part accessibility.

## Current review target

Open `leg_side_test_module_v02.scad` and inspect:

- `PART = "assembly"`
- `PART = "front_leg"`
- `PART = "print_layout"`

Judge whether the leg now feels more like printable mechanics instead of a toy diagram.
