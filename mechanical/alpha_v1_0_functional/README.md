# Alpha v1.0 Functional Breakdown

This folder starts turning the v0.9 candidate into functional printable subassemblies.

## Goal

Stop treating the full render as one object. Break it into testable parts:

- frame core
- shell panels
- leg module
- Type A hoof module
- functional layout scaffold

## Files

- `alpha_frame_core.scad` — spine plate, rail clamps, crossmembers, electronics tray, battery tray.
- `alpha_shell_panels.scad` — split shell panels, side panels, skirt panels, sensor carriers.
- `alpha_leg_module.scad` — hip cradle, paired links, pivot spacers, hoof adapter.
- `alpha_hoof_type_a.scad` — printable Alien Hoof Type A module and coupons.
- `alpha_functional_assembly.scad` — rough assembly scaffold using the functional modules.

## First print candidates

1. `alpha_hoof_type_a.scad`, `PART = "bolt_gauge"`
2. `alpha_hoof_type_a.scad`, `PART = "coating_coupon"`
3. `alpha_hoof_type_a.scad`, `PART = "hoof_core"`
4. `alpha_leg_module.scad`, `PART = "hip_cradle"`
5. `alpha_leg_module.scad`, `PART = "upper_link"`
6. `alpha_frame_core.scad`, `PART = "rail_clamp"`
7. `alpha_shell_panels.scad`, `PART = "side_mid"`

## Review order

Open `alpha_functional_assembly.scad`, then inspect:

1. `PART = "frame"`
2. `PART = "panels"`
3. `PART = "legs"`
4. `PART = "assembly"`
5. `PART = "print_layout"`

The full assembly is only for layout. The individual subassembly files are the real printable candidates.
