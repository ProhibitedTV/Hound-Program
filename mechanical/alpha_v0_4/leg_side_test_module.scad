/*
Alpha v0.4 leg side test module.
This is a simplified printable-scale leg side mock for judging stance, spacing, and hoof connection.
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

$fn = 36;
PART = "assembly";

module bar_between(p1=[0,0,0],p2=[10,0,0],d=7) {
    hull() {
        translate(p1) sphere(d=d);
        translate(p2) sphere(d=d);
    }
}

module joint(d=18) {
    sphere(d=d);
    rotate([90,0,0]) cylinder(h=8,d=d+4,center=true);
}

module hoof_proxy() {
    difference() {
        hull() {
            translate([-15,-6,0]) sphere(d=20);
            translate([15,-6,0]) sphere(d=20);
            translate([0,16,0]) sphere(d=20);
        }
        translate([0,0,-12]) cube([70,70,20],center=true);
    }
}

module hip_block() {
    difference() {
        hp_rounded_box([46,30,30], r=4);
        translate([15,0,0]) rotate([90,0,0]) cylinder(h=38,d=11,center=true);
        translate([-8,0,0]) hp_rounded_box([22,18,18], r=2);
    }
}

module leg_side(front=true) {
    hip=[0,0,78];
    knee=[front?-30:30,6,44];
    ankle=[front?8:-8,12,20];
    foot=[front?-4:4,16,4];

    color([0.08,0.08,0.08]) translate(hip) hip_block();
    color([0.04,0.04,0.04]) for (o=[-4,4]) bar_between(hip+[0,o,0],knee+[0,o,0],7);
    color([0.04,0.04,0.04]) for (o=[-4,4]) bar_between(knee+[0,o,0],ankle+[0,o,0],7);
    color([0.04,0.04,0.04]) bar_between(ankle,foot+[0,0,8],7);

    color([0.12,0.12,0.12]) translate(hip) joint(18);
    color([0.12,0.12,0.12]) translate(knee) joint(20);
    color([0.12,0.12,0.12]) translate(ankle) joint(17);
    color([0.02,0.02,0.02]) translate(foot) hoof_proxy();
}

module assembly() {
    translate([-55,0,0]) leg_side(true);
    translate([55,0,0]) leg_side(false);
}

if (PART == "front") leg_side(true);
else if (PART == "rear") leg_side(false);
else assembly();
