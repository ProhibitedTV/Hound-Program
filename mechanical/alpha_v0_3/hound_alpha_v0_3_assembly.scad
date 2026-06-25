/*
Hound Program // Hound Alpha v0.3 Articulated-Leg Assembly

Response to v0.2 screenshot review:
- v0.2 body direction improved, but legs still felt wrong.
- The legs needed an additional visible joint/segment.
- v0.3 adds a hip pod, upper link, knee, lower link, ankle/pastern, and hoof.

PART options:
- assembly
- bare_frame
- leg_layout
- silhouette
- print_layout
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

use <../body/alpha_exoshell_v02.scad>
use <../legs/articulated_leg_v03.scad>
use <../sensors/front_sensor_pod.scad>
use <../lighting/led_diffuser_modules.scad>
use <../audio/audio_grille_module.scad>
use <../feet/alien-hoof-type-a/hound_alien_hoof_v02.scad>
use <../interfaces/foot_mount_m3_28mm.scad>

$fn = 56;
PART = "assembly";

// Globals required by imported modules that still use file-level constants.
BODY_LEN = 236;
BODY_W = 86;
BODY_H = 44;
SHELL_T = 5;
POD_L = 64;
POD_W = 34;
POD_H = 24;
CAM_D = 12.5;
LED_SLOT_W = 46;
LED_SLOT_H = 4;
CHANNEL_L = 86;
CHANNEL_W = 12;
CHANNEL_H = 8;
DIFF_W = 4.2;
DIFF_H = 3.2;
GRILLE_W = 54;
GRILLE_H = 38;
GRILLE_T = 4;
ROUND_D = 32;
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

// Layout dimensions
BODY_Z = 96;
FRONT_X = 74;
REAR_X = -78;
LEG_Y = 58;

module rail_pair() {
    for (y=[-25,25])
        color([0.025,0.025,0.025]) translate([0,y,BODY_Z-8]) rotate([0,90,0]) cylinder(h=238,d=CF_TUBE_12_OD,center=true);
}

module refined_spine() {
    difference() {
        union() {
            color(MECHANICAL_DARK) translate([0,0,BODY_Z-14]) hp_rounded_box([214,56,8], r=3);
            color(MECHANICAL_DARK) translate([-20,0,BODY_Z-1]) hp_rounded_box([132,42,8], r=3);
            // front and rear belly keels make the underside feel less like a flat tray
            color([0.06,0.06,0.06]) translate([58,0,BODY_Z-25]) rotate([0,-8,0]) hp_rounded_box([58,18,10], r=3);
            color([0.06,0.06,0.06]) translate([-70,0,BODY_Z-25]) rotate([0,8,0]) hp_rounded_box([58,18,10], r=3);
        }
        for (x=[-74,-32,32,74]) for (y=[-18,18])
            translate([x,y,BODY_Z-10]) cylinder(h=20,d=M3_CLEARANCE,center=true);
        translate([0,0,BODY_Z-12]) hp_hex_lightening_grid(width=150,height=36,hole_d=8,spacing=14,cut_depth=18);
    }
}

module exoshell_dark() {
    color(BODY_BLACK) dorsal_shell();
    color([0.055,0.055,0.055]) side_cowl(1);
    color([0.055,0.055,0.055]) side_cowl(-1);
    color(ARMOR_DARK) top_armor_set();
    color([0.045,0.045,0.045]) side_armor_set(1);
    color([0.045,0.045,0.045]) side_armor_set(-1);
    sensor_slit();
}

module front_sensor_cluster() {
    // Smaller and tucked in; not a giant black snout.
    translate([118,0,BODY_Z+15]) scale([0.58,0.72,0.72]) color(BODY_BLACK) pod_shell();
    translate([102,0,BODY_Z+1]) scale([0.56,0.75,0.7]) color([0.04,0.04,0.04]) straight_channel();
}

module rear_audio_panel() {
    translate([-120,0,BODY_Z+4]) rotate([0,90,0]) scale([0.72,0.72,0.72]) color([0.04,0.04,0.04]) grille();
}

module placed_leg(x=0, side=1, front=true) {
    // Rotate whole local leg slightly so it tucks under the cowls and reads like a quadruped limb.
    translate([x,side*LEG_Y,0]) rotate([0,0,side*(front?4:-4)]) articulated_leg(side,front);
}

module leg_layout() {
    placed_leg(FRONT_X,1,true);
    placed_leg(FRONT_X,-1,true);
    placed_leg(REAR_X,1,false);
    placed_leg(REAR_X,-1,false);
}

module bare_frame() {
    rail_pair();
    refined_spine();
    leg_layout();
}

module silhouette() {
    translate([0,0,BODY_Z+18]) exoshell_dark();
    front_sensor_cluster();
    rear_audio_panel();
}

module assembly() {
    bare_frame();
    silhouette();
}

module print_layout() {
    translate([-120,80,0]) foot_core();
    translate([-25,80,0]) adapter_plate();
    translate([78,80,0]) articulated_leg(1,true);
    translate([-95,-65,0]) dorsal_shell();
    translate([86,-65,0]) side_cowl(1);
}

if (PART == "assembly") assembly();
else if (PART == "bare_frame") bare_frame();
else if (PART == "leg_layout") leg_layout();
else if (PART == "silhouette") silhouette();
else if (PART == "print_layout") print_layout();
else assembly();
