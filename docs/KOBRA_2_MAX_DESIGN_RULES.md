# Kobra 2 Max Design Rules

These rules keep Hound Alpha moving from OpenSCAD concept art toward parts that can be printed, assembled, inspected, and revised.

## Phase boundary

Current phase: concept CAD until the silhouette is worth printing.

Next phase: printable CAD with part splits, tolerances, fasteners, service access, and test coupons.

A good full assembly render is not the same thing as a printable robot.

## Material assumptions

Default project material:

- PLA+ / Tough PLA

PETG is not the baseline material for this workflow.

## Printability rules

- Avoid unsupported 90 degree overhangs.
- Prefer 45 degree chamfers over horizontal undersides.
- Split large shells into printable panels.
- Prefer flat-back panels and bolt-on cowls over monolithic shells.
- Use bosses, ribs, and gussets instead of thick solid blocks.
- Keep screw holes reachable with normal tools.
- Keep service panels removable.
- Decorative armor is not structure.

## Tolerance starting points

Starting values only. Validate with printed coupons.

- M2 clearance: 2.4 mm
- M2.5 clearance: 2.9 mm
- M3 clearance: 3.4 mm
- M4 clearance: 4.5 mm
- General slip fit: nominal plus 0.25 to 0.40 mm
- Printed pivot clearance: nominal plus 0.40 to 0.70 mm
- Coated foot allowance: 1.0 to 1.5 mm for rubberized coating buildup

## Wall and boss rules

- Cosmetic shell wall: 2.4 to 3.2 mm
- Structural brackets: 4+ walls minimum
- Screw boss outside diameter: at least 2.5x screw diameter
- M3 boss OD target: 8 to 12 mm depending on load
- M4 boss OD target: 12 to 16 mm depending on load
- Add ribs from bosses into the parent part.
- Do not put screws into thin unsupported walls.

## Leg rules

- Hip and shoulder modules should tuck under the body but remain serviceable.
- Each leg needs a clear mechanical chain: hip, upper link, knee, lower link, ankle/pastern, hoof.
- The ankle/pastern may be fixed or passive in Alpha.
- Hooves are consumables and should be easy to replace.
- Body panels must not block leg travel.
- Leave room for wires, servo horns, fasteners, and tools.

## First print candidates

Do not print the whole robot first.

First useful prints:

1. Fastener tolerance gauge.
2. Foot coating coupon.
3. Hoof v0.2 core.
4. Ankle/pastern plus hoof interface mock.
5. One leg visual/mechanical mock.
6. One body panel section.
7. One hip-module shell with servo dummy.

## Print-readiness gate

A part is not print-ready until it has:

- declared material
- print orientation
- support expectation
- wall count and infill target
- critical dimensions
- fastener list
- service/access notes
- expected weak area
- matching test coupon if tolerances matter
