/*
Hound Alpha v1.0 functional frame core.

This starts breaking the v0.9 candidate into printable and buildable subassemblies.
The frame is intentionally boring: flat spine, carbon tube rails, crossmembers,
board tray, battery tray, and serviceable screw access.

PART options:
- assembly
- spine_plate
- front_crossmember
- rear_crossmember
- rail_clamp
- electronics_tray
- battery_tray
- print_layout
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>
include <../lib/hound_hardware_envelopes.scad>

$fn = 36;
PART = "assembly";

FRAME_L = 258;
FRAME_W = 52;
FRAME_T = 5;
RAIL_OD = CF_TUBE_12_OD;
RAIL_Y = 24;
CROSS_W = 112;
CROSS_T = 8;
MOUNT_X_FRONT = 102;
MOUNT_X_REAR = -96;

module spine_plate() {
    difference() {
        union() {
            hp_rounded_box([FRAME_L,FRAME_W,FRAME_T], r=3);
            for (x=[-92,-46,0,46,92])
                translate([x,0,FRAME_T/2+1.5]) hp_rounded_box([24,FRAME_W-14,3], r=1.4);
        }
        // service holes and weight relief
        for (x=[-104,-64,-24,24,64,104]) for (y=[-17,17])
            translate([x,y,0]) cylinder(h=FRAME_T+8,d=M3_CLEARANCE,center=true);
        hp_hex_lightening_grid(width=178,height=30,hole_d=8,spacing=15,cut_depth=FRAME_T+8);
        // center wire slot
        hp_rounded_box([164,8,FRAME_T+8], r=2);
    }
    translate([0,-FRAME_W/2-3,FRAME_T/2+0.2]) hp_revision_tag("ALPHA-SPINE-V10",size=3,height=0.5);
}

module rail_clamp(length=34) {
    difference() {
        union() {
            hp_rounded_box([length,22,18], r=2.5);
            translate([0,0,5]) rotate([0,90,0]) cylinder(h=length,d=RAIL_OD+8,center=true);
        }
        translate([0,0,5]) rotate([0,90,0]) cylinder(h=length+4,d=RAIL_OD+0.45,center=true);
        // split slot
        translate([0,0,13]) cube([length+4,3,14],center=true);
        // clamp screw
        translate([0,0,13]) rotate([90,0,0]) cylinder(h=30,d=M3_CLEARANCE,center=true);
        // base screws
        for (x=[-length/2+8,length/2-8]) translate([x,0,-7]) cylinder(h=14,d=M3_CLEARANCE,center=true);
    }
}

module crossmember(label="CROSS") {
    difference() {
        union() {
            hp_rounded_box([16,CROSS_W,CROSS_T], r=2);
            for (y=[-RAIL_Y,RAIL_Y])
                translate([0,y,5]) rotate([0,90,0]) rail_clamp(22);
        }
        for (y=[-44,-20,20,44])
            translate([0,y,0]) cylinder(h=CROSS_T+20,d=M3_CLEARANCE,center=true);
    }
    translate([0,-CROSS_W/2-4,CROSS_T/2+0.2]) hp_revision_tag(label,size=2.5,height=0.5);
}

module electronics_tray() {
    difference() {
        union() {
            hp_rounded_box([80,44,5], r=2.5);
            for (x=[-34,34]) for (y=[-16,16])
                translate([x,y,4]) cylinder(h=4,d=7,center=true);
        }
        // PCA9685 / ESP32 board standoff holes
        for (x=[-28,28]) for (y=[-12,12])
            translate([x,y,0]) cylinder(h=14,d=M3_CLEARANCE,center=true);
        hp_rounded_box([62,10,9], r=1.5); // wire pass
    }
    translate([0,-25,3]) hp_revision_tag("ELEC-TRAY-V10",size=2.6,height=0.5);
}

module battery_tray() {
    difference() {
        union() {
            hp_rounded_box([124,44,6], r=3);
            for (y=[-18,18]) translate([0,y,10]) hp_rounded_box([118,5,12], r=1.5);
            for (x=[-54,54]) translate([x,0,10]) hp_rounded_box([5,36,12], r=1.5);
        }
        // strap slots
        for (x=[-34,34]) hp_rounded_box([8,54,12], r=1.5);
        for (x=[-52,52]) for (y=[-16,16])
            translate([x,y,0]) cylinder(h=18,d=M3_CLEARANCE,center=true);
    }
    translate([0,-27,4]) hp_revision_tag("BAT-TRAY-V10",size=2.6,height=0.5);
}

module assembly() {
    color(MECHANICAL_DARK) spine_plate();
    for (y=[-RAIL_Y,RAIL_Y])
        color([0.02,0.02,0.02]) translate([0,y,12]) rotate([0,90,0]) cylinder(h=286,d=RAIL_OD,center=true);
    translate([MOUNT_X_FRONT,0,2]) color([0.055,0.055,0.055]) crossmember("FRONT-XMEM");
    translate([MOUNT_X_REAR,0,2]) color([0.055,0.055,0.055]) crossmember("REAR-XMEM");
    translate([42,0,16]) color([0.08,0.10,0.08]) electronics_tray();
    translate([-52,0,15]) color([0.10,0.09,0.08]) battery_tray();
}

module print_layout() {
    translate([0,70,0]) spine_plate();
    translate([-110,-20,0]) crossmember("FRONT-XMEM");
    translate([-60,-20,0]) crossmember("REAR-XMEM");
    translate([0,-20,0]) rail_clamp(34);
    translate([62,-20,0]) electronics_tray();
    translate([155,-20,0]) battery_tray();
}

if (PART == "spine_plate") spine_plate();
else if (PART == "front_crossmember") crossmember("FRONT-XMEM");
else if (PART == "rear_crossmember") crossmember("REAR-XMEM");
else if (PART == "rail_clamp") rail_clamp(34);
else if (PART == "electronics_tray") electronics_tray();
else if (PART == "battery_tray") battery_tray();
else if (PART == "print_layout") print_layout();
else assembly();
