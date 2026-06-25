# Hound Program

A modular robotics platform for building a fleet of AI-enabled quadruped hounds with a coherent alien-machine design language.

## Mission

Build a fleet of repairable, modular, 3D-printable, AI-enabled quadrupeds that feel less like ordinary robot dogs and more like an alien mechanical species.

The first unit is **Hound Alpha**.

## Core Principles

1. **Alpha first. Fleet always in mind.**
2. **Function before terror.** The chassis must walk before the shell becomes elaborate.
3. **Boring internals, wild exterior.** Reliable hardware underneath, alien animal aesthetic outside.
4. **Everything is a field replaceable unit.** Feet, armor plates, shoulders, mounts, and electronics should be easy to swap.
5. **Avoid one-off hero parts.** Design parts that can be reprinted, repaired, and cloned for Bravo, Charlie, Delta, and beyond.
6. **Document every revision.** The engineering history matters.

## Initial Architecture

- Printed structural and cosmetic components using PLA+/Tough PLA where practical.
- Carbon fiber or metal members for load paths where printed plastic is a poor choice.
- Decent digital servos, not lowest-cost junk servos.
- Modular feet and armor panels.
- Local-first intelligence using homelab infrastructure where possible.
- Physical design language: alien animal, spacecraft skull, sensor slits, expressive armor plates.

## Repository Layout

```text
mechanical/      CAD, OpenSCAD, printable parts, revision notes
electronics/     power, wiring, controllers, sensors, connectors
firmware/        servo control, gait logic, safety, telemetry
houndos/         voice, personality, memory, fleet coordination
docs/            design rules, BOMs, engineering logs, test reports
fleet/           per-unit notes for Alpha, Bravo, Charlie, etc.
```

## Current Phase

**Phase 0: Definition and Alpha prototypes**

- Define hardware choices.
- Prototype Alien Hoof Type A foot module.
- Iterate Hound Alpha head shell.
- Build initial BOM.
- Keep the locomotion platform boring and reliable.
