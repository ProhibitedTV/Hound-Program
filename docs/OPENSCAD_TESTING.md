# OpenSCAD Testing

The Hound Program repo has an OpenSCAD smoke test path for checking that v0.1 files can render/export representative STL files.

## GitHub Actions

Workflow:

- `.github/workflows/openscad-ci.yml`

The workflow installs OpenSCAD on Ubuntu and runs:

```bash
bash scripts/openscad_smoke_test.sh /tmp/hound-openscad-out
```

It then uploads generated STL files as a workflow artifact.

## Local testing

With OpenSCAD installed:

```bash
make openscad-test
```

or:

```bash
bash scripts/openscad_smoke_test.sh ./build/openscad
```

## What the smoke test checks

The script exports representative STL files for:

- Alpha v0.1 assembly modes.
- Hound Alpha head parts.
- Alien Hoof Type A parts.
- Servo mount.
- Tube clamp.
- Spine plate.
- Controller tray.
- Battery sled.
- Armor panel.
- Expression rig.

## Important design note

OpenSCAD `use` imports modules and functions, but it does not import top-level variable assignments from the used files. The Alpha v0.1 assembly currently restates imported-part globals for compatibility.

Future cleanup target:

- Convert part modules to accept explicit parameters.
- Keep constants in `mechanical/lib/hound_constants.scad`.
- Reduce hidden global-variable dependencies.
