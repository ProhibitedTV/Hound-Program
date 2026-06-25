/*
Hound Program // LED Diffuser Modules v0.1

Diffuser and channel geometry for red status slits and body accent lines.
Use translucent filament for diffusers and opaque filament for carriers.

PART options:
- straight_channel
- curved_slit_mock
- diffuser_insert
- layout
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

$fn = 48;
PART = "layout";

CHANNEL_L = 86;
CHANNEL_W = 12;
CHANNEL_H = 8;
DIFF_W = 4.2;
DIFF_H = 3.2;

module diffuser_insert(len=78) {
    color(SENSOR_RED) hp_rounded_box([len,DIFF_W,DIFF_H], r=1.2);
}

module straight_channel() {
    difference() {
        union() {
            hp_rounded_box([CHANNEL_L,CHANNEL_W,CHANNEL_H], r=2);
            for (x=[-CHANNEL_L/2+8, CHANNEL_L/2-8])
                translate([x,0,-2]) cylinder(h=4,d=7,center=true);
        }
        translate([0,0,1]) hp_rounded_box([CHANNEL_L-10,DIFF_W+0.4,DIFF_H+0.4], r=1.2);
        for (x=[-CHANNEL_L/2+8, CHANNEL_L/2-8])
            translate([x,0,-2]) cylinder(h=12,d=M3_CLEARANCE,center=true);
        translate([0,0,-2]) cube([CHANNEL_L-16,4,5], center=true);
    }
    translate([0,-CHANNEL_W/2-3,CHANNEL_H/2+0.2]) hp_revision_tag("LED-CH-A1", size=2.8);
}

module curved_slit_mock() {
    // Three short channels arranged into an alien sensor slash.
    rotate([0,0,-12]) translate([-24,0,0]) straight_channel();
    rotate([0,0,0]) straight_channel();
    rotate([0,0,12]) translate([24,0,0]) straight_channel();
}

module layout() {
    translate([0,30,0]) straight_channel();
    translate([0,30,8]) diffuser_insert();
    translate([0,-30,0]) curved_slit_mock();
}

if (PART == "straight_channel") straight_channel();
else if (PART == "curved_slit_mock") curved_slit_mock();
else if (PART == "diffuser_insert") diffuser_insert();
else layout();
