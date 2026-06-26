/*
Hound Program hardware envelope helpers.
All dimensions are millimeters.
These are CAD planning boxes only. Measure real parts before final prints.
*/

include <hound_constants.scad>
include <hound_primitives.scad>

module hp_standard_servo_envelope(label="STD-SERVO") {
    color([0.07,0.07,0.07]) union() {
        hp_rounded_box([41,21,41], r=2.5);
        translate([0,0,24]) hp_rounded_box([55,20,4], r=1.4);
        translate([14,0,23]) rotate([90,0,0]) cylinder(h=26,d=12,center=true);
    }
    translate([0,-14,-18]) rotate([90,0,0]) hp_revision_tag(label,size=2.2,height=0.5);
}

module hp_micro_servo_envelope(label="MICRO") {
    color([0.10,0.10,0.10]) union() {
        hp_rounded_box([24,13,24], r=1.4);
        translate([0,0,15]) hp_rounded_box([32,12,3], r=1.0);
    }
    translate([0,-10,-10]) rotate([90,0,0]) hp_revision_tag(label,size=1.8,height=0.4);
}

module hp_pca9685_envelope(label="PCA9685") {
    color([0.08,0.10,0.08]) hp_rounded_box([63,26,8], r=1.4);
    translate([0,-17,5]) rotate([90,0,0]) hp_revision_tag(label,size=2.0,height=0.4);
}

module hp_esp32_envelope(label="ESP32") {
    color([0.08,0.08,0.12]) hp_rounded_box([56,30,12], r=1.6);
    translate([0,-19,7]) rotate([90,0,0]) hp_revision_tag(label,size=2.0,height=0.4);
}

module hp_battery_envelope(label="BATTERY") {
    color([0.12,0.10,0.08]) hp_rounded_box([110,35,28], r=3);
    translate([0,-23,16]) rotate([90,0,0]) hp_revision_tag(label,size=2.2,height=0.4);
}

module hp_hardware_tray_envelope() {
    hp_battery_envelope();
    translate([0,42,9]) hp_pca9685_envelope();
    translate([0,78,12]) hp_esp32_envelope();
}
