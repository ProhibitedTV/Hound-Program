/*
Hound Program // Controller Tray v0.1

Generic electronics tray for microcontroller and servo controller mockups.
This is intentionally generic until board choices are locked.
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

PART = "assembly"; // tray, board_mock, assembly

TRAY_L = 92;
TRAY_W = 68;
TRAY_H = 8;

module board_mock() {
    color([0.05,0.25,0.08]) hp_rounded_box([72,52,2], r=2);
    color([0.02,0.02,0.02]) translate([18,0,3]) hp_rounded_box([18,18,4], r=1);
    color([0.8,0.8,0.8]) translate([-28,20,4]) hp_rounded_box([12,8,5], r=1);
}

module controller_tray() {
    difference() {
        union() {
            hp_rounded_box([TRAY_L,TRAY_W,TRAY_H], r=3);
            for(x=[-34,34]) for(y=[-24,24])
                translate([x,y,TRAY_H/2+3]) cylinder(h=6,d=8,center=true);
            translate([0,-TRAY_W/2+4,TRAY_H/2+5]) hp_rounded_box([TRAY_L-12,4,10],r=1.5);
            translate([0, TRAY_W/2-4,TRAY_H/2+5]) hp_rounded_box([TRAY_L-12,4,10],r=1.5);
        }
        for(x=[-34,34]) for(y=[-24,24])
            translate([x,y,TRAY_H/2+3]) cylinder(h=14,d=M3_CLEARANCE,center=true);
        for(x=[-32,0,32])
            translate([x,0,0]) hp_countersunk_m3(depth=18);
        hp_hex_lightening_grid(width=TRAY_L-24, height=TRAY_W-22, hole_d=8, spacing=14, cut_depth=TRAY_H+10);
        translate([0,-TRAY_W/2,TRAY_H/2]) cube([52,12,8], center=true);
        translate([0, TRAY_W/2,TRAY_H/2]) cube([52,12,8], center=true);
    }
    translate([0,0,TRAY_H/2+0.3]) hp_revision_tag("CTRL-TRAY-A1", size=3.4);
}

module assembly() {
    controller_tray();
    translate([0,0,14]) board_mock();
}

if(PART=="tray") controller_tray();
else if(PART=="board_mock") board_mock();
else assembly();
