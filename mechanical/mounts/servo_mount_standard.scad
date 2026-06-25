/*
Hound Program // Standard Servo Mount v0.1

A boring printable bracket for early fit tests with standard digital servos.
Verify all dimensions after selecting the actual servo.
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

PART = "servo_mount"; // servo_mount, servo_mock, assembly

module standard_servo_mock() {
    color([0.1,0.1,0.1]) hp_rounded_box([STD_SERVO_W, STD_SERVO_D, STD_SERVO_H], r=1.2);
    color([0.15,0.15,0.15]) translate([0,0,STD_SERVO_H/2+2]) cylinder(d=STD_SERVO_SPLINE_D, h=4, center=true);
    color([0.08,0.08,0.08]) for (x=[-STD_SERVO_EAR_W/2, STD_SERVO_EAR_W/2])
        translate([x,0,STD_SERVO_H/2-4]) hp_rounded_box([8,STD_SERVO_D+4,3], r=1);
}

module standard_servo_mount() {
    difference() {
        union() {
            hp_rounded_box([STD_SERVO_W+10, STD_SERVO_D+10, 6], r=2);
            translate([0,-(STD_SERVO_D/2+5),STD_SERVO_H/2]) hp_rounded_box([STD_SERVO_W+10,5,STD_SERVO_H+8], r=2);
            translate([0,(STD_SERVO_D/2+5),STD_SERVO_H/2]) hp_rounded_box([STD_SERVO_W+10,5,STD_SERVO_H+8], r=2);
            for (x=[-STD_SERVO_EAR_W/2, STD_SERVO_EAR_W/2])
                translate([x,0,STD_SERVO_H/2-4]) hp_rounded_box([12,STD_SERVO_D+14,6], r=1.8);
        }
        // Servo body pocket
        translate([0,0,STD_SERVO_H/2+2]) hp_rounded_box([STD_SERVO_W+0.7, STD_SERVO_D+0.7, STD_SERVO_H+5], r=1.2);
        // Ear screws
        for (x=[-STD_SERVO_EAR_W/2, STD_SERVO_EAR_W/2])
        for (y=[-STD_SERVO_D/2-3, STD_SERVO_D/2+3])
            translate([x,y,STD_SERVO_H/2-4]) cylinder(h=12, d=M3_CLEARANCE, center=true);
        // Mounting holes to external bracket
        for (x=[-20,20])
            translate([x,0,0]) hp_countersunk_m3(depth=16);
        // Side lightening
        for (y=[-(STD_SERVO_D/2+6), STD_SERVO_D/2+6])
            translate([0,y,STD_SERVO_H/2+4]) rotate([90,0,0]) hp_hex_lightening_grid(width=36,height=26,hole_d=7,spacing=12,cut_depth=8);
    }
    translate([0,0,3.3]) hp_revision_tag("SVO-MNT-A1", size=3.4);
}

module assembly() {
    standard_servo_mount();
    translate([0,0,8]) standard_servo_mock();
}

if (PART == "servo_mount") standard_servo_mount();
else if (PART == "servo_mock") standard_servo_mock();
else assembly();
