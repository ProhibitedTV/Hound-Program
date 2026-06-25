# OpenSCAD Testing

The Hound Program repo uses GitHub Actions as the primary OpenSCAD smoke-test path.

## GitHub Actions

The workflow lives at .github/workflows/openscad-ci.yml.

The workflow installs OpenSCAD on Ubuntu and directly exports representative STL files from tracked OpenSCAD parts. No separate shell script is required.

## Local testing

With OpenSCAD installed, use the workflow as the source of truth for local commands.

Minimum useful local checks:

- Export the alien hoof foot core.
- Export the standard servo mount.
- Export the Alpha v0.1 print layout.

## What the smoke test checks

The workflow exports representative STL files for:

- Alpha v0.1 assembly modes.
- Hound Alpha head parts.
- Alien Hoof Type A parts.
- Servo mount.
- Tube clamp.
- Spine plate.
- Controller tray.
- Battery sled.
- Armor panel.

## Important design note

OpenSCAD use imports modules and functions, but it does not import top-level variable assignments from used files. The Alpha v0.1 assembly currently restates imported-part globals for compatibility.

Future cleanup target:

- Convert part modules to accept explicit parameters.
- Keep constants in mechanical/lib/hound_constants.scad.
- Reduce hidden global-variable dependencies.
