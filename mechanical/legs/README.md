# Legs

Leg geometry and experimental quadruped limb modules.

## Files

- `leg_link_set.scad` — early upper/lower/tube link concepts.
- `articulated_leg_v03.scad` — refined v0.3 articulated visual leg chain.

## v0.3 design intent

The v0.3 leg adds a visible ankle/pastern segment because the v0.2 legs felt like sticks with hooves attached.

The new chain is:

`hip pod -> upper link -> knee -> lower link -> ankle/pastern -> hoof`

The ankle/pastern does not need to be powered in Alpha. It can be a fixed or passive piece while the robot uses normal 3-DOF quadruped kinematics.

## Print order suggestion

1. Render `PART="joint_set"` from `articulated_leg_v03.scad`.
2. Render one `PART="leg_front_left"`.
3. Print a small joint/rod coupon before committing to a full leg.
4. Compare front and rear proportions before duplicating the whole set.
