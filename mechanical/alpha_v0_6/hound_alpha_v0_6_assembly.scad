/*
Hound Alpha v0.6 grounded concept assembly.

Purpose:
- regain the original long dark alien-machine silhouette
- hide square hardware boxes under faceted shell panels
- keep visible circular shoulder/hip hubs
- keep legs as printable paired links with real pivot holes
- reserve volume for common hobby boards, battery, servos, rails, and wiring

PART options:
- assembly
- hardware
- shell
- legset
- one_leg
- print_layout
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>
include <../lib/hound_hardware_envelopes.scad>

$fn = 32;
PART = "assembly";

BODY_Z = 96;
BODY_L = 286;
BODY_W = 84;
HIP_Y = 54;
FRONT_X = 82;
REAR_X = -86;
RAIL_Y = 24;

LINK_T = 5;
LINK_W = 13;
PIVOT_CLEAR = M4_CLEARANCE;

module blade_panel(len=70,w=20,t=4,label="ARMOR") {
    difference() {
        hull() {
            translate([-len/2+8,0,0]) hp_rounded_box([16,w,t], r=1.6);
            translate([ len/2-18,0,0]) hp_rounded_box([36,w*0.82,t], r=1.6);
            translate([ len/2-5,0,4]) hp_rounded_box([10,w*0.45,t], r=1.2);
        }
        for (x=[-len/2+12,len/2-18])
            translate([x,0,0]) cylinder(h=t+8,d=M3_CLEARANCE,center=true);
    }
    translate([0,-w/2-3,t/2+0.2]) hp_revision_tag(label,size=2.0,height=0.45);
}

module faceted_shell() {
    color(BODY_BLACK)
    difference() {
        union() {
            hull() {
                translate([-126,0,BODY_Z+6]) hp_rounded_box([52,54,22], r=3);
                translate([-46,0,BODY_Z+19]) hp_rounded_box([98,78,34], r=4);
                translate([54,0,BODY_Z+17]) hp_rounded_box([112,70,32], r=4);
                translate([122,0,BODY_Z+6]) hp_rounded_box([52,38,20], r=3);
            }
            // dorsal blades from the original concept, but printable as separate future panels
            translate([-50,0,BODY_Z+43]) hp_fin_plate(len=112,h=24,thick=6,sweep=-16);
            translate([32,0,BODY_Z+40]) hp_fin_plate(len=72,h=16,thick=5,sweep=-12);
            translate([-4,0,BODY_Z+50]) hp_fin_plate(len=48,h=18,thick=4,sweep=-8);
        }
        // hollow underside for frame and service access
        translate([-8,0,BODY_Z-4]) hp_rounded_box([230,54,32], r=4);
        // service tray opening
        translate([-16,0,BODY_Z+20]) hp_rounded_box([118,42,16], r=3);
    }
}

module armor_layers() {
    color(ARMOR_DARK) {
        for (x=[-94,-52,-10,32,74])
            translate([x,0,BODY_Z+42]) rotate([0,0,x/40]) blade_panel(34,20,3,"TOP");
        for (side=[-1,1]) {
            translate([-74,side*45,BODY_Z+10]) rotate([0,0,side*5]) blade_panel(78,18,4,"SIDE-R");
            translate([8,side*46,BODY_Z+12]) rotate([0,0,side*-2]) blade_panel(82,18,4,"SIDE-M");
            translate([82,side*42,BODY_Z+8]) rotate([0,0,side*-8]) blade_panel(58,16,4,"SIDE-F");
        }
    }
}

module red_channels() {
    color(SENSOR_RED) {
        translate([118,-25,BODY_Z+20]) rotate([0,-12,-11]) hp_rounded_box([48,4,4], r=1);
        translate([118,25,BODY_Z+20]) rotate([0,-12,11]) hp_rounded_box([48,4,4], r=1);
        translate([138,0,BODY_Z+6]) rotate([0,-18,0]) hp_rounded_box([28,4,5], r=1);
        translate([-24,0,BODY_Z+45]) hp_rounded_box([42,4,3], r=1);
        for (side=[-1,1]) translate([8,side*48,BODY_Z+20]) rotate([0,0,side*2]) hp_rounded_box([52,3,3], r=1);
    }
}

module frame_core() {
    color(MECHANICAL_DARK) translate([-8,0,BODY_Z-20]) hp_rounded_box([236,52,8], r=3);
    for (y=[-RAIL_Y,RAIL_Y])
        color([0.02,0.02,0.02]) translate([-8,y,BODY_Z-10]) rotate([0,90,0]) cylinder(h=258,d=CF_TUBE_12_OD,center=true);
    // cross members where legs attach
    for (x=[FRONT_X,REAR_X])
        color([0.05,0.05,0.05]) translate([x,0,BODY_Z-18]) hp_rounded_box([14,104,10], r=2);
}

module electronics_tray() {
    color([0.10,0.10,0.10]) translate([-36,0,BODY_Z-1]) hp_battery_envelope("BAT");
    color([0.08,0.10,0.08]) translate([48,0,BODY_Z+1]) hp_pca9685_envelope("PWM");
    color([0.08,0.08,0.12]) translate([48,0,BODY_Z+16]) hp_esp32_envelope("CTRL");
}

module pivot_hub(d=30,w=12,label="HUB") {
    color([0.035,0.035,0.035]) rotate([90,0,0]) cylinder(h=w,d=d,center=true);
    color([0.17,0.17,0.17]) rotate([90,0,0]) cylinder(h=w+4,d=PIVOT_CLEAR,center=true);
    translate([0,-w/2-4,-d/2]) rotate([90,0,0]) hp_revision_tag(label,size=1.8,height=0.4);
}

module link_plate_between(a=[0,0,0], b=[10,0,0], label="LINK") {
    dx = b[0]-a[0];
    dz = b[2]-a[2];
    len = sqrt(dx*dx + dz*dz);
    ang = -atan2(dz,dx);
    mid = [(a[0]+b[0])/2,(a[1]+b[1])/2,(a[2]+b[2])/2];
    translate(mid) rotate([0,ang,0])
    difference() {
        union() {
            hull() {
                translate([-len/2,0,0]) cylinder(h=LINK_T,d=16,center=true);
                translate([ len/2,0,0]) cylinder(h=LINK_T,d=16,center=true);
            }
            translate([0,0,LINK_T/2+1]) hp_rounded_box([max(len-24,8),4,2], r=0.9);
        }
        for (x=[-len/2,len/2]) translate([x,0,0]) cylinder(h=LINK_T+4,d=PIVOT_CLEAR,center=true);
        translate([0,0,0]) hp_rounded_box([max(len-34,6),4,LINK_T+6], r=1);
    }
}

module hoof_shape() {
    color(BODY_BLACK)
    difference() {
        hull() {
            translate([-18,-7,0]) sphere(d=20);
            translate([18,-7,0]) sphere(d=20);
            translate([0,18,0]) sphere(d=20);
        }
        translate([0,0,-14]) cube([80,80,24],center=true);
    }
}

module hoof_adapter() {
    color(MECHANICAL_DARK)
    difference() {
        union() {
            hp_rounded_box([46,24,6], r=2.4);
            translate([0,0,7]) hp_rounded_box([28,16,8], r=1.8);
        }
        for (x=[-14,14]) translate([x,0,0]) cylinder(h=20,d=M3_CLEARANCE,center=true);
        translate([0,0,8]) rotate([90,0,0]) cylinder(h=30,d=PIVOT_CLEAR,center=true);
    }
}

module leg(side=1,x=70,front=true) {
    hip=[x,side*HIP_Y,BODY_Z-24];
    knee=[x+(front?-38:38),side*(HIP_Y+7),50];
    ankle=[x+(front?0:0),side*(HIP_Y+11),22];
    foot=[x+(front?-16:16),side*(HIP_Y+15),5];

    // servo box tucked under armor, not visually dominant
    color([0.055,0.055,0.055]) translate(hip+[0,side*2,0]) scale([0.92,0.92,0.92]) hp_standard_servo_envelope("S");

    translate(hip+[15,side*9,0]) pivot_hub(34,14,"HIP");
    translate(knee) pivot_hub(24,10,"KNEE");
    translate(ankle) pivot_hub(20,9,"ANKLE");

    color([0.035,0.035,0.035]) for (o=[-5,5]) {
        link_plate_between(hip+[0,o,-9],knee+[0,o,0],"UP");
        link_plate_between(knee+[0,o,0],ankle+[0,o,0],"LOW");
    }
    color([0.035,0.035,0.035]) link_plate_between(ankle,foot+[0,0,10],"PAST");

    translate(foot+[0,0,13]) hoof_adapter();
    translate(foot) rotate([0,0,side*8]) hoof_shape();
}

module legset() {
    for (side=[-1,1]) {
        leg(side,FRONT_X,true);
        leg(side,REAR_X,false);
    }
}

module hardware() {
    frame_core();
    electronics_tray();
    legset();
}

module shell() {
    faceted_shell();
    armor_layers();
    red_channels();
}

module print_layout() {
    translate([-120,70,0]) blade_panel(78,18,4,"SIDE");
    translate([-38,70,0]) blade_panel(34,20,3,"TOP");
    translate([45,70,0]) hoof_adapter();
    translate([105,70,0]) hoof_shape();
    translate([-105,0,0]) link_plate_between([-30,0,0],[30,0,0],"LINK60");
    translate([-20,0,0]) link_plate_between([-42,0,0],[42,0,0],"LINK84");
    translate([86,0,0]) pivot_hub(24,10,"HUB");
}

module assembly() {
    hardware();
    shell();
}

if (PART == "hardware") hardware();
else if (PART == "shell") shell();
else if (PART == "legset") legset();
else if (PART == "one_leg") leg(1,0,true);
else if (PART == "print_layout") print_layout();
else assembly();
