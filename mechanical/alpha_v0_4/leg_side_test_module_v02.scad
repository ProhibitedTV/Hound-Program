/*
Alpha v0.4.2 leg side test module.

This revision responds to the first v0.4 leg-side render.
The previous mock was useful, but still too toy-like:
- huge hip blocks
- ball joints with no real bracket logic
- rods that did not explain how the part would print or bolt together

This file moves toward Kobra 2 Max reality:
- flat printable link plates
- visible pivot holes
- clevis-style brackets
- paired links with spacers
- 28 mm M3 hoof adapter reference
- print layout for the candidate parts

PART options:
- assembly
- front_leg
- rear_leg
- hip_bracket
- link_70
- link_84
- pastern
- hoof_adapter
- print_layout
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

$fn = 36;
PART = "assembly";

PIVOT_D = 4.5;
LINK_W = 14;
LINK_T = 5;
LINK_BOSS_D = 16;
LINK_PAIR_GAP = 10;
HIP_W = 38;
HIP_H = 30;
HIP_D = 28;

function dist2d(a,b) = sqrt(pow(b[0]-a[0],2) + pow(b[2]-a[2],2));
function ang_y(a,b) = -atan2(b[2]-a[2], b[0]-a[0]);

module link_plate(len=70,label="LINK") {
    difference() {
        union() {
            hull() {
                translate([-len/2,0,0]) cylinder(h=LINK_T,d=LINK_BOSS_D,center=true);
                translate([ len/2,0,0]) cylinder(h=LINK_T,d=LINK_BOSS_D,center=true);
            }
            translate([0,0,LINK_T/2+1.2]) hp_rounded_box([len-24,5,2.4], r=1);
        }
        for (x=[-len/2,len/2])
            translate([x,0,0]) cylinder(h=LINK_T+4,d=PIVOT_D,center=true);
        translate([0,0,0]) hp_rounded_box([len-34,5,LINK_T+4], r=1.2);
    }
    translate([0,-LINK_W/2-3,LINK_T/2+0.2]) hp_revision_tag(label,size=2.5,height=0.5);
}

module paired_link_between(a=[0,0,0],b=[10,0,0],label="LINK") {
    len = dist2d(a,b);
    mid = [(a[0]+b[0])/2, (a[1]+b[1])/2, (a[2]+b[2])/2];
    translate(mid) rotate([0,ang_y(a,b),0]) {
        translate([0,-LINK_PAIR_GAP/2,0]) link_plate(len,label);
        translate([0, LINK_PAIR_GAP/2,0]) link_plate(len,label);
    }
}

module pivot_stack(pos=[0,0,0],d=18,label="P") {
    translate(pos) {
        color([0.08,0.08,0.08]) rotate([90,0,0]) cylinder(h=24,d=d,center=true);
        color([0.16,0.16,0.16]) rotate([90,0,0]) cylinder(h=28,d=PIVOT_D,center=true);
        translate([0,-15,-d/2]) rotate([90,0,0]) hp_revision_tag(label,size=2.2,height=0.5);
    }
}

module hip_bracket() {
    difference() {
        union() {
            hp_rounded_box([HIP_W,HIP_D,HIP_H], r=3);
            translate([16,0,0]) rotate([90,0,0]) cylinder(h=HIP_D+10,d=22,center=true);
            translate([-10,0,-HIP_H/2-3]) hp_rounded_box([36,34,6], r=2);
            // side ears for a real pivot/bracket read
            for (y=[-HIP_D/2-4,HIP_D/2+4])
                translate([16,y,0]) hp_rounded_box([18,5,26], r=1.5);
        }
        translate([16,0,0]) rotate([90,0,0]) cylinder(h=HIP_D+20,d=PIVOT_D,center=true);
        translate([-9,0,2]) hp_rounded_box([22,18,18], r=2);
        for (x=[-22,2]) for (y=[-10,10])
            translate([x,y,-HIP_H/2-3]) cylinder(h=12,d=M3_CLEARANCE,center=true);
    }
    translate([-6,-22,-HIP_H/2]) rotate([90,0,0]) hp_revision_tag("HIP-V42",size=2.6,height=0.5);
}

module hoof_adapter() {
    difference() {
        union() {
            hp_rounded_box([46,26,6], r=3);
            translate([0,0,7]) hp_rounded_box([30,18,8], r=2);
        }
        for (x=[-14,14]) translate([x,0,0]) cylinder(h=20,d=M3_CLEARANCE,center=true);
        translate([0,0,8]) rotate([90,0,0]) cylinder(h=32,d=PIVOT_D,center=true);
    }
    translate([0,-17,4]) rotate([90,0,0]) hp_revision_tag("HOOF-28",size=2.4,height=0.5);
}

module hoof_block() {
    color(BODY_BLACK)
    difference() {
        hp_rounded_box([54,36,12], r=6);
        translate([0,0,-8]) cube([80,80,16],center=true);
    }
}

module leg_side(front=true) {
    hip=[0,0,78];
    knee=[front?-34:34,0,45];
    ankle=[front?4:-4,0,20];
    hoof=[front?-8:8,0,5];

    color(MECHANICAL_DARK) translate(hip) hip_bracket();
    color([0.04,0.04,0.04]) paired_link_between(hip+[0,0,-8],knee,"UPPER");
    color([0.04,0.04,0.04]) paired_link_between(knee,ankle,"LOWER");
    color([0.04,0.04,0.04]) paired_link_between(ankle,hoof+[0,0,9],"PASTERN");

    pivot_stack(hip+[16,0,0],20,"HIP");
    pivot_stack(knee,19,"KNEE");
    pivot_stack(ankle,17,"ANKLE");

    color(MECHANICAL_DARK) translate(hoof+[0,0,14]) hoof_adapter();
    translate(hoof) hoof_block();
}

module print_layout() {
    translate([-120,60,0]) hip_bracket();
    translate([-45,60,0]) link_plate(70,"LINK70");
    translate([35,60,0]) link_plate(84,"LINK84");
    translate([110,60,0]) link_plate(48,"PASTERN");
    translate([-60,-20,0]) hoof_adapter();
    translate([35,-20,0]) hoof_block();
}

module assembly() {
    translate([-55,0,0]) leg_side(true);
    translate([65,0,0]) leg_side(false);
}

if (PART == "front_leg") leg_side(true);
else if (PART == "rear_leg") leg_side(false);
else if (PART == "hip_bracket") hip_bracket();
else if (PART == "link_70") link_plate(70,"LINK70");
else if (PART == "link_84") link_plate(84,"LINK84");
else if (PART == "pastern") link_plate(48,"PASTERN");
else if (PART == "hoof_adapter") hoof_adapter();
else if (PART == "print_layout") print_layout();
else assembly();
