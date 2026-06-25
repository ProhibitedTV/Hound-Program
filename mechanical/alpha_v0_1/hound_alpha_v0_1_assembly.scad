/*
Hound Program // Alpha v0.1 Assembly

This is a sanity-check assembly for the current OpenSCAD parts.
It uses `use` so imported part files do not run their own PART selectors.
It is not final chassis geometry. Real hardware dimensions must replace these assumptions.
*/

use <../frame/alpha_spine_plate.scad>
use <../mounts/tube_clamp.scad>
use <../mounts/servo_mount_standard.scad>
use <../feet/alien-hoof-type-a/hound_alien_hoof.scad>
use <../heads/alpha/hound_alpha_head_v02.scad>
use <../electronics_mounts/controller_tray.scad>
use <../power/battery_sled.scad>
use <../armor/armor_plate_family.scad>

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

$fn = 48;
PART = "assembly"; // assembly, bare, exploded, print_layout

BODY_Z = 92;
LEG_X = 78;
LEG_Y = 66;
HIP_Z = 72;
HEAD_X = 128;
HEAD_Z = 122;

module body_core() {
    color(BODY_BLACK) translate([0,0,BODY_Z]) spine_plate();
    color(MECHANICAL_DARK) translate([-28,0,BODY_Z+18]) controller_tray();
    color(MECHANICAL_DARK) translate([36,0,BODY_Z+25]) battery_sled();
}

module rail_visuals() {
    for (y=[-28,28])
        color([0.02,0.02,0.02]) translate([0,y,BODY_Z+10]) rotate([0,90,0]) cylinder(h=250,d=CF_TUBE_12_OD,center=true);
}

module leg_station(xsign=1, ysign=1) {
    x = xsign * LEG_X;
    y = ysign * LEG_Y;
    side = ysign;
    hip = [x,y,HIP_Z+18];
    knee = [x + (xsign>0 ? -18 : 18), y + side*8, HIP_Z-38];
    foot = [x + (xsign>0 ? -26 : 26), y + side*10, 10];

    color(MECHANICAL_DARK) translate([x,y,HIP_Z]) rotate([0,0,yside_rotation(ysign)]) standard_servo_mount();
    color(MECHANICAL_DARK) translate([x,y*0.92,HIP_Z+28]) rotate([90,0,0]) clamp_pair();

    color([0.08,0.08,0.08]) hull(){ translate(hip) sphere(d=10); translate(knee) sphere(d=9); }
    color([0.08,0.08,0.08]) hull(){ translate(knee) sphere(d=9); translate(foot) sphere(d=8); }
    color(BODY_BLACK) translate(foot) rotate([0,0, side*8]) foot_core();
}

function yside_rotation(ysign) = ysign < 0 ? 180 : 0;

module head_station() {
    color(BODY_BLACK) translate([HEAD_X,0,HEAD_Z]) upper_shell();
    color(BODY_BLACK) translate([HEAD_X,0,HEAD_Z]) lower_mandible();
    color(MECHANICAL_DARK) translate([HEAD_X-90,0,HEAD_Z-18]) neck_adapter();
}

module armor_preview() {
    for (x=[-80,-40,0,40,80])
        color(ARMOR_DARK) translate([x,0,BODY_Z+54]) medium_panel();
}

module bare() {
    body_core();
    rail_visuals();
    for (xs=[-1,1]) for (ys=[-1,1]) leg_station(xs,ys);
}

module assembly() {
    bare();
    head_station();
    armor_preview();
}

module exploded() {
    bare();
    translate([0,0,80]) head_station();
    translate([0,0,125]) armor_preview();
}

module print_layout() {
    translate([-120,60,0]) foot_core();
    translate([-40,60,0]) standard_servo_mount();
    translate([60,60,0]) clamp_pair();
    translate([-110,-35,0]) controller_tray();
    translate([20,-35,0]) battery_sled();
    translate([125,-35,0]) medium_panel();
}

if (PART == "assembly") assembly();
else if (PART == "bare") bare();
else if (PART == "exploded") exploded();
else if (PART == "print_layout") print_layout();
else assembly();
