/*
Hound Program // Modular Leg Link Set v0.1

Early printable leg-link geometry for layout, fit, and load-path experiments.
These are not final kinematics. The purpose is to define serviceable link modules
that can later wrap carbon fiber tubes or flat printed struts.

PART options:
- upper_link
- lower_link
- tube_link
- link_end
- assembly
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

$fn = 48;
PART = "assembly";

UPPER_LEN = 72;
LOWER_LEN = 82;
LINK_W = 18;
LINK_T = 6;
PIVOT_D = M4_CLEARANCE;
PIVOT_BOSS_D = 16;
TUBE_OD = CF_TUBE_10_OD;

module pivot_boss() {
    difference() {
        hp_rounded_box([PIVOT_BOSS_D + 4, PIVOT_BOSS_D + 4, LINK_T], r=2.2);
        cylinder(h=LINK_T + 4, d=PIVOT_D, center=true);
        translate([0,0,LINK_T/2-1.2]) cylinder(h=2.8, d=M4_HEAD_D, center=true);
    }
}

module link_body(len=70) {
    difference() {
        union() {
            hull() {
                translate([-len/2,0,0]) pivot_boss();
                translate([ len/2,0,0]) pivot_boss();
            }
            // raised center rib for stiffness
            translate([0,0,LINK_T/2+1.4]) hp_rounded_box([len - 22, 6, 3], r=1.2);
        }
        // side relief slots, leaving pivots and spine intact
        for (x=[-len/4, len/4])
            translate([x,0,0]) hp_rounded_box([18, LINK_W + 4, LINK_T + 6], r=2);
    }
}

module upper_link() {
    link_body(UPPER_LEN);
    translate([0,-LINK_W/2-3,LINK_T/2+0.4]) hp_revision_tag("UP-LINK-A1", size=3);
}

module lower_link() {
    link_body(LOWER_LEN);
    translate([0,-LINK_W/2-3,LINK_T/2+0.4]) hp_revision_tag("LO-LINK-A1", size=3);
}

module link_end() {
    difference() {
        union() {
            pivot_boss();
            translate([18,0,0]) hp_rounded_box([36,18,LINK_T], r=2);
            translate([32,0,0]) rotate([0,90,0]) cylinder(h=24, d=TUBE_OD + 7, center=true);
        }
        rotate([0,90,0]) translate([0,0,32]) cylinder(h=30, d=TUBE_OD + CF_TUBE_CLEARANCE, center=true);
        translate([32,0,0]) rotate([90,0,0]) cylinder(h=28, d=M3_CLEARANCE, center=true);
    }
}

module tube_link(len=80) {
    translate([-len/2,0,0]) link_end();
    mirror([1,0,0]) translate([-len/2,0,0]) link_end();
    color([0.03,0.03,0.03]) rotate([0,90,0]) cylinder(h=len, d=TUBE_OD, center=true);
}

module assembly() {
    translate([0,24,0]) upper_link();
    translate([0,-24,0]) lower_link();
    translate([0,-62,0]) tube_link(90);
}

if (PART == "upper_link") upper_link();
else if (PART == "lower_link") lower_link();
else if (PART == "tube_link") tube_link(90);
else if (PART == "link_end") link_end();
else assembly();
