/*
Hound Program // Bench Control Panel Mount v0.1

Physical panel concept for a large accessible bench control on early prototypes.
Every moving prototype should have an obvious hardware control path.

PART options:
- panel
- button_mock
- assembly
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

$fn = 48;
PART = "assembly";

PANEL_W = 72;
PANEL_H = 54;
PANEL_T = 5;
BUTTON_D = 22;

module button_mock() {
    color([0.8,0.02,0.02]) cylinder(h=16,d=BUTTON_D,center=true);
    color([0.15,0.15,0.15]) translate([0,0,-10]) cylinder(h=12,d=BUTTON_D+5,center=true);
}

module panel() {
    difference() {
        union() {
            hp_rounded_box([PANEL_W,PANEL_H,PANEL_T], r=4);
            translate([0,0,-4]) hp_rounded_box([PANEL_W-16,PANEL_H-16,8], r=3);
        }
        cylinder(h=20,d=BUTTON_D+0.6,center=true);
        for (x=[-PANEL_W/2+9,PANEL_W/2-9])
        for (y=[-PANEL_H/2+9,PANEL_H/2-9])
            translate([x,y,0]) cylinder(h=14,d=M3_CLEARANCE,center=true);
    }
    translate([0,-PANEL_H/2-4,PANEL_T/2+0.2]) hp_revision_tag("CTRL-PANEL-A1", size=3);
}

module assembly() {
    panel();
    translate([0,0,9]) button_mock();
}

if (PART == "panel") panel();
else if (PART == "button_mock") button_mock();
else assembly();
