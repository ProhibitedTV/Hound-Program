/*
Hound Program // Fastener Tolerance Gauge v0.1

Print this before committing to hole sizes across the project.
Measures real fit for M2, M2.5, M3, M4, and heat-set insert sockets.

PART options:
- gauge
- assembly
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

$fn = 48;
PART = "assembly";

GAUGE_L = 118;
GAUGE_W = 44;
GAUGE_H = 8;

module label(txt, x, y) {
    translate([x,y,GAUGE_H/2+0.2]) linear_extrude(height=0.6)
        text(txt, size=4, halign="center", valign="center", font="Liberation Sans:style=Bold");
}

module gauge() {
    difference() {
        hp_rounded_box([GAUGE_L,GAUGE_W,GAUGE_H], r=3);

        // clearance holes
        translate([-48,8,0]) cylinder(h=GAUGE_H+4,d=M2_CLEARANCE,center=true);
        translate([-28,8,0]) cylinder(h=GAUGE_H+4,d=M25_CLEARANCE,center=true);
        translate([-8,8,0]) cylinder(h=GAUGE_H+4,d=M3_CLEARANCE,center=true);
        translate([14,8,0]) cylinder(h=GAUGE_H+4,d=M4_CLEARANCE,center=true);

        // insert socket tests
        translate([-34,-14,0]) cylinder(h=GAUGE_H+4,d=M2_INSERT_D,center=true);
        translate([-8,-14,0]) cylinder(h=GAUGE_H+4,d=M3_INSERT_D,center=true);
        translate([22,-14,0]) cylinder(h=GAUGE_H+4,d=M4_INSERT_D,center=true);
    }

    label("M2",-48,18);
    label("M2.5",-28,18);
    label("M3",-8,18);
    label("M4",14,18);
    label("I2",-34,-26);
    label("I3",-8,-26);
    label("I4",22,-26);
    translate([48,-14,GAUGE_H/2+0.2]) hp_revision_tag("GAUGE-A1", size=3.3);
}

module assembly() { gauge(); }

if (PART == "gauge") gauge();
else assembly();
