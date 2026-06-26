/* Alpha v0.5 concept hardware assembly. */

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

$fn = 32;
PART = "assembly";

BODY_Z = 96;
BODY_L = 270;
BODY_W = 82;
HIP_Y = 52;

STD_SERVO_X = 41;
STD_SERVO_Y = 21;
STD_SERVO_Z = 41;
BOARD_A = [63,26,8];
BOARD_B = [56,30,12];
BATTERY = [110,35,28];

module board_box(size=[40,20,8]) { hp_rounded_box(size, r=1.5); }

module shell_body() {
    color(BODY_BLACK)
    difference() {
        union() {
            hull() {
                translate([-116,0,BODY_Z+8]) hp_rounded_box([48,52,22], r=4);
                translate([-32,0,BODY_Z+20]) hp_rounded_box([112,76,36], r=5);
                translate([82,0,BODY_Z+13]) hp_rounded_box([94,54,28], r=4);
                translate([128,0,BODY_Z+4]) hp_rounded_box([28,30,16], r=3);
            }
            translate([-40,0,BODY_Z+42]) hp_fin_plate(len=120,h=22,thick=6,sweep=-14);
            translate([28,0,BODY_Z+38]) hp_fin_plate(len=78,h=14,thick=5,sweep=-10);
        }
        translate([-8,0,BODY_Z-4]) hp_rounded_box([212,52,34], r=4);
    }
}

module light_channels() {
    color(SENSOR_RED) {
        translate([106,-24,BODY_Z+20]) rotate([0,-12,-10]) hp_rounded_box([50,4,4], r=1);
        translate([106,24,BODY_Z+20]) rotate([0,-12,10]) hp_rounded_box([50,4,4], r=1);
        translate([130,0,BODY_Z+6]) rotate([0,-18,0]) hp_rounded_box([26,4,5], r=1);
        translate([-28,0,BODY_Z+45]) hp_rounded_box([34,4,3], r=1);
    }
}

module frame_core() {
    color(MECHANICAL_DARK) translate([-10,0,BODY_Z-20]) hp_rounded_box([220,50,8], r=3);
    for (y=[-23,23]) color([0.02,0.02,0.02]) translate([-8,y,BODY_Z-10]) rotate([0,90,0]) cylinder(h=245,d=CF_TUBE_12_OD,center=true);
}

module electronics() {
    color([0.10,0.10,0.10]) translate([-32,0,BODY_Z-2]) board_box(BATTERY);
    color([0.12,0.12,0.12]) translate([50,0,BODY_Z+2]) board_box(BOARD_A);
    color([0.14,0.14,0.14]) translate([52,0,BODY_Z+16]) board_box(BOARD_B);
}

module servo_box() { hp_rounded_box([STD_SERVO_X,STD_SERVO_Y,STD_SERVO_Z], r=3); }

module hub(pos=[0,0,0], d=32) {
    color([0.035,0.035,0.035]) translate(pos) rotate([90,0,0]) cylinder(h=14,d=d,center=true);
    color([0.16,0.16,0.16]) translate(pos) rotate([90,0,0]) cylinder(h=18,d=12,center=true);
}

module bar(a=[0,0,0], b=[10,0,0], d=7) { hull() { translate(a) sphere(d=d); translate(b) sphere(d=d); } }

module foot_pad() {
    difference() {
        hull() {
            translate([-18,-7,0]) sphere(d=20);
            translate([18,-7,0]) sphere(d=20);
            translate([0,18,0]) sphere(d=20);
        }
        translate([0,0,-14]) cube([80,80,24],center=true);
    }
}

module leg(side=1, x=60, front=true) {
    hip=[x,side*HIP_Y,BODY_Z-24];
    knee=[x+(front?-34:34),side*(HIP_Y+6),48];
    ankle=[x+(front?2:-2),side*(HIP_Y+10),22];
    foot=[x+(front?-14:14),side*(HIP_Y+14),5];

    color([0.06,0.06,0.06]) translate(hip) servo_box();
    hub(hip+[14,side*9,0],32);
    hub(knee,24);
    hub(ankle,20);

    color([0.035,0.035,0.035]) for (o=[-4,4]) bar(hip+[0,o,-8],knee+[0,o,0],7);
    color([0.035,0.035,0.035]) for (o=[-4,4]) bar(knee+[0,o,0],ankle+[0,o,0],7);
    color([0.035,0.035,0.035]) bar(ankle,foot+[0,0,8],7);
    color(BODY_BLACK) translate(foot) foot_pad();
}

module legs() { for (side=[-1,1]) { leg(side,72,true); leg(side,-78,false); } }

module assembly() { frame_core(); electronics(); legs(); shell_body(); light_channels(); }
module hardware() { frame_core(); electronics(); legs(); }
module shell() { shell_body(); light_channels(); }

if (PART == "hardware") hardware();
else if (PART == "shell") shell();
else assembly();
