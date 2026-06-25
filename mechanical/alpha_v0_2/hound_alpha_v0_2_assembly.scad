/*
Hound Program // Hound Alpha v0.2 Refined Assembly

This is the first elegance pass after opening v0.1 in OpenSCAD.
The v0.1 assembly proved the repo could assemble parts, but visually it was too boxy.
V0.2 prioritizes silhouette:
- lower stance
- longer body line
- tucked hip modules
- angled legs instead of vertical sticks
- v0.2 alien hoof
- refined exoshell that looks like a single machine

PART options:
- assembly
- bare_frame
- silhouette
- print_layout
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

use <../body/alpha_exoshell_v02.scad>
use <../feet/alien-hoof-type-a/hound_alien_hoof_v02.scad>
use <../interfaces/foot_mount_m3_28mm.scad>
use <../joints/hip_module.scad>
use <../legs/leg_link_set.scad>
use <../sensors/front_sensor_pod.scad>
use <../lighting/led_diffuser_modules.scad>
use <../audio/audio_grille_module.scad>
use <../cable_management/cable_clip_set.scad>

$fn = 56;
PART = "assembly";

// Restated globals for modules imported with use.
// This is v0.2-compatible until the library is fully parameterized.
BODY_LEN = 236;
BODY_W = 86;
BODY_H = 44;
SHELL_T = 5;
FOOT_LEN = 62;
FOOT_W = 68;
FOOT_H = 18;
TOP_SCALE = 0.78;
RIM_H = 3;
MOUNT_SPACING = 28;
M3_CLEAR = 3.4;
M3_HEAD = 6.8;
COUNTER_H = 3.2;
BOSS_D = 13;
BOSS_H = 6;
COAT = 1.2;
MODULE_L = 74;
MODULE_W = 44;
MODULE_H = 48;
OUTPUT_D = 18;
BEARING_OD = 16;
BEARING_ID = 5;
UPPER_LEN = 72;
LOWER_LEN = 82;
LINK_W = 18;
LINK_T = 6;
PIVOT_D = M4_CLEARANCE;
PIVOT_BOSS_D = 16;
TUBE_OD = CF_TUBE_10_OD;
POD_L = 64;
POD_W = 34;
POD_H = 24;
CAM_D = 12.5;
LED_SLOT_W = 46;
LED_SLOT_H = 4;
GRILLE_W = 54;
GRILLE_H = 38;
GRILLE_T = 4;
ROUND_D = 32;
CHANNEL_L = 86;
CHANNEL_W = 12;
CHANNEL_H = 8;
DIFF_W = 4.2;
DIFF_H = 3.2;

// Layout
BODY_Z = 92;
HIP_X_FRONT = 74;
HIP_X_REAR = -76;
HIP_Y = 56;
HIP_Z = 72;
FOOT_Z = 0;

module rail_pair() {
    for (y=[-25,25])
        color([0.025,0.025,0.025]) translate([0,y,BODY_Z-4]) rotate([0,90,0]) cylinder(h=238,d=CF_TUBE_12_OD,center=true);
}

module refined_spine() {
    difference() {
        union() {
            color(MECHANICAL_DARK) translate([0,0,BODY_Z-10]) hp_rounded_box([210,56,8], r=3);
            color(MECHANICAL_DARK) translate([-20,0,BODY_Z+4]) hp_rounded_box([132,42,8], r=3);
        }
        for (x=[-74,-32,32,74]) for (y=[-18,18])
            translate([x,y,BODY_Z-6]) cylinder(h=20,d=M3_CLEARANCE,center=true);
        translate([0,0,BODY_Z-8]) hp_hex_lightening_grid(width=150,height=36,hole_d=8,spacing=14,cut_depth=18);
    }
}

module hip_pair(x=0, front=true) {
    for (side=[-1,1]) {
        translate([x,side*HIP_Y,HIP_Z]) rotate([0,0,side>0?0:180]) color(MECHANICAL_DARK) module_body();
    }
}

module angled_leg(x=0, side=1, front=true) {
    // More animal-like stance than v0.1: knee tucked inward, foot slightly outward/back.
    knee_x = x + (front ? -20 : 20);
    foot_x = x + (front ? -38 : 38);
    hip = [x, side*HIP_Y, HIP_Z+10];
    knee = [knee_x, side*(HIP_Y+8), 42];
    ankle = [foot_x, side*(HIP_Y+12), 18];

    color([0.075,0.075,0.075]) hull(){ translate(hip) sphere(d=12); translate(knee) sphere(d=10); }
    color([0.075,0.075,0.075]) hull(){ translate(knee) sphere(d=10); translate(ankle) sphere(d=9); }

    // Small joint discs so it reads engineered, not a stick figure.
    color(MECHANICAL_DARK) translate(hip) rotate([90,0,0]) cylinder(h=10,d=20,center=true);
    color(MECHANICAL_DARK) translate(knee) rotate([90,0,0]) cylinder(h=9,d=18,center=true);
    color(MECHANICAL_DARK) translate(ankle) rotate([90,0,0]) cylinder(h=8,d=16,center=true);

    translate([foot_x, side*(HIP_Y+14), FOOT_Z+8]) rotate([0,0,side*8]) color(BODY_BLACK) foot_core();
}

module legs_all() {
    for (side=[-1,1]) {
        angled_leg(HIP_X_FRONT,side,true);
        angled_leg(HIP_X_REAR,side,false);
    }
}

module refined_body() {
    rail_pair();
    refined_spine();
    translate([0,0,BODY_Z+18]) assembly_exoshell_proxy();
}

module assembly_exoshell_proxy() {
    // Use renamed wrapper to avoid name collision with this file's assembly().
    dorsal_shell();
    side_cowl(1);
    side_cowl(-1);
    top_armor_set();
    side_armor_set(1);
    side_armor_set(-1);
    sensor_slit();
}

module front_cluster() {
    translate([126,0,BODY_Z+23]) rotate([0,0,0]) color(BODY_BLACK) pod_shell();
    translate([112,0,BODY_Z+3]) color([0.03,0.03,0.03]) straight_channel();
}

module rear_audio_panel() {
    translate([-118,0,BODY_Z+10]) rotate([0,90,0]) color(ARMOR_DARK) grille();
}

module cable_detail() {
    for (x=[-52,0,52])
        translate([x,0,BODY_Z-23]) color(MECHANICAL_DARK) cable_clip(6,"CLIP-6");
}

module bare_frame() {
    rail_pair();
    refined_spine();
    hip_pair(HIP_X_FRONT,true);
    hip_pair(HIP_X_REAR,false);
    legs_all();
}

module silhouette() {
    refined_body();
    front_cluster();
    rear_audio_panel();
}

module assembly() {
    bare_frame();
    silhouette();
    cable_detail();
}

module print_layout() {
    translate([-120,80,0]) foot_core();
    translate([-30,80,0]) adapter_plate();
    translate([70,80,0]) module_body();
    translate([-110,0,0]) upper_link();
    translate([-30,0,0]) lower_link();
    translate([65,0,0]) pod_shell();
    translate([-90,-75,0]) dorsal_shell();
    translate([80,-75,0]) side_cowl(1);
}

if (PART == "assembly") assembly();
else if (PART == "bare_frame") bare_frame();
else if (PART == "silhouette") silhouette();
else if (PART == "print_layout") print_layout();
else assembly();
