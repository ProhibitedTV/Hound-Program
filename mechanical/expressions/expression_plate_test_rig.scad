/*
Hound Program // Expression Plate Test Rig v0.1

Bench-top print for testing tiny plate motion without committing to the full head.
Goal: limited alien body-language, not cartoon expressions.
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

PART = "assembly"; // base, plate, servo_cradle, linkage, assembly
POSE = 12; // degrees

module servo_cradle() {
    difference() {
        union() {
            hp_rounded_box([MICRO_SERVO_W+10, MICRO_SERVO_D+10, 4], r=2);
            translate([0,-(MICRO_SERVO_D/2+5),MICRO_SERVO_H/2]) hp_rounded_box([MICRO_SERVO_W+10,4,MICRO_SERVO_H], r=1.5);
            translate([0,(MICRO_SERVO_D/2+5),MICRO_SERVO_H/2]) hp_rounded_box([MICRO_SERVO_W+10,4,MICRO_SERVO_H], r=1.5);
        }
        translate([0,0,MICRO_SERVO_H/2]) hp_rounded_box([MICRO_SERVO_W+0.7,MICRO_SERVO_D+0.7,MICRO_SERVO_H+2], r=1);
        for(x=[-MICRO_SERVO_W/2-3, MICRO_SERVO_W/2+3]) translate([x,0,2]) cylinder(h=10,d=M2_CLEARANCE,center=true);
    }
}

module test_base() {
    difference() {
        union() {
            hp_rounded_box([110,52,5], r=3);
            translate([-34,0,12]) hp_rounded_box([34,34,24], r=3);
            translate([28,0,12]) hp_rounded_box([24,42,24], r=3);
        }
        for(x=[-45,45]) for(y=[-18,18]) translate([x,y,0]) hp_countersunk_m3(depth=14);
        translate([-34,0,14]) hp_rounded_box([MICRO_SERVO_W+2,MICRO_SERVO_D+2,MICRO_SERVO_H+4], r=1);
        translate([28,0,22]) rotate([90,0,0]) cylinder(h=60,d=M3_CLEARANCE,center=true);
    }
    translate([0,-22,3]) hp_revision_tag("EXPR-RIG-A1", size=3.4);
}

module expression_plate() {
    difference() {
        union() {
            translate([0,0,0]) hp_rounded_box([62,18,4], r=2);
            translate([18,0,4]) scale([0.8,0.62,0.4]) hp_rounded_box([62,18,6], r=1.6);
            translate([-28,0,-2]) hp_rounded_box([12,22,6], r=2);
        }
        translate([-28,0,-2]) rotate([90,0,0]) cylinder(h=28,d=M3_CLEARANCE,center=true);
        translate([8,0,1]) cylinder(h=10,d=M2_CLEARANCE,center=true);
    }
}

module linkage(len=34) {
    difference() {
        hull() {
            translate([-len/2,0,0]) cylinder(h=3,d=7,center=true);
            translate([len/2,0,0]) cylinder(h=3,d=7,center=true);
        }
        translate([-len/2,0,0]) cylinder(h=5,d=M2_CLEARANCE,center=true);
        translate([len/2,0,0]) cylinder(h=5,d=M2_CLEARANCE,center=true);
    }
}

module assembly() {
    test_base();
    translate([-34,0,5]) servo_cradle();
    translate([28,0,22]) rotate([POSE,0,0]) translate([31,0,0]) expression_plate();
    translate([4,0,18]) rotate([0,0,0]) linkage(34);
}

if(PART=="base") test_base();
else if(PART=="plate") expression_plate();
else if(PART=="servo_cradle") servo_cradle();
else if(PART=="linkage") linkage();
else assembly();
