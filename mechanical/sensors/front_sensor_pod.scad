/*
Hound Program // Front Sensor Pod v0.1

A small non-face sensor pod for camera / ToF / status LED fit tests.
Design goal: sensor cluster, not eyes.

PART options:
- pod_shell
- diffuser
- camera_plate
- assembly
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

$fn = 56;
PART = "assembly";

POD_L = 64;
POD_W = 34;
POD_H = 24;
CAM_D = 12.5;
LED_SLOT_W = 46;
LED_SLOT_H = 4;

module pod_shell() {
    difference() {
        union() {
            hp_rounded_box([POD_L,POD_W,POD_H], r=4);
            translate([-POD_L/2+8,0,-POD_H/2-3]) hp_rounded_box([16,POD_W+8,8], r=2);
        }
        // camera / sensor bore
        translate([POD_L/2-8,0,2]) rotate([0,90,0]) cylinder(h=18,d=CAM_D,center=true);
        // horizontal sensor slit
        translate([POD_L/2-4,0,-7]) rotate([0,90,0]) hp_rounded_box([LED_SLOT_H,LED_SLOT_W,6], r=1.2);
        // rear hollowing
        translate([-POD_L/2+14,0,0]) hp_rounded_box([38,POD_W-8,POD_H-7], r=3);
        // mount holes
        for (y=[-12,12])
            translate([-POD_L/2+8,y,-POD_H/2-3]) cylinder(h=14,d=M3_CLEARANCE,center=true);
        // wire pass
        translate([-POD_L/2,0,-2]) rotate([0,90,0]) cylinder(h=16,d=8,center=true);
    }
    translate([-8,-POD_W/2-3,-POD_H/2+4]) rotate([90,0,0]) hp_revision_tag("SNS-POD-A1", size=3);
}

module diffuser() {
    color(SENSOR_RED) hp_rounded_box([LED_SLOT_W,3,LED_SLOT_H], r=1.2);
}

module camera_plate() {
    difference() {
        hp_rounded_box([24,20,3], r=2);
        cylinder(h=6,d=CAM_D,center=true);
        for (x=[-8,8]) for (y=[-6,6]) translate([x,y,0]) cylinder(h=8,d=M2_CLEARANCE,center=true);
    }
}

module assembly() {
    pod_shell();
    translate([POD_L/2+1,0,-7]) rotate([0,90,0]) diffuser();
    translate([POD_L/2+1,0,2]) rotate([0,90,0]) camera_plate();
}

if (PART == "pod_shell") pod_shell();
else if (PART == "diffuser") diffuser();
else if (PART == "camera_plate") camera_plate();
else assembly();
