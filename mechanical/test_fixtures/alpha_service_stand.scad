/*
Hound Program // Alpha Service Stand v0.1

Simple bench stand to hold Alpha belly-up or body-level during wiring, calibration,
and foot/leg work. This is a fixture, not part of the robot.

PART options:
- left_cradle
- right_cradle
- crossbar_mock
- assembly
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

$fn = 48;
PART = "assembly";

CRADLE_W = 84;
CRADLE_D = 36;
CRADLE_H = 74;
BODY_RADIUS = 48;
CROSSBAR_D = 12;

module cradle(side="left") {
    difference() {
        union() {
            hp_rounded_box([CRADLE_D,CRADLE_W,8], r=3);
            translate([0,0,CRADLE_H/2]) hp_rounded_box([CRADLE_D,12,CRADLE_H], r=3);
            translate([0,-CRADLE_W/2+8,CRADLE_H/2]) hp_rounded_box([CRADLE_D,12,CRADLE_H], r=3);
            translate([0, CRADLE_W/2-8,CRADLE_H/2]) hp_rounded_box([CRADLE_D,12,CRADLE_H], r=3);
            translate([0,0,CRADLE_H]) hp_rounded_box([CRADLE_D,CRADLE_W,14], r=4);
        }
        // body saddle
        translate([0,0,CRADLE_H+18]) rotate([0,90,0]) cylinder(h=CRADLE_D+6,d=BODY_RADIUS*2,center=true);
        // crossbar sockets
        for (z=[22,48]) translate([0,0,z]) rotate([0,90,0]) cylinder(h=CRADLE_D+8,d=CROSSBAR_D+0.5,center=true);
        // bench screw holes
        for (y=[-CRADLE_W/2+12,CRADLE_W/2-12]) translate([0,y,0]) cylinder(h=18,d=M4_CLEARANCE,center=true);
    }
    translate([0,0,5]) hp_revision_tag(side == "left" ? "STAND-L-A1" : "STAND-R-A1", size=3);
}

module crossbar_mock() {
    color([0.04,0.04,0.04]) rotate([0,90,0]) cylinder(h=180,d=CROSSBAR_D,center=true);
}

module assembly() {
    translate([-90,0,0]) cradle("left");
    translate([90,0,0]) mirror([1,0,0]) cradle("right");
    translate([0,0,22]) crossbar_mock();
    translate([0,0,48]) crossbar_mock();
}

if (PART == "left_cradle") cradle("left");
else if (PART == "right_cradle") mirror([1,0,0]) cradle("right");
else if (PART == "crossbar_mock") crossbar_mock();
else assembly();
