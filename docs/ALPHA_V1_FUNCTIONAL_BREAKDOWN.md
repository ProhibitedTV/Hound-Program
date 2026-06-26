# Alpha v1 Functional Breakdown

Alpha v0.9 is the current visual candidate. Alpha v1.0 starts the functional breakdown.

## Functional modules

| Module | File | Purpose |
|---|---|---|
| Frame core | `mechanical/alpha_v1_0_functional/alpha_frame_core.scad` | Holds rails, crossmembers, board tray, battery tray |
| Shell panels | `mechanical/alpha_v1_0_functional/alpha_shell_panels.scad` | Splits the outer shell into printable panels |
| Leg module | `mechanical/alpha_v1_0_functional/alpha_leg_module.scad` | Tests hip cradle, paired links, pivots, hoof adapter |
| Type A hoof | `mechanical/alpha_v1_0_functional/alpha_hoof_type_a.scad` | Turns the alien hoof into a printable test module |
| Functional assembly | `mechanical/alpha_v1_0_functional/alpha_functional_assembly.scad` | Rough layout scaffold using the functional modules |

## Print philosophy

Do not print the whole robot first.

Print smallest useful test pieces:

1. bolt gauge
2. coating coupon
3. rail clamp
4. one link plate
5. hip cradle
6. hoof core
7. one side panel

## What must be measured after first prints

- M3 clearance fit
- M4 pivot clearance fit
- heat-set insert fit if used later
- rail clamp grip on real tube
- hoof coating thickness
- link stiffness
- whether screw access is realistic

## Current target

The next milestone is one physical leg-side test:

`hip cradle -> upper link -> knee spacer -> lower link -> ankle spacer -> pastern link -> hoof adapter -> Type A hoof`
