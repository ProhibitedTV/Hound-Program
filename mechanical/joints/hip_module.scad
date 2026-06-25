/*
Hound Program // Hip Module v0.1

Replaceable hip/shoulder module concept for standard servo fit testing.
The goal is serviceability: remove one module instead of rebuilding the body.

PART options:
- module_body
- servo_mock
- bearing_mock
- assembly
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

$fn = 48;
PART = "assembly";

MODULE_L = 74;
MODULE_W = 44;
MODULE_H = 48;
OUTPUT_D = 18;
BEARING_OD = 16;
BEARING_ID = 5;

module servo_mock() {
    color([0.1,0.1,0.1]) hp_rounded_box([STD_SERVO_W, STD_SERVO_D, STD_SERVO_H], r=1.2);
    color([0.16,0.16,0.16]) translate([0,0,STD_SERVO_H/2+2]) cylinder(d=STD_SERVO_SPLINE_D, h=4, center=true);
}

module bearing_mock() {
    color([0.45,0.45,0.45]) difference() {
        cylinder(h=5, d=BEARING_OD, center=true);
        cylinder(h=7, d=BEARING_ID, center=true);
    }
}

module module_body() {
    difference() {
        union() {
            hp_rounded_box([MODULE_L,MODULE_W,MODULE_H], r=4);
            translate([MODULE_L/2-8,0,0]) rotate([90,0,0]) cylinder(h=MODULE_W+8, d=OUTPUT_D+8, center=true);
            for (x=[-MODULE_L/2+10, MODULE_L/2-10])
            for (z=[-MODULE_H/2+8, MODULE_H/2-8])
                translate([x,-MODULE_W/2-4,z]) hp_rounded_box([14,8,12], r=2);
        }

        translate([-8,0,0]) hp_rounded_box([STD_SERVO_W+1.0, STD_SERVO_D+1.0, STD_SERVO_H+1.0], r=1.4);

        translate([MODULE_L/2-8,0,0]) rotate([90,0,0]) cylinder(h=MODULE_W+14, d=BEARING_OD+0.35, center=true);
        translate([MODULE_L/2-8,0,0]) rotate([90,0,0]) cylinder(h=MODULE_W+18, d=BEARING_ID+1.0, center=true);

        for (x=[-MODULE_L/2+10, MODULE_L/2-10])
        for (z=[-MODULE_H/2+8, MODULE_H/2-8])
            translate([x,-MODULE_W/2-4,z]) rotate([90,0,0]) cylinder(h=16,d=M3_CLEARANCE,center=true);

        translate([-MODULE_L/2,0,-MODULE_H/2+12]) cube([18,18,12], center=true);
        translate([0,MODULE_W/2,0]) hp_rounded_box([46,12,28], r=3);
    }
    translate([0,-MODULE_W/2-8,-MODULE_H/2+5]) rotate([90,0,0]) hp_revision_tag("HIP-MOD-A1", size=3.2);
}

module assembly() {
    module_body();
    translate([-8,0,0]) servo_mock();
    translate([MODULE_L/2-8,-MODULE_W/2-3,0]) rotate([90,0,0]) bearing_mock();
    translate([MODULE_L/2-8, MODULE_W/2+3,0]) rotate([90,0,0]) bearing_mock();
}

if (PART == "module_body") module_body();
else if (PART == "servo_mock") servo_mock();
else if (PART == "bearing_mock") bearing_mock();
else assembly();
