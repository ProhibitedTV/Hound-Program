/*
Hound Program // Carbon Fiber Tube Clamp v0.1

Printable split clamp for tube-based frame experiments.
Use with PLA+/Tough PLA first. Do not overtighten.
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

PART = "assembly"; // clamp_half, clamp_pair, tube_mock, assembly
TUBE_OD = CF_TUBE_12_OD;
CLAMP_LEN = 34;
CLAMP_W = 30;
CLAMP_H = 22;

module tube_mock() {
    color([0.05,0.05,0.05]) rotate([0,90,0]) cylinder(h=CLAMP_LEN+16, d=TUBE_OD, center=true);
}

module clamp_half(top=true) {
    zsign = top ? 1 : -1;
    difference() {
        translate([0,0,zsign*CLAMP_H/4]) hp_rounded_box([CLAMP_LEN, CLAMP_W, CLAMP_H/2], r=2);
        rotate([0,90,0]) cylinder(h=CLAMP_LEN+2, d=TUBE_OD+CF_TUBE_CLEARANCE, center=true);
        // split face flattening
        translate([0,0,-zsign*CLAMP_H/2]) cube([CLAMP_LEN+4, CLAMP_W+4, CLAMP_H], center=true);
        // clamp bolts
        for (y=[-CLAMP_W/2+6, CLAMP_W/2-6])
            translate([0,y,zsign*CLAMP_H/4]) rotate([90,0,0]) cylinder(h=CLAMP_W+6, d=M3_CLEARANCE, center=true);
        // external mounting holes on outer face
        for (x=[-10,10])
            translate([x,0,zsign*(CLAMP_H/2-2)]) cylinder(h=8, d=M3_CLEARANCE, center=true);
    }
    translate([0,0,zsign*(CLAMP_H/2+0.3)]) hp_revision_tag(top ? "TC12-T" : "TC12-B", size=3);
}

module clamp_pair() {
    clamp_half(true);
    clamp_half(false);
}

module assembly() {
    clamp_pair();
    tube_mock();
}

if (PART == "clamp_half") clamp_half(true);
else if (PART == "clamp_pair") clamp_pair();
else if (PART == "tube_mock") tube_mock();
else assembly();
