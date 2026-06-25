# Alpha Baseline BOM

This is a planning BOM, not a purchase order. Exact parts should be selected after the printable geometry and load assumptions settle.

## Mechanical

| Item | Qty | Notes |
|---|---:|---|
| PLA+ / Tough PLA | TBD | Baseline printed material |
| M2 screw assortment | 1 | Small sensor and electronics modules |
| M2.5 screw assortment | 1 | Optional board mounting |
| M3 screw assortment | 1 | Main printed-part fasteners |
| M4 screw assortment | 1 | Larger pivots and structural brackets |
| M3 heat-set inserts | 50+ | Main printed-part inserts |
| M4 heat-set inserts | 20+ | Larger structural interfaces if validated |
| Washers | TBD | Use under screw heads where plastic is loaded |
| Locknuts | TBD | Use where joints may vibrate loose |
| 10 mm carbon tube | TBD | Candidate lower-load leg links |
| 12 mm carbon tube | TBD | Candidate spine or heavier links |
| Bearings / bushings | TBD | Joint experiments |
| Rubberized coating | TBD | Hoof traction coating test |

## Electronics

| Item | Qty | Notes |
|---|---:|---|
| Main controller | 1 | TBD after software stack selection |
| Servo controller | 1 | Needed if many PWM servos are used |
| Servos / actuators | 12+ | Exact torque and size TBD |
| Battery | 1+ | Must be selected around current draw and runtime |
| Power distribution board | 1 | Fused outputs preferred |
| Main switch | 1 | Physical power control |
| Bench control button | 1 | For early testing |
| Camera or sensor module | 1+ | Sensor pod fit test |
| Distance sensor | 1+ | Optional front sensor slot |
| LEDs / diffuser material | TBD | Status slit and accent lighting |
| Small audio module | 1 | Optional voice/noise experiments |
| Wire, connectors, ferrules | TBD | Serviceable wiring matters |

## Tools and shop supplies

| Item | Qty | Notes |
|---|---:|---|
| Heat-set insert tool/tip | 1 | Required before threaded insert parts |
| Calipers | 1 | Required for tolerance work |
| Threadlocker | 1 | Use where appropriate; avoid plastic damage |
| Sandpaper/files | 1 | Fit cleanup |
| Soldering supplies | 1 | Electronics assembly |
| Label maker or tags | 1 | Wire and prototype revision labels |

## BOM discipline

Do not buy the final actuator stack until:

- leg geometry is visually acceptable
- joint envelope is known
- approximate robot mass is estimated
- target stance height is selected
- torque requirement is calculated with margin
- power distribution plan is chosen
