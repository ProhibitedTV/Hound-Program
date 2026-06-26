/*
Hound Alpha v1.0 functional assembly scaffold.

This file assembles the first functional subassemblies:
- frame core
- split shell panel stand-ins
- one-leg modules
- Type A hoof modules

It is not a final robot. It is a layout scaffold for deciding what to print first.

PART options:
- assembly
- frame
- panels
- legs
- hooves
- print_layout
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>
include <../lib/hound_hardware_envelopes.scad>

use <alpha_frame_core.scad>
use <alpha_shell_panels.scad>
use <alpha_leg_module.scad>
use <alpha_hoof_type_a.scad>

$fn = 36;
PART = "assembly";

BODY_Z = 86;
FRONT_X = 102;
REAR_X = -96;
HIP_Y = 57;

module frame_view() {
    translate([0,0,BODY_Z-32]) assembly();
}

module panel_view() {
    // Approximate placement only; individual panels are the printable source of truth.
    color(BODY_BLACK) {
        translate([-84,0,BODY_Z+30]) rotate([0,-12,0]) rear_dorsal();
        translate([12,0,BODY_Z+32]) rotate([0,-10,0]) mid_dorsal();
        translate([104,0,BODY_Z+24]) rotate([0,-8,0]) front_wedge();
    }
    color(ARMOR_DARK) for (side=[-1,1]) {
        translate([-90,side*43,BODY_Z+0]) rotate([0,0,side*3]) side_rear();
        translate([-8,side*47,BODY_Z+4]) rotate([0,0,side*1]) side_mid();
        translate([82,side*42,BODY_Z+1]) rotate([0,0,side*-7]) side_front();
        translate([-10,side*38,BODY_Z-15]) skirt();
    }
    color(SENSOR_RED) {
        translate([136,-24,BODY_Z+13]) rotate([0,-17,-13]) sensor_carrier();
        translate([136, 24,BODY_Z+13]) rotate([0,-17, 13]) sensor_carrier();
    }
}

module leg_view() {
    for (side=[-1,1]) {
        translate([FRONT_X,side*HIP_Y,0]) rotate([0,0,side*3]) one_side(true);
        translate([REAR_X,side*HIP_Y,0]) rotate([0,0,side*-3]) one_side(false);
    }
}

module hoof_view() {
    for (side=[-1,1]) {
        translate([FRONT_X-24,side*(HIP_Y+18),1]) rotate([0,0,side*8]) hoof_core();
        translate([REAR_X+24,side*(HIP_Y+18),1]) rotate([0,0,side*8]) hoof_core();
    }
}

module print_layout() {
    translate([-140,80,0]) spine_plate();
    translate([40,80,0]) panels();
    translate([-120,-45,0]) one_side(true);
    translate([40,-45,0]) hoof_core();
    translate([120,-45,0]) adapter_plate();
}

module assembly_full() {
    frame_view();
    leg_view();
    panel_view();
}

if (PART == "frame") frame_view();
else if (PART == "panels") panel_view();
else if (PART == "legs") leg_view();
else if (PART == "hooves") hoof_view();
else if (PART == "print_layout") print_layout();
else assembly_full();
