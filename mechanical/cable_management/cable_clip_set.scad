/*
Hound Program // Cable Clip Set v0.1

Small printable cable clips for routing servo leads and sensor wiring.
These are intentionally cheap, replaceable, and boring.

PART options:
- clip_4mm
- clip_6mm
- clip_8mm
- pass_through
- layout
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

$fn = 40;
PART = "layout";

module cable_clip(channel_d=6, label="CLIP") {
    difference() {
        union() {
            hp_rounded_box([28,18,8], r=2);
            translate([0,0,6]) rotate([90,0,0]) cylinder(h=18,d=channel_d+7,center=true);
        }
        translate([0,0,6]) rotate([90,0,0]) cylinder(h=22,d=channel_d,center=true);
        // snap opening
        translate([0,0,10]) cube([channel_d*0.7,24,10],center=true);
        // mounting hole
        translate([0,0,-1]) cylinder(h=12,d=M3_CLEARANCE,center=true);
    }
    translate([0,-11,4.4]) rotate([90,0,0]) hp_revision_tag(label, size=2.6, height=0.5);
}

module pass_through() {
    difference() {
        hp_rounded_box([36,24,8], r=3);
        translate([0,0,0]) hp_rounded_box([22,10,12], r=2);
        for (x=[-12,12]) translate([x,0,0]) cylinder(h=12,d=M3_CLEARANCE,center=true);
    }
    translate([0,-14,4.4]) rotate([90,0,0]) hp_revision_tag("WIRE-PASS-A1", size=2.4, height=0.5);
}

module layout() {
    translate([-45,0,0]) cable_clip(4,"CLIP-4");
    translate([0,0,0]) cable_clip(6,"CLIP-6");
    translate([45,0,0]) cable_clip(8,"CLIP-8");
    translate([0,-38,0]) pass_through();
}

if (PART == "clip_4mm") cable_clip(4,"CLIP-4");
else if (PART == "clip_6mm") cable_clip(6,"CLIP-6");
else if (PART == "clip_8mm") cable_clip(8,"CLIP-8");
else if (PART == "pass_through") pass_through();
else layout();
