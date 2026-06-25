# Hound Alpha Head

OpenSCAD prototype for the Hound Alpha alien-animal head shell.

## Design intent

- Spacecraft skull silhouette.
- Sensor slits instead of obvious eyes.
- No dog face, no cute mode.
- Expression through limited armor movement: brow plates, gills, crown fins, cheek plates.
- Boring mounting adapter underneath the wild shell.

## First inspection

1. Open `hound_alpha_head_v02.scad`.
2. Start with `PART = "assembly";` to inspect the full concept.
3. Export individual parts by changing `PART`.
4. Print small plates/test rack before committing to the full shell.

## Early parts

- `upper_shell`
- `lower_mandible`
- `neck_adapter`
- `camera_mount`
- `left_brow` / `right_brow`
- `left_gill` / `right_gill`
- `crown_fin_*`
- `micro_servo_cradle`
- `linkage_arm`
- `expression_test_rack`

## Print reality notes

- First goal is visual/fit inspection, not final structural validation.
- Split or revise any part that needs ugly support.
- Replace guessed mount geometry after measuring the final chassis.
