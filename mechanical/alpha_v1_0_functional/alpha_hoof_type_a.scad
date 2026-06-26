/*
Hound Alpha v1.0 Alien Hoof Type A functional module.

This converts the v0.9 hoof proxy into a printable first test piece.
It keeps the tri-lobed alien footprint while adding:
- 28 mm M3 mount pattern
- coating allowance
- tread channels
- hanging/handling hole
- coating coupon
- bolt gauge

PART options:
- hoof_core
- adapter_plate
- coating_coupon
- bolt_gauge
- assembly
- batch_four
- print_layout
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

$fn = 48;
PART = "assembly";

FOOT_W = 68;
FOOT_L = 62;
FOOT_H = 18;
MOUNT_SPACING = 28;
COAT_ALLOW = 1.2;

module hoof_outline_2d(delta=0) {
    offset(r=delta)
    hull() {
        translate([-19,-8]) circle(d=22);
        translate([ 19,-8]) circle(d=22);
        translate([0,18]) circle(d=23);
    }
}

module tread_cuts(depth=4) {
    for (a=[0,120,240])
        rotate([0,0,a]) translate([0,16,-1]) hp_rounded_box([5,22,depth+2],r=1.2);
    translate([0,0,-1]) cylinder(h=depth+2,d=12);
}

module mount_holes() {
    for (x=[-MOUNT_SPACING/2,MOUNT_SPACING/2]) {
        translate([x,0,-2]) cylinder(h=FOOT_H+16,d=M3_CLEARANCE);
        translate([x,0,FOOT_H+2]) cylinder(h=5,d=7.0);
    }
}

module hoof_core() {
    difference() {
        union() {
            hull() {
                linear_extrude(height=2) hoof_outline_2d(-1.0);
                translate([0,0,FOOT_H-2]) scale([0.78,0.78,1]) linear_extrude(height=2) hoof_outline_2d(-2.0);
            }
            // coating retention rim near the floor contact area
            translate([0,0,2]) linear_extrude(height=3) difference() {
                hoof_outline_2d(-1.0);
                hoof_outline_2d(-5.2);
            }
            // top bosses for adapter screws
            for (x=[-MOUNT_SPACING/2,MOUNT_SPACING/2])
                translate([x,0,FOOT_H-0.2]) cylinder(h=6,d=13);
            translate([0,0,FOOT_H+2]) hp_rounded_box([42,8,6],r=2);
        }
        mount_holes();
        tread_cuts(4);
        // top lightening pocket
        translate([0,0,5]) linear_extrude(height=FOOT_H+4) hoof_outline_2d(-11);
        // hanging / coating handling hole
        translate([0,30,10]) rotate([90,0,0]) cylinder(h=12,d=3.2,center=true);
    }
    translate([0,-30,FOOT_H+0.2]) hp_revision_tag("HOOF-A-V10",size=3,height=0.6);
}

module adapter_plate() {
    difference() {
        union() {
            hp_rounded_box([46,24,6],r=2.2);
            translate([0,0,7]) hp_rounded_box([30,16,8],r=1.6);
        }
        for (x=[-MOUNT_SPACING/2,MOUNT_SPACING/2])
            translate([x,0,0]) cylinder(h=22,d=M3_CLEARANCE,center=true);
        translate([0,0,8]) rotate([90,0,0]) cylinder(h=30,d=M4_CLEARANCE,center=true);
    }
    translate([0,-17,4]) rotate([90,0,0]) hp_revision_tag("ADAPT-28",size=2.2,height=0.45);
}

module coating_coupon() {
    difference() {
        linear_extrude(height=7) hoof_outline_2d(-8);
        tread_cuts(3);
        translate([0,20,4]) rotate([90,0,0]) cylinder(h=12,d=4,center=true);
    }
    translate([0,-19,7.2]) hp_revision_tag("COAT-TEST",size=2.5,height=0.45);
}

module bolt_gauge() {
    difference() {
        hp_rounded_box([46,16,4],r=2);
        for (x=[-MOUNT_SPACING/2,MOUNT_SPACING/2])
            translate([x,0,0]) cylinder(h=12,d=M3_CLEARANCE,center=true);
    }
    translate([0,-11,2.4]) hp_revision_tag("28MM-M3",size=2.5,height=0.45);
}

module assembly() {
    hoof_core();
    translate([0,0,FOOT_H+12]) color(MECHANICAL_DARK) adapter_plate();
}

module batch_four() {
    for (x=[-42,42]) for (y=[-42,42]) translate([x,y,0]) rotate([0,0,(x+y)/14]) hoof_core();
}

module print_layout() {
    translate([-85,45,0]) hoof_core();
    translate([0,45,0]) adapter_plate();
    translate([70,45,0]) bolt_gauge();
    translate([-40,-35,0]) coating_coupon();
    translate([55,-35,0]) hoof_core();
}

if (PART == "hoof_core") hoof_core();
else if (PART == "adapter_plate") adapter_plate();
else if (PART == "coating_coupon") coating_coupon();
else if (PART == "bolt_gauge") bolt_gauge();
else if (PART == "batch_four") batch_four();
else if (PART == "print_layout") print_layout();
else assembly();
