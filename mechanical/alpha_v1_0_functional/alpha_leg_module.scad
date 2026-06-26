/*
Hound Alpha v1.0 functional leg module.

A printable one-leg test module derived from the v0.9 candidate.
This is a bench-scale physical test target, not final walking kinematics.
It defines flat paired links, spacer hubs, pivot holes, a standard-servo envelope,
and a 28 mm M3 hoof adapter interface.

PART options:
- assembly
- hip_cradle
- upper_link
- lower_link
- pastern_link
- pivot_spacer
- hoof_adapter
- one_side
- print_layout
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>
include <../lib/hound_hardware_envelopes.scad>

$fn = 36;
PART = "assembly";

PIVOT_D = M4_CLEARANCE;
LINK_T = 5;
LINK_W = 14;
LINK_BOSS_D = 16;
PAIR_GAP = 10;
UPPER_LEN = 78;
LOWER_LEN = 70;
PASTERN_LEN = 42;

module link_plate(len=70,label="LINK") {
    difference() {
        union() {
            hull() {
                translate([-len/2,0,0]) cylinder(h=LINK_T,d=LINK_BOSS_D,center=true);
                translate([ len/2,0,0]) cylinder(h=LINK_T,d=LINK_BOSS_D,center=true);
            }
            translate([0,0,LINK_T/2+1]) hp_rounded_box([len-24,4,2],r=0.8);
        }
        for (x=[-len/2,len/2]) translate([x,0,0]) cylinder(h=LINK_T+6,d=PIVOT_D,center=true);
        translate([0,0,0]) hp_rounded_box([len-34,5,LINK_T+6],r=1);
    }
    translate([0,-LINK_W/2-3,LINK_T/2+0.2]) hp_revision_tag(label,size=2.4,height=0.45);
}

module paired_link(len=70,label="LINK") {
    translate([0,-PAIR_GAP/2,0]) link_plate(len,label);
    translate([0, PAIR_GAP/2,0]) link_plate(len,label);
}

module pivot_spacer(d=15,w=PAIR_GAP+6,label="SPACER") {
    difference() {
        cylinder(h=w,d=d,center=true);
        cylinder(h=w+4,d=PIVOT_D,center=true);
    }
    translate([0,-w/2-3,d/2]) rotate([90,0,0]) hp_revision_tag(label,size=1.8,height=0.35);
}

module hip_cradle() {
    difference() {
        union() {
            hp_rounded_box([54,34,34],r=3);
            translate([20,0,0]) rotate([90,0,0]) cylinder(h=42,d=26,center=true);
            translate([-8,0,-22]) hp_rounded_box([52,42,8],r=2);
            // clevis ears
            for (y=[-19,19]) translate([20,y,0]) hp_rounded_box([20,5,28],r=1.4);
        }
        // standard servo envelope pocket
        translate([-6,0,1]) hp_rounded_box([42,22,28],r=2);
        translate([20,0,0]) rotate([90,0,0]) cylinder(h=50,d=PIVOT_D,center=true);
        for (x=[-24,4]) for (y=[-14,14]) translate([x,y,-22]) cylinder(h=16,d=M3_CLEARANCE,center=true);
        translate([-30,0,-4]) rotate([0,90,0]) cylinder(h=20,d=8,center=true); // wire path
    }
    translate([-4,-25,-16]) rotate([90,0,0]) hp_revision_tag("HIP-CRADLE-V10",size=2.1,height=0.45);
}

module hoof_adapter() {
    difference() {
        union() {
            hp_rounded_box([46,24,6],r=2.2);
            translate([0,0,7]) hp_rounded_box([30,16,8],r=1.6);
        }
        for (x=[-14,14]) translate([x,0,0]) cylinder(h=22,d=M3_CLEARANCE,center=true);
        translate([0,0,8]) rotate([90,0,0]) cylinder(h=30,d=PIVOT_D,center=true);
    }
    translate([0,-17,4]) rotate([90,0,0]) hp_revision_tag("HOOF-28-V10",size=2.1,height=0.45);
}

function angle_between(a,b) = -atan2(b[2]-a[2], b[0]-a[0]);
function dist(a,b) = sqrt(pow(b[0]-a[0],2)+pow(b[2]-a[2],2));

module place_link(a=[0,0,0],b=[10,0,0],label="LINK") {
    len = dist(a,b);
    mid = [(a[0]+b[0])/2,(a[1]+b[1])/2,(a[2]+b[2])/2];
    translate(mid) rotate([0,angle_between(a,b),0]) paired_link(len,label);
}

module one_side(front=true) {
    hip=[0,0,76];
    knee=[front?-48:48,0,40];
    ankle=[front?-8:8,0,17];
    hoof=[front?-24:24,0,1];

    translate(hip) hip_cradle();
    color([0.04,0.04,0.04]) place_link(hip+[0,0,-8],knee,"UPPER");
    color([0.04,0.04,0.04]) place_link(knee,ankle,"LOWER");
    color([0.04,0.04,0.04]) place_link(ankle,hoof+[0,0,10],"PASTERN");

    color([0.12,0.12,0.12]) translate(knee) rotate([90,0,0]) pivot_spacer(18,24,"KNEE");
    color([0.12,0.12,0.12]) translate(ankle) rotate([90,0,0]) pivot_spacer(16,22,"ANKLE");
    translate(hoof+[0,0,13]) hoof_adapter();
}

module assembly() {
    translate([-55,0,0]) one_side(true);
    translate([55,0,0]) one_side(false);
}

module print_layout() {
    translate([-130,60,0]) hip_cradle();
    translate([-42,60,0]) link_plate(UPPER_LEN,"UPPER78");
    translate([46,60,0]) link_plate(LOWER_LEN,"LOWER70");
    translate([122,60,0]) link_plate(PASTERN_LEN,"PASTERN42");
    translate([-70,-15,0]) pivot_spacer(18,24,"KNEE");
    translate([-20,-15,0]) pivot_spacer(16,22,"ANKLE");
    translate([42,-15,0]) hoof_adapter();
}

if (PART == "hip_cradle") hip_cradle();
else if (PART == "upper_link") link_plate(UPPER_LEN,"UPPER78");
else if (PART == "lower_link") link_plate(LOWER_LEN,"LOWER70");
else if (PART == "pastern_link") link_plate(PASTERN_LEN,"PASTERN42");
else if (PART == "pivot_spacer") pivot_spacer(18,24,"SPACER");
else if (PART == "hoof_adapter") hoof_adapter();
else if (PART == "one_side") one_side(true);
else if (PART == "print_layout") print_layout();
else assembly();
