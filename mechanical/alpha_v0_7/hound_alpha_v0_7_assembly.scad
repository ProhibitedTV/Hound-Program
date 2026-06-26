/*
Hound Alpha v0.7 silhouette tuning assembly.

Response to v0.6 render:
- v0.6 regained the black alien-machine direction
- but the body still read too chunky
- dorsal blades were too tall
- feet were too block-like
- legs were too hidden under the shell

v0.7 changes:
- longer and lower exoshell
- smaller swept dorsal blades
- more tapered front sensor wedge
- visible side hub covers under armor
- more open leg stance
- claw-hoof feet instead of blocks
- hardware envelopes remain present in hardware mode

PART options:
- assembly
- shell
- hardware
- legset
- one_leg
- foot
- print_layout
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>
include <../lib/hound_hardware_envelopes.scad>

$fn = 32;
PART = "assembly";

BODY_Z = 90;
FRONT_X = 94;
REAR_X = -96;
HIP_Y = 58;
RAIL_Y = 25;
PIVOT_CLEAR = M4_CLEARANCE;
LINK_T = 5;

module low_blade(len=78,w=18,t=4,label="BLADE") {
    difference() {
        hull() {
            translate([-len/2+8,0,0]) hp_rounded_box([16,w,t], r=1.4);
            translate([ len/2-20,0,2]) hp_rounded_box([36,w*0.75,t], r=1.4);
            translate([ len/2-4,0,5]) hp_rounded_box([8,w*0.35,t], r=1.0);
        }
        for (x=[-len/2+12,len/2-20])
            translate([x,0,0]) cylinder(h=t+8,d=M3_CLEARANCE,center=true);
    }
    translate([0,-w/2-3,t/2+0.2]) hp_revision_tag(label,size=1.8,height=0.4);
}

module tapered_shell_core() {
    color(BODY_BLACK)
    difference() {
        union() {
            // long low body; center mass is wide, nose and tail taper down
            hull() {
                translate([-142,0,BODY_Z+5]) hp_rounded_box([34,44,18], r=3);
                translate([-78,0,BODY_Z+13]) hp_rounded_box([88,72,28], r=4);
                translate([24,0,BODY_Z+15]) hp_rounded_box([120,76,30], r=4);
                translate([116,0,BODY_Z+7]) hp_rounded_box([66,44,20], r=3);
                translate([148,0,BODY_Z-3]) hp_rounded_box([18,24,12], r=2);
            }
            // front lower mandible-like sensor carrier, still not a face
            translate([132,0,BODY_Z-12]) rotate([0,-8,0]) hp_rounded_box([42,30,10], r=2);
        }
        // hollow underside for frame, links, wiring, and real service access
        translate([-10,0,BODY_Z-9]) hp_rounded_box([252,54,34], r=4);
        // top removable tray opening
        translate([-20,0,BODY_Z+22]) hp_rounded_box([122,42,15], r=3);
    }
}

module dorsal_blades() {
    color(ARMOR_DARK) {
        translate([-60,0,BODY_Z+33]) rotate([0,-12,0]) low_blade(96,18,4,"DORSAL-R");
        translate([12,0,BODY_Z+32]) rotate([0,-10,0]) low_blade(76,16,4,"DORSAL-M");
        translate([68,0,BODY_Z+27]) rotate([0,-8,0]) low_blade(54,14,3,"DORSAL-F");
    }
}

module side_armor() {
    color(ARMOR_DARK) for (side=[-1,1]) {
        translate([-86,side*44,BODY_Z+1]) rotate([0,0,side*4]) low_blade(88,18,4,"SIDE-R");
        translate([-6,side*47,BODY_Z+5]) rotate([0,0,side*1]) low_blade(92,18,4,"SIDE-M");
        translate([76,side*43,BODY_Z+3]) rotate([0,0,side*-7]) low_blade(70,16,4,"SIDE-F");
        // black skirt panel hides board edges without hiding hubs completely
        color([0.025,0.025,0.025]) translate([-8,side*39,BODY_Z-12]) hp_rounded_box([190,6,18], r=2);
    }
}

module red_slits() {
    color(SENSOR_RED) {
        translate([126,-24,BODY_Z+17]) rotate([0,-14,-12]) hp_rounded_box([52,4,4], r=1);
        translate([126, 24,BODY_Z+17]) rotate([0,-14, 12]) hp_rounded_box([52,4,4], r=1);
        translate([146,0,BODY_Z-3]) rotate([0,-20,0]) hp_rounded_box([30,4,5], r=1);
        translate([-26,0,BODY_Z+35]) hp_rounded_box([42,4,3], r=1);
        for (side=[-1,1]) translate([-12,side*50,BODY_Z+15]) hp_rounded_box([58,3,3], r=1);
    }
}

module shell() {
    tapered_shell_core();
    dorsal_blades();
    side_armor();
    red_slits();
}

module frame_core() {
    color(MECHANICAL_DARK) translate([-6,0,BODY_Z-28]) hp_rounded_box([252,50,8], r=3);
    for (y=[-RAIL_Y,RAIL_Y])
        color([0.02,0.02,0.02]) translate([-6,y,BODY_Z-19]) rotate([0,90,0]) cylinder(h=276,d=CF_TUBE_12_OD,center=true);
    for (x=[FRONT_X,REAR_X])
        color([0.055,0.055,0.055]) translate([x,0,BODY_Z-27]) hp_rounded_box([14,112,10], r=2);
}

module electronics_stack() {
    color([0.10,0.10,0.10]) translate([-44,0,BODY_Z-10]) scale([0.92,0.92,0.92]) hp_battery_envelope("BAT");
    color([0.08,0.10,0.08]) translate([42,0,BODY_Z-6]) hp_pca9685_envelope("PWM");
    color([0.08,0.08,0.12]) translate([44,0,BODY_Z+8]) hp_esp32_envelope("CTRL");
}

module side_hub(d=32,w=12,label="HUB") {
    color([0.025,0.025,0.025]) rotate([90,0,0]) cylinder(h=w,d=d,center=true);
    color([0.15,0.15,0.15]) rotate([90,0,0]) cylinder(h=w+4,d=11,center=true);
    translate([0,-w/2-4,-d/2]) rotate([90,0,0]) hp_revision_tag(label,size=1.7,height=0.35);
}

module link_plate(a=[0,0,0], b=[10,0,0], label="LINK") {
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
            translate([0,0,LINK_T/2+0.9]) hp_rounded_box([max(len-24,8),4,1.8], r=0.8);
        }
        for (x=[-len/2,len/2]) translate([x,0,0]) cylinder(h=LINK_T+4,d=PIVOT_CLEAR,center=true);
        translate([0,0,0]) hp_rounded_box([max(len-34,6),4,LINK_T+5], r=1);
    }
}

module claw_hoof() {
    color(BODY_BLACK) {
        // heel/base
        difference() {
            hull() {
                translate([-18,-8,0]) sphere(d=18);
                translate([18,-8,0]) sphere(d=18);
                translate([0,14,0]) sphere(d=16);
            }
            translate([0,0,-13]) cube([80,70,24],center=true);
        }
        // two forward talon pads, printed as one visual proxy for now
        translate([-13,20,2]) rotate([0,0,-10]) hp_rounded_box([12,28,7], r=3);
        translate([ 13,20,2]) rotate([0,0, 10]) hp_rounded_box([12,28,7], r=3);
    }
}

module hoof_adapter() {
    color(MECHANICAL_DARK)
    difference() {
        union() {
            hp_rounded_box([44,22,6], r=2.2);
            translate([0,0,7]) hp_rounded_box([28,15,8], r=1.6);
        }
        for (x=[-14,14]) translate([x,0,0]) cylinder(h=20,d=M3_CLEARANCE,center=true);
        translate([0,0,8]) rotate([90,0,0]) cylinder(h=28,d=PIVOT_CLEAR,center=true);
    }
}

module leg(side=1,x=80,front=true) {
    hip=[x,side*HIP_Y,BODY_Z-34];
    knee=[x+(front?-42:42),side*(HIP_Y+9),44];
    ankle=[x+(front?-4:4),side*(HIP_Y+13),18];
    foot=[x+(front?-20:20),side*(HIP_Y+18),2];

    // visible hub, servo tucked inward behind skirt armor
    color([0.055,0.055,0.055]) translate(hip+[0,-side*8,0]) rotate([0,0,0]) scale([0.78,0.9,0.78]) hp_standard_servo_envelope("S");
    translate(hip+[15,side*7,0]) side_hub(32,12,"HIP");
    translate(knee) side_hub(23,9,"KNEE");
    translate(ankle) side_hub(19,8,"ANK");

    color([0.035,0.035,0.035]) for (o=[-5,5]) {
        link_plate(hip+[0,o,-8],knee+[0,o,0],"UP");
        link_plate(knee+[0,o,0],ankle+[0,o,0],"LOW");
    }
    color([0.035,0.035,0.035]) link_plate(ankle,foot+[0,0,10],"PAST");

    translate(foot+[0,0,13]) hoof_adapter();
    translate(foot) rotate([0,0,side*8]) claw_hoof();
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

module print_layout() {
    translate([-120,72,0]) low_blade(88,18,4,"SIDE");
    translate([-30,72,0]) low_blade(52,16,3,"DORSAL");
    translate([44,72,0]) hoof_adapter();
    translate([110,72,0]) claw_hoof();
    translate([-108,0,0]) link_plate([-32,0,0],[32,0,0],"LINK64");
    translate([-18,0,0]) link_plate([-42,0,0],[42,0,0],"LINK84");
    translate([80,0,0]) side_hub(24,10,"HUB");
}

module assembly() {
    hardware();
    shell();
}

if (PART == "shell") shell();
else if (PART == "hardware") hardware();
else if (PART == "legset") legset();
else if (PART == "one_leg") leg(1,0,true);
else if (PART == "foot") claw_hoof();
else if (PART == "print_layout") print_layout();
else assembly();
