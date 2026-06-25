/*
Hound Program // Battery Sled v0.1

Generic battery sled for early layout. Dimensions are intentionally adjustable
until the battery standard is selected.
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

PART = "assembly"; // sled, battery_mock, strap_clip, assembly

BAT_L = 106;
BAT_W = 35;
BAT_H = 28;
SLED_WALL = 3;

module battery_mock() {
    color([0.18,0.18,0.20]) hp_rounded_box([BAT_L,BAT_W,BAT_H], r=3);
    color([0.9,0.55,0.05]) translate([BAT_L/2+4,0,3]) hp_rounded_box([8,14,8], r=1.5);
}

module strap_clip() {
    difference() {
        hp_rounded_box([22,12,10], r=2);
        translate([0,0,0]) cube([16,5,14], center=true);
        translate([0,0,-2]) cylinder(h=14,d=M3_CLEARANCE,center=true);
    }
}

module battery_sled() {
    difference() {
        union() {
            hp_rounded_box([BAT_L+SLED_WALL*2, BAT_W+SLED_WALL*2, 6], r=4);
            translate([0,-BAT_W/2-SLED_WALL/2, BAT_H/2]) hp_rounded_box([BAT_L+SLED_WALL*2, SLED_WALL, BAT_H], r=1.5);
            translate([0, BAT_W/2+SLED_WALL/2, BAT_H/2]) hp_rounded_box([BAT_L+SLED_WALL*2, SLED_WALL, BAT_H], r=1.5);
            translate([-BAT_L/2-SLED_WALL/2,0,BAT_H/2]) hp_rounded_box([SLED_WALL, BAT_W+SLED_WALL*2, BAT_H], r=1.5);
            for(x=[-BAT_L/4, BAT_L/4])
            for(y=[-BAT_W/2-9, BAT_W/2+9])
                translate([x,y,9]) strap_clip();
        }
        // Battery cavity relief
        translate([0,0,BAT_H/2+5]) hp_rounded_box([BAT_L+0.8, BAT_W+0.8, BAT_H+10], r=3);
        // Mounting slots
        for(x=[-42,0,42]) translate([x,0,0]) hp_countersunk_m3(depth=16);
        // Cable exit
        translate([BAT_L/2+1,0,10]) cube([12,20,14], center=true);
        // Bottom lightening
        hp_hex_lightening_grid(width=BAT_L-18, height=BAT_W-6, hole_d=9, spacing=15, cut_depth=12);
    }
    translate([0,-BAT_W/2-7,3.5]) hp_revision_tag("BAT-SLED-A1", size=3.2);
}

module assembly() {
    battery_sled();
    translate([0,0,20]) battery_mock();
}

if(PART=="sled") battery_sled();
else if(PART=="battery_mock") battery_mock();
else if(PART=="strap_clip") strap_clip();
else assembly();
