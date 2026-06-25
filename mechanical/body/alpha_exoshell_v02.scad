/*
Hound Program // Alpha Exoshell v0.2

Refined visual shell pass after first OpenSCAD assembly review.
The v0.1 assembly was too blocky and read like stacked brackets.
This file establishes a sleeker alien-animal body language:
- long tapered dorsal shell
- faceted side cowls
- recessed red sensor slit
- removable-looking armor plates
- low, forward, predatory stance without dog-face features

PART options:
- dorsal_shell
- left_cowl
- right_cowl
- sensor_slit
- top_armor_set
- side_armor_set
- assembly
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

$fn = 56;
PART = "assembly";

BODY_LEN = 236;
BODY_W = 86;
BODY_H = 44;
SHELL_T = 5;

module tapered_body_poly(len=BODY_LEN, w=BODY_W, h=BODY_H) {
    polyhedron(
        points=[
            [-len/2,-w*0.34,-h*0.42], [-len/2,w*0.34,-h*0.42], [-len/2,-w*0.24,h*0.22], [-len/2,w*0.24,h*0.22],
            [-len*0.22,-w*0.50,-h*0.50], [-len*0.22,w*0.50,-h*0.50], [-len*0.22,-w*0.40,h*0.52], [-len*0.22,w*0.40,h*0.52],
            [ len*0.24,-w*0.45,-h*0.46], [ len*0.24,w*0.45,-h*0.46], [ len*0.24,-w*0.31,h*0.48], [ len*0.24,w*0.31,h*0.48],
            [ len/2,-w*0.20,-h*0.30], [ len/2,w*0.20,-h*0.30], [ len/2,-w*0.12,h*0.10], [ len/2,w*0.12,h*0.10]
        ],
        faces=[
            [0,4,5,1], [2,3,7,6], [0,2,6,4], [1,5,7,3],
            [4,8,9,5], [6,7,11,10], [4,6,10,8], [5,9,11,7],
            [8,12,13,9], [10,11,15,14], [8,10,14,12], [9,13,15,11],
            [12,14,15,13], [0,1,3,2]
        ]
    );
}

module dorsal_shell() {
    difference() {
        union() {
            tapered_body_poly();
            // dorsal ridge, low and blade-like
            translate([-42,0,BODY_H*0.46]) hp_fin_plate(len=118,h=16,thick=7,sweep=-7);
            // rear raised mechanical shoulder cover
            translate([-72,0,5]) hp_rounded_box([70,78,18], r=5);
        }
        // hollow underside, not a solid brick
        translate([-12,0,-BODY_H*0.46]) hp_rounded_box([BODY_LEN-42,BODY_W-22,BODY_H], r=8);
        // service opening on top
        translate([-20,0,BODY_H*0.45]) hp_rounded_box([92,46,14], r=4);
        // wire path
        translate([0,0,-18]) rotate([0,90,0]) cylinder(h=BODY_LEN-20,d=14,center=true);
        // body mount holes
        for (x=[-84,-36,36,84]) for (y=[-28,28])
            translate([x,y,-BODY_H*0.40]) cylinder(h=22,d=M3_CLEARANCE,center=true);
    }
    translate([-94,-32,BODY_H*0.37]) hp_revision_tag("EXO-A2", size=3.4);
}

module side_cowl(side=1) {
    mirror([0, side < 0 ? 1 : 0, 0])
    difference() {
        union() {
            translate([-10,BODY_W/2-4,-6]) rotate([0,0,-4])
                hp_rounded_box([176,8,34], r=3);
            translate([42,BODY_W/2-8,2]) rotate([0,-8,-8])
                hp_rounded_box([88,10,24], r=3);
            // cheek-like rear armor that hides hip modules
            translate([-78,BODY_W/2-8,-4]) rotate([0,6,7])
                hp_rounded_box([68,12,30], r=4);
        }
        // side sensor/vent slashes
        for (x=[-54,-32,-10,12,34])
            translate([x,BODY_W/2-13,-5]) rotate([0,20,0]) hp_rounded_box([4,16,22], r=1.2);
        // mounting holes
        for (x=[-74,-20,38,82])
            translate([x,BODY_W/2-7,7]) rotate([90,0,0]) cylinder(h=18,d=M3_CLEARANCE,center=true);
    }
}

module sensor_slit() {
    color(SENSOR_RED)
    union() {
        translate([88,0,10]) rotate([0,-8,0]) hp_rounded_box([54,4,3.4], r=1.1);
        translate([114,0,-1]) rotate([0,-18,0]) hp_rounded_box([28,4,3.2], r=1.0);
    }
}

module top_armor_set() {
    for (i=[0:4]) {
        x = -86 + i*38;
        translate([x,0,BODY_H*0.58 + (i%2)*1.4]) rotate([0,0,(i-2)*2])
            hp_armor_scale(len=26,w=18,h=3,r=1.2);
    }
}

module side_armor_set(side=1) {
    mirror([0, side < 0 ? 1 : 0, 0])
    for (i=[0:3]) {
        translate([-72 + i*42, BODY_W/2+3, -4 + i*1.2]) rotate([0,-4,8])
            hp_armor_scale(len=30,w=12,h=3,r=1.0);
    }
}

module assembly() {
    color(BODY_BLACK) dorsal_shell();
    color(ARMOR_DARK) side_cowl(1);
    color(ARMOR_DARK) side_cowl(-1);
    color([0.06,0.06,0.06]) top_armor_set();
    color([0.055,0.055,0.055]) side_armor_set(1);
    color([0.055,0.055,0.055]) side_armor_set(-1);
    sensor_slit();
}

if (PART == "dorsal_shell") dorsal_shell();
else if (PART == "left_cowl") side_cowl(1);
else if (PART == "right_cowl") side_cowl(-1);
else if (PART == "sensor_slit") sensor_slit();
else if (PART == "top_armor_set") top_armor_set();
else if (PART == "side_armor_set") side_armor_set(1);
else assembly();
