# Mechanical Parts Index

This index tracks OpenSCAD files by part type.

## Shared Libraries

- `mechanical/lib/hound_constants.scad` — hardware dimensions, clearances, material assumptions.
- `mechanical/lib/hound_primitives.scad` — rounded boxes, holes, tags, fins, lightening grids.

## Alpha v0.1 Assembly

- `mechanical/alpha_v0_1/hound_alpha_v0_1_assembly.scad` — current conceptual assembly checkpoint.

## Head / Identity Shell

- `mechanical/heads/alpha/hound_alpha_head_v02.scad` — Hound Alpha alien-animal head prototype.

## Body Panels

- `mechanical/body/alpha_side_panel_set.scad` — removable side/top body panels for Alpha silhouette and service access.

## Feet

- `mechanical/feet/alien-hoof-type-a/hound_alien_hoof.scad` — original Alien Hoof Type A v0.1 module.
- `mechanical/feet/alien-hoof-type-a/hound_alien_hoof_v02.scad` — manufacturing-minded v0.2 foot with stronger bosses, batch layout, adapter mock, and coating test coupon.

## Interfaces

- `mechanical/interfaces/foot_mount_m3_28mm.scad` — reference 28 mm M3 foot interface used by Alien Hoof Type A.

## Legs and Joints

- `mechanical/legs/leg_link_set.scad` — early upper/lower/tube leg link concepts.
- `mechanical/joints/hip_module.scad` — replaceable hip/shoulder servo module concept.

## Mounts

- `mechanical/mounts/servo_mount_standard.scad` — standard servo bracket prototype.
- `mechanical/mounts/tube_clamp.scad` — carbon fiber tube clamp prototype.

## Frame

- `mechanical/frame/alpha_spine_plate.scad` — early central spine/electronics plate.

## Armor

- `mechanical/armor/armor_plate_family.scad` — non-load-bearing identity armor plates.

## Sensors / Lighting / Audio

- `mechanical/sensors/front_sensor_pod.scad` — front sensor pod that reads as a sensor cluster, not a face.
- `mechanical/lighting/led_diffuser_modules.scad` — straight and grouped LED diffuser modules.
- `mechanical/audio/audio_grille_module.scad` — removable audio grille module.

## Cable Management

- `mechanical/cable_management/cable_clip_set.scad` — 4 mm, 6 mm, 8 mm cable clips and pass-through.

## Expression Experiments

- `mechanical/expressions/expression_plate_test_rig.scad` — bench rig for micro-actuated armor expression tests.

## Electronics Mounts

- `mechanical/electronics_mounts/controller_tray.scad` — generic controller tray.

## Power Mounts

- `mechanical/power/battery_sled.scad` — generic battery sled.

## Safety / Bench Hardware

- `mechanical/safety/bench_control_panel_mount.scad` — accessible bench control panel mount for early moving prototypes.

## Test Fixtures

- `mechanical/test_fixtures/fastener_tolerance_gauge.scad` — real-printer clearance and insert gauge.
- `mechanical/test_fixtures/alpha_service_stand.scad` — service stand fixture for wiring/calibration/leg work.

## Current principle

The internals should remain serviceable and boring while the exterior becomes the alien-animal identity layer.
