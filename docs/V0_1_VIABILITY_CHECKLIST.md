# Alpha v0.1 Viability Checklist

This checklist defines what it means for the repo to have a viable first mechanical prototype set.

## Repo structure

- [x] Mechanical files are organized by part type.
- [x] Shared OpenSCAD constants exist.
- [x] Shared OpenSCAD primitives exist.
- [x] A top-level Alpha v0.1 assembly file exists.
- [x] Head, foot, frame, mount, power, electronics, armor, and expression prototype areas exist.

## OpenSCAD sanity checks

Open these files and preview them:

- [ ] `mechanical/alpha_v0_1/hound_alpha_v0_1_assembly.scad`
- [ ] `mechanical/heads/alpha/hound_alpha_head_v02.scad`
- [ ] `mechanical/feet/alien-hoof-type-a/hound_alien_hoof.scad`
- [ ] `mechanical/mounts/servo_mount_standard.scad`
- [ ] `mechanical/mounts/tube_clamp.scad`
- [ ] `mechanical/frame/alpha_spine_plate.scad`
- [ ] `mechanical/electronics_mounts/controller_tray.scad`
- [ ] `mechanical/power/battery_sled.scad`

## First print gates

- [ ] Print Alien Hoof Type A test coupon.
- [ ] Print Alien Hoof Type A foot core.
- [ ] Print standard servo mount.
- [ ] Print tube clamp.
- [ ] Print one armor panel.
- [ ] Print expression test rig plate.

## Measurements to collect

For each first print:

- Print time.
- Weight.
- Material used.
- Supports required.
- Fit of holes and fasteners.
- Warping or layer issues.
- Visual notes.
- Revision changes needed.

## v0.1 success definition

Alpha v0.1 succeeds when the repo can produce a believable printable prototype set and expose the next real constraints: servo choice, tube size, battery size, wiring layout, and printability problems.
