/*
Hound Program // Audio Grille Module v0.1

Small serviceable grille panel for audio hardware fit tests.
Designed as a removable panel, not a structural part.

PART options:
- grille
- round_mock
- assembly
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

$fn = 48;
PART = "assembly";

GRILLE_W = 54;
GRILLE_H = 38;
GRILLE_T = 4;
ROUND_D = 32;

module round_mock() {
    color([0.02,0.02,0.02]) cylinder(h=9,d=ROUND_D,center=true);
    color([0.12,0.12,0.12]) translate([0,0,5]) cylinder(h=2,d=ROUND_D-5,center=true);
}

module slot_cuts() {
    for (x=[-18,-9,0,9,18])
        translate([x,0,0]) hp_rounded_box([4,GRILLE_H-12,GRILLE_T+4], r=1.4);
}

module grille() {
    difference() {
        union() {
            hp_rounded_box([GRILLE_W,GRILLE_H,GRILLE_T], r=3);
            for (x=[-GRILLE_W/2+7, GRILLE_W/2-7])
            for (y=[-GRILLE_H/2+7, GRILLE_H/2-7])
                translate([x,y,-2]) cylinder(h=4,d=7,center=true);
        }
        slot_cuts();
        for (x=[-GRILLE_W/2+7, GRILLE_W/2-7])
        for (y=[-GRILLE_H/2+7, GRILLE_H/2-7])
            translate([x,y,0]) cylinder(h=10,d=M3_CLEARANCE,center=true);
        translate([0,0,-1]) cylinder(h=GRILLE_T+4,d=ROUND_D-3,center=true);
    }
    translate([0,-GRILLE_H/2-3,GRILLE_T/2+0.3]) hp_revision_tag("AUD-GRL-A1", size=3);
}

module assembly() {
    grille();
    translate([0,0,-8]) round_mock();
}

if (PART == "grille") grille();
else if (PART == "round_mock") round_mock();
else assembly();
