/*
Hound Alpha v0.9 refined concept candidate.

This pass refines v0.8 down instead of adding more detail.
Goal: preserve the workable v0.8 direction while making the design cleaner,
more printable, and closer to the original concept profile plus Alien Hoof Type A.

PART options:
- assembly
- shell
- hardware
- legset
- one_leg
- hoof
- panels
- print_layout
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>
include <../lib/hound_hardware_envelopes.scad>

$fn = 36;
PART = "assembly";

BODY_Z = 86;
FRONT_X = 102;
REAR_X = -96;
HIP_Y = 57;
RAIL_Y = 23;
PIVOT_D = M4_CLEARANCE;
LINK_T = 5;

module rbox(size=[10,10,10], r=2) { hp_rounded_box(size, r=r); }

module clean_panel(len=80, w=18, t=4, notch=false) {
    difference() {
        hull() {
            translate([-len/2+8,0,0]) rbox([16,w,t],1.2);
            translate([ len/2-18,0,1.5]) rbox([32,w*0.82,t],1.2);
            translate([ len/2-5,0,4]) rbox([10,w*0.42,t],0.8);
        }
        for (x=[-len/2+12,len/2-18])
            translate([x,0,0]) cylinder(h=t+8,d=M3_CLEARANCE,center=true);
        if (notch)
            translate([0,0,0]) rbox([len-34,5,t+6],1);
    }
}

module hull_shell() {
    color(BODY_BLACK)
    difference() {
        union() {
            // Fewer, stronger volumes. Long, low, front-heavy.
            hull() {
                translate([-150,0,BODY_Z+1]) rbox([32,42,16],2.2);
                translate([-84,0,BODY_Z+10]) rbox([78,66,24],3.2);
                translate([10,0,BODY_Z+15]) rbox([118,76,28],3.4);
                translate([108,0,BODY_Z+9]) rbox([86,54,22],2.8);
                translate([154,0,BODY_Z-4]) rbox([22,24,11],1.8);
            }
            // lower front wedge / sensor carrier, smaller than v0.8
            translate([134,0,BODY_Z-15]) rotate([0,-9,0]) rbox([42,28,9],1.8);
            // rear tail cover
            translate([-144,0,BODY_Z-9]) rotate([0,5,0]) rbox([40,30,9],1.6);
        }
        // long underside cut creates service space and slims the visual mass
        translate([-6,0,BODY_Z-17]) rbox([270,52,34],3.5);
        // top tray cut, centered over electronics
        translate([-30,0,BODY_Z+17]) rbox([128,42,14],2.6);
        // front sensor cavity
        translate([150,0,BODY_Z-1]) rotate([0,-8,0]) rbox([26,18,8],1.4);
    }
}

module dorsal_set() {
    color(ARMOR_DARK) {
        // v0.9 deliberately reduces dorsal clutter: two main blades plus one small forward shard.
        translate([-58,0,BODY_Z+28]) rotate([0,-15,0]) clean_panel(98,17,4);
        translate([18,0,BODY_Z+29]) rotate([0,-12,0]) clean_panel(86,16,4);
        translate([82,0,BODY_Z+24]) rotate([0,-8,0]) clean_panel(44,13,3);
    }
}

module side_shell_panels() {
    for (side=[-1,1]) {
        color(ARMOR_DARK) {
            translate([-92,side*43,BODY_Z+0]) rotate([0,0,side*3]) clean_panel(86,16,4,true);
            translate([-8,side*47,BODY_Z+4]) rotate([0,0,side*1]) clean_panel(108,18,4,true);
            translate([82,side*42,BODY_Z+1]) rotate([0,0,side*-7]) clean_panel(72,16,4,true);
        }
        // continuous lower skirt, thin enough that hubs still read as external mechanics
        color([0.016,0.016,0.016]) translate([-10,side*38,BODY_Z-15]) rbox([212,5,14],1.8);
    }
}

module red_slits() {
    color(SENSOR_RED) {
        translate([134,-23,BODY_Z+13]) rotate([0,-17,-13]) rbox([56,4,4],0.9);
        translate([134, 23,BODY_Z+13]) rotate([0,-17, 13]) rbox([56,4,4],0.9);
        translate([154,0,BODY_Z-7]) rotate([0,-22,0]) rbox([26,4,5],0.9);
        translate([-22,0,BODY_Z+32]) rbox([38,4,3],0.9);
        for (side=[-1,1]) translate([-24,side*50,BODY_Z+12]) rbox([52,3,3],0.8);
    }
}

module shell() {
    hull_shell();
    dorsal_set();
    side_shell_panels();
    red_slits();
}

module frame_core() {
    color(MECHANICAL_DARK) translate([-8,0,BODY_Z-32]) rbox([258,48,8],2.8);
    for (y=[-RAIL_Y,RAIL_Y])
        color([0.02,0.02,0.02]) translate([-8,y,BODY_Z-23]) rotate([0,90,0]) cylinder(h=286,d=CF_TUBE_12_OD,center=true);
    for (x=[FRONT_X,REAR_X])
        color([0.055,0.055,0.055]) translate([x,0,BODY_Z-31]) rbox([14,112,10],1.8);
}

module electronics_stack() {
    color([0.10,0.10,0.10]) translate([-50,0,BODY_Z-15]) scale([0.9,0.9,0.9]) hp_battery_envelope("BAT");
    color([0.08,0.10,0.08]) translate([40,0,BODY_Z-12]) hp_pca9685_envelope("PWM");
    color([0.08,0.08,0.12]) translate([42,0,BODY_Z+2]) hp_esp32_envelope("CTRL");
}

module hub(d=30,w=12) {
    color([0.018,0.018,0.018]) rotate([90,0,0]) cylinder(h=w,d=d,center=true);
    color([0.15,0.15,0.15]) rotate([90,0,0]) cylinder(h=w+4,d=10,center=true);
}

module link(a=[0,0,0], b=[10,0,0]) {
    dx=b[0]-a[0]; dz=b[2]-a[2];
    len=sqrt(dx*dx+dz*dz); ang=-atan2(dz,dx);
    mid=[(a[0]+b[0])/2,(a[1]+b[1])/2,(a[2]+b[2])/2];
    translate(mid) rotate([0,ang,0])
    difference() {
        union() {
            hull() {
                translate([-len/2,0,0]) cylinder(h=LINK_T,d=15,center=true);
                translate([ len/2,0,0]) cylinder(h=LINK_T,d=15,center=true);
            }
            translate([0,0,LINK_T/2+0.9]) rbox([max(len-24,8),4,1.8],0.8);
        }
        for (x=[-len/2,len/2]) translate([x,0,0]) cylinder(h=LINK_T+4,d=PIVOT_D,center=true);
        translate([0,0,0]) rbox([max(len-34,6),4,LINK_T+5],1);
    }
}

module alien_hoof_type_a() {
    color(BODY_BLACK)
    difference() {
        union() {
            // Type A: tri-lobed, low, printable, coating-friendly.
            hull() {
                translate([-20,-8,0]) sphere(d=21);
                translate([ 20,-8,0]) sphere(d=21);
                translate([0,18,0]) sphere(d=22);
            }
            translate([0,0,8]) rbox([42,22,10],2.8);
            // coating-retention shoulder/rim cue
            translate([0,0,4]) scale([1.0,0.85,0.35]) hull() {
                translate([-22,-8,0]) sphere(d=9);
                translate([22,-8,0]) sphere(d=9);
                translate([0,20,0]) sphere(d=9);
            }
        }
        translate([0,0,-14]) cube([88,82,24],center=true);
        for (a=[0,120,240]) rotate([0,0,a]) translate([0,16,1]) rbox([5,20,8],1.2);
        for (x=[-14,14]) translate([x,0,8]) cylinder(h=18,d=M3_CLEARANCE,center=true);
    }
}

module hoof_adapter_28mm() {
    color(MECHANICAL_DARK)
    difference() {
        union() {
            rbox([46,24,6],2.2);
            translate([0,0,7]) rbox([30,16,8],1.6);
        }
        for (x=[-14,14]) translate([x,0,0]) cylinder(h=20,d=M3_CLEARANCE,center=true);
        translate([0,0,8]) rotate([90,0,0]) cylinder(h=30,d=PIVOT_D,center=true);
    }
}

module leg(side=1,x=80,front=true) {
    hip=[x,side*HIP_Y,BODY_Z-40];
    knee=[x+(front?-50:50),side*(HIP_Y+9),40];
    ankle=[x+(front?-8:8),side*(HIP_Y+14),17];
    foot=[x+(front?-24:24),side*(HIP_Y+18),1];

    // Servo is present but visually tucked; round hub is the design language.
    color([0.045,0.045,0.045]) translate(hip+[0,-side*10,0]) scale([0.68,0.84,0.68]) hp_standard_servo_envelope("S");
    translate(hip+[15,side*7,0]) hub(32,12);
    translate(knee) hub(23,9);
    translate(ankle) hub(19,8);

    color([0.034,0.034,0.034]) for (o=[-5,5]) {
        link(hip+[0,o,-8],knee+[0,o,0]);
        link(knee+[0,o,0],ankle+[0,o,0]);
    }
    color([0.034,0.034,0.034]) link(ankle,foot+[0,0,10]);

    translate(foot+[0,0,13]) hoof_adapter_28mm();
    translate(foot) rotate([0,0,side*8]) alien_hoof_type_a();
}

module legset() {
    for (side=[-1,1]) {
        leg(side,FRONT_X,true);
        leg(side,REAR_X,false);
    }
}

module hardware() {
    frame_core();
    electronics_stack();
    legset();
}

module panels() {
    translate([-100,50,0]) clean_panel(86,16,4,true);
    translate([0,50,0]) clean_panel(108,18,4,true);
    translate([100,50,0]) clean_panel(72,16,4,true);
    translate([-60,0,0]) clean_panel(98,17,4);
    translate([40,0,0]) clean_panel(86,16,4);
}

module print_layout() {
    translate([-130,74,0]) clean_panel(86,16,4,true);
    translate([-36,74,0]) clean_panel(58,16,3,false);
    translate([40,74,0]) hoof_adapter_28mm();
    translate([112,74,0]) alien_hoof_type_a();
    translate([-108,0,0]) link([-34,0,0],[34,0,0]);
    translate([-18,0,0]) link([-46,0,0],[46,0,0]);
    translate([80,0,0]) hub(24,10);
}

module assembly() {
    hardware();
    shell();
}

if (PART == "shell") shell();
else if (PART == "hardware") hardware();
else if (PART == "legset") legset();
else if (PART == "one_leg") leg(1,0,true);
else if (PART == "hoof") alien_hoof_type_a();
else if (PART == "panels") panels();
else if (PART == "print_layout") print_layout();
else assembly();
