/*
Hound Program // Alpha Side Panel Set v0.1

Non-structural body side panels for the first recognizable Alpha silhouette.
These panels hide wiring and make the body read as one alien machine while
remaining removable for service.

PART options:
- left_panel
- right_panel
- top_panel
- layout
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

$fn = 48;
PART = "layout";

PANEL_L = 156;
PANEL_H = 42;
PANEL_T = 4;
MOUNT_SPACING_X = 112;
MOUNT_SPACING_Z = 24;

module side_panel(side=1) {
    mirror([0, side < 0 ? 1 : 0, 0])
    difference() {
        union() {
            hull() {
                translate([-PANEL_L/2+10,0,-PANEL_H/2+6]) hp_rounded_box([22,PANEL_T,14], r=2);
                translate([ PANEL_L/2-18,0,-PANEL_H/2+2]) hp_rounded_box([30,PANEL_T,18], r=2);
                translate([ PANEL_L/2-30,0, PANEL_H/2-8]) hp_rounded_box([40,PANEL_T,18], r=2);
                translate([-PANEL_L/2+26,0, PANEL_H/2-4]) hp_rounded_box([36,PANEL_T,14], r=2);
            }
            // external armor ribs
            for (x=[-52,-18,18,52])
                translate([x,-PANEL_T/2-1,4]) rotate([0,0,0]) hp_rounded_box([24,3,7], r=1.2);
        }
        // mount holes
        for (x=[-MOUNT_SPACING_X/2,MOUNT_SPACING_X/2])
        for (z=[-MOUNT_SPACING_Z/2,MOUNT_SPACING_Z/2])
            translate([x,0,z]) rotate([90,0,0]) cylinder(h=12,d=M3_CLEARANCE,center=true);
        // vent/sensor-looking slashes
        for (x=[-36,-18,0,18,36])
            translate([x,-PANEL_T/2-2,-10]) rotate([0,20,0]) hp_rounded_box([4,8,18], r=1);
    }
}

module top_panel() {
    difference() {
        union() {
            hp_rounded_box([132,58,5], r=4);
            for (x=[-48,-24,0,24,48])
                translate([x,0,6]) hp_armor_scale(len=22,w=14,h=3,r=1.2);
        }
        for (x=[-52,52]) for (y=[-20,20])
            translate([x,y,0]) hp_countersunk_m3(depth=16);
        hp_hex_lightening_grid(width=92,height=34,hole_d=8,spacing=14,cut_depth=10);
    }
    translate([0,-31,3]) hp_revision_tag("TOP-PANEL-A1", size=3.2);
}

module layout() {
    translate([0,32,0]) side_panel(1);
    translate([0,-32,0]) side_panel(-1);
    translate([0,-92,0]) top_panel();
}

if (PART == "left_panel") side_panel(1);
else if (PART == "right_panel") side_panel(-1);
else if (PART == "top_panel") top_panel();
else layout();
