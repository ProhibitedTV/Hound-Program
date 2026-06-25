# Leg Design Notes

## Screenshot review: Alpha v0.2

The v0.2 body improved the silhouette, but the legs still looked wrong.

Observed issues:

- Legs looked like vertical support sticks.
- Hip modules looked like large boxes mounted outside the body.
- Feet appeared attached directly to rods.
- There was no convincing ankle/pastern segment.
- The mechanical chain did not read like an animal or a serious quadruped.

## Alpha v0.3 correction

Alpha v0.3 introduces a four-joint visual chain:

1. Hip / shoulder output pod
2. Upper link
3. Knee joint
4. Lower link
5. Ankle / pastern joint
6. Hoof

The ankle/pastern does not need to be powered in Alpha. It can be fixed or passive while still improving the visual and mechanical plausibility.

## Design direction

The Hound leg should not look like a dog leg exactly. It should feel like:

- quadruped mechanics
- alien hoof anatomy
- paired rods instead of single sticks
- visible joint discs
- tucked hip modules
- serviceable foot adapter

## Next checks

- Inspect `mechanical/alpha_v0_3/hound_alpha_v0_3_assembly.scad`.
- Try `PART="leg_layout"` first if the full assembly is noisy.
- Confirm whether the pastern segment makes the hoof feel properly connected.
- Decide whether front and rear legs need different proportions.
