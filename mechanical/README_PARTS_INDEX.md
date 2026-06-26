# Mechanical Parts Index

This index tracks OpenSCAD files by part type.

## Shared Libraries

- `mechanical/lib/hound_constants.scad` — hardware dimensions, clearances, material assumptions.
- `mechanical/lib/hound_primitives.scad` — rounded boxes, holes, tags, fins, lightening grids.
- `mechanical/lib/hound_hardware_envelopes.scad` — common CAD planning envelopes for servos, controller boards, servo driver boards, and battery volume.

## Alpha Assemblies

- `mechanical/alpha_v0_1/hound_alpha_v0_1_assembly.scad` — first conceptual assembly checkpoint.
- `mechanical/alpha_v0_2/hound_alpha_v0_2_assembly.scad` — refined body silhouette checkpoint.
- `mechanical/alpha_v0_3/hound_alpha_v0_3_assembly.scad` — articulated leg silhouette checkpoint.
- `mechanical/alpha_v0_4/panel_split_test.scad` — first printable panel split test.
- `mechanical/alpha_v0_4/leg_side_test_module.scad` — first simplified leg side module for scale and stance review.
- `mechanical/alpha_v0_4/leg_side_test_module_v02.scad` — refined v0.4.2 leg-side module with flat link plates, pivot holes, hip bracket, and hoof adapter.
- `mechanical/alpha_v0_5/alpha_v0_5_concept.scad` — root concept correction using rough hardware envelopes.
- `mechanical/alpha_v0_6/hound_alpha_v0_6_assembly.scad` — grounded concept assembly that reconnects the original visual direction to hardware envelopes and printable link logic.

## Head / Identity Shell

- `mechanical/heads/alpha/hound_alpha_head_v02.scad` — Hound Alpha alien-animal head prototype.

## Body Panels / Exoshell

- `mechanical/body/alpha_side_panel_set.scad` — removable side/top body panels.
- `mechanical/body/alpha_exoshell_v02.scad` — refined long tapered body shell.

## Feet

- `mechanical/feet/alien-hoof-type-a/hound_alien_hoof.scad` — original Alien Hoof Type A v0.1 module.
- `mechanical/feet/alien-hoof-type-a/hound_alien_hoof_v02.scad` — manufacturing-minded v0.2 foot.

## Interfaces

- `mechanical/interfaces/foot_mount_m3_28mm.scad` — reference 28 mm M3 foot interface.

## Legs and Joints

- `mechanical/legs/leg_link_set.scad` — early upper/lower/tube leg link concepts.
- `mechanical/legs/articulated_leg_v03.scad` — refined four-joint visual leg chain.
- `mechanical/joints/hip_module.scad` — replaceable hip/shoulder servo module concept.

## Mounts

- `mechanical/mounts/servo_mount_standard.scad` — standard servo bracket prototype.
- `mechanical/mounts/tube_clamp.scad` — carbon fiber tube clamp prototype.

## Frame

- `mechanical/frame/alpha_spine_plate.scad` — early central spine/electronics plate.

## Armor

- `mechanical/armor/armor_plate_family.scad` — non-load-bearing identity armor plates.

## Sensors / Lighting / Audio

- `mechanical/sensors/front_sensor_pod.scad` — front sensor pod.
- `mechanical/lighting/led_diffuser_modules.scad` — LED diffuser modules.
- `mechanical/audio/audio_grille_module.scad` — removable audio grille module.

## Cable Management

- `mechanical/cable_management/cable_clip_set.scad` — cable clips and pass-through.

## Expression Experiments

- `mechanical/expressions/expression_plate_test_rig.scad` — armor expression bench rig.

## Electronics Mounts

- `mechanical/electronics_mounts/controller_tray.scad` — generic controller tray.

## Power Mounts

- `mechanical/power/battery_sled.scad` — generic battery sled.

## Bench Hardware

- `mechanical/safety/bench_control_panel_mount.scad` — accessible bench control panel mount.

## Test Fixtures

- `mechanical/test_fixtures/fastener_tolerance_gauge.scad` — real-printer clearance and insert gauge.
- `mechanical/test_fixtures/alpha_service_stand.scad` — service stand fixture.

## Current principle

Boring internals. Wild exterior. Alpha v0.6 reconnects the root concept silhouette with realistic hobby hardware envelopes.
