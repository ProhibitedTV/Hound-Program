/*
Hound Alpha v0.8 concept-rooted assembly.

This pass responds to the v0.7 render and pulls the model back toward the
original concept sheet and the Alien Hoof Type A foot direction.

v0.8 design intent:
- long low front-heavy alien animal profile
- faceted black exoshell with broken armor plates
- red sensor slits instead of a face
- visible round shoulder/hip hub covers
- legs mounted under the shell, not as external box modules
- Type A tri-lobed alien hoof proxy, not block feet
- common hobby hardware envelopes still available in hardware view

PART options:
- assembly
- shell
- hardware
- legset
- one_leg
- hoof
- print_layout
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>
include <../lib/hound_hardware_envelopes.scad>

$fn = 36;
PART = "assembly";

BODY_Z = 88;
FRONT_X = 104;
REAR_X = -94;
HIP_Y = 56;
RAIL_Y = 24;
PIVOT_CLEAR = M4_CLEARANCE;
LINK_T = 5;

module facet_box(size=[10,10,10], r=2) {
    hp_rounded_box(size,r=r);
}

module armor_shard(len=64,w=18,t=4,label="PLATE") {
    difference() {
        hull() {
            translate([-len/2+8,0,0]) facet_box([16,w,t],r=1.3);
            translate([ len/2-22,0,2]) facet_box([34,w*0.82,t],r=1.2);
            translate([ len/2-5,0,5]) facet_box([10,w*0.38,t],r=0.8);
        }
        for (x=[-len/2+12,len/2-20])
            translate([x,0,0]) cylinder(h=t+8,d=M3_CLEARANCE,center=true);
    }
}

module concept_shell_core() {
    color(BODY_BLACK)
    difference() {
        union() {
            // The concept art reads like a wedge-headed alien animal.
            hull() {
                translate([-150,0,BODY_Z+4]) facet_box([36,46,18],r=2.5);   // narrow tail
                translate([-82,0,BODY_Z+12]) facet_box([84,70,26],r=3.5);   // rear shoulders
                translate([18,0,BODY_Z+16]) facet_box([126,78,30],r=3.5);   // main chest/body
                translate([112,0,BODY_Z+10]) facet_box([78,54,22],r=3.0);   // head wedge base
                translate([154,0,BODY_Z-2]) facet_box([22,26,12],r=2.0);    // sensor snout taper
            }
            // lower forward mandible/keel, like the concept head but still a sensor pod, not a face
            translate([136,0,BODY_Z-14]) rotate([0,-10,0]) facet_box([48,32,10],r=2);
            // rear low tail cover
            translate([-142,0,BODY_Z-8]) rotate([0,6,0]) facet_box([44,34,10],r=2);
        }
        // hollow/service underside
        translate([-8,0,BODY_Z-14]) facet_box([270,54,34],r=4);
        // removable tray opening on top
        translate([-28,0,BODY_Z+18]) facet_box([132,44,16],r=3);
        // front sensor cavity
        translate([150,0,BODY_Z+0]) rotate([0,-8,0]) facet_box([28,20,10],r=1.5);
    }
}

module dorsal_armor() {
    color(ARMOR_DARK) {
        // lower, more concept-sheet-like dorsal blades: swept, not goofy tall shark fins
        translate([-72,0,BODY_Z+30]) rotate([0,-16,0]) armor_shard(100,17,4,"DORSAL-R");
        translate([0,0,BODY_Z+31]) rotate([0,-13,0]) armor_shard(86,16,4,"DORSAL-M");
        translate([62,0,BODY_Z+27]) rotate([0,-10,0]) armor_shard(62,14,3,"DORSAL-F");
        // fractured top armor plates
        for (x=[-96,-48,4,52,96])
            translate([x,0,BODY_Z+33+(x%2)]) rotate([0,0,x/55]) armor_shard(30,18,3,"TOP");
    }
}

module side_armor_layers() {
    for (side=[-1,1]) {
        color(ARMOR_DARK) {
            translate([-98,side*43,BODY_Z+2]) rotate([0,0,side*4]) armor_shard(84,16,4,"REAR-SIDE");
            translate([-18,side*47,BODY_Z+5]) rotate([0,0,side*1]) armor_shard(104,18,4,"MID-SIDE");
            translate([78,side*42,BODY_Z+2]) rotate([0,0,side*-9]) armor_shard(76,16,4,"FRONT-SIDE");
        }
        // dark skirt hides rectangular electronics/servo bodies but leaves round hubs visible
        color([0.018,0.018,0.018]) translate([-12,side*38,BODY_Z-13]) facet_box([214,6,16],r=2);
    }
}

module red_sensor_language() {
    color(SENSOR_RED) {
        // front slashes match the concept language; no circular eyes
        translate([134,-23,BODY_Z+15]) rotate([0,-17,-13]) facet_box([58,4,4],r=1);
        translate([134, 23,BODY_Z+15]) rotate([0,-17, 13]) facet_box([58,4,4],r=1);
        translate([154,0,BODY_Z-5]) rotate([0,-22,0]) facet_box([28,4,5],r=1);
        translate([-22,0,BODY_Z+35]) facet_box([42,4,3],r=1);
        for (side=[-1,1]) {
            translate([-28,side*50,BODY_Z+13]) facet_box([58,3,3],r=1);
            translate([74,side*46,BODY_Z+11]) facet_box([32,3,3],r=1);
        }
    }
}

module shell() {
    concept_shell_core();
    dorsal_armor();
    side_armor_layers();
    red_sensor_language();
}

module frame_core() {
    color(MECHANICAL_DARK) translate([-8,0,BODY_Z-30]) facet_box([258,50,8],r=3);
    for (y=[-RAIL_Y,RAIL_Y])
        color([0.02,0.02,0.02]) translate([-8,y,BODY_Z-21]) rotate([0,90,0]) cylinder(h=286,d=CF_TUBE_12_OD,center=true);
    for (x=[FRONT_X,REAR_X])
        color([0.055,0.055,0.055]) translate([x,0,BODY_Z-29]) facet_box([14,112,10],r=2);
}

module electronics_stack() {
    color([0.10,0.10,0.10]) translate([-48,0,BODY_Z-12]) scale([0.92,0.92,0.92]) hp_battery_envelope("BAT");
    color([0.08,0.10,0.08]) translate([42,0,BODY_Z-9]) hp_pca9685_envelope("PWM");
    color([0.08,0.08,0.12]) translate([44,0,BODY_Z+5]) hp_esp32_envelope("CTRL");
}

module side_hub(d=30,w=12,label="HUB") {
    color([0.02,0.02,0.02]) rotate([90,0,0]) cylinder(h=w,d=d,center=true);
    color([0.16,0.16,0.16]) rotate([90,0,0]) cylinder(h=w+4,d=10,center=true);
}

module link_plate(a=[0,0,0], b=[10,0,0]) {
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
            translate([0,0,LINK_T/2+0.9]) facet_box([max(len-24,8),4,1.8],r=0.8);
        }
        for (x=[-len/2,len/2]) translate([x,0,0]) cylinder(h=LINK_T+4,d=PIVOT_CLEAR,center=true);
        translate([0,0,0]) facet_box([max(len-34,6),4,LINK_T+5],r=1);
    }
}

module alien_hoof_type_a() {
    // Proxy of the Type A tri-lobed hoof: rounded rear lobes plus forward hoof lobe.
    color(BODY_BLACK)
    difference() {
        union() {
            hull() {
                translate([-19,-8,0]) sphere(d=21);
                translate([ 19,-8,0]) sphere(d=21);
                translate([0,18,0]) sphere(d=22);
            }
            translate([0,0,8]) facet_box([42,22,10],r=3);
            // shallow coating-retention rim cue
            translate([0,0,3]) difference() {
                hull() {
                    translate([-20,-9,0]) sphere(d=8);
                    translate([20,-9,0]) sphere(d=8);
                    translate([0,20,0]) sphere(d=8);
                }
                translate([0,0,0]) facet_box([30,24,12],r=3);
            }
        }
        translate([0,0,-14]) cube([84,80,24],center=true);
        // tread/channel cuts
        for (a=[0,120,240]) rotate([0,0,a]) translate([0,16,1]) facet_box([5,20,8],r=1.2);
    }
}

module hoof_adapter_28mm() {
    color(MECHANICAL_DARK)
    difference() {
        union() {
            facet_box([46,24,6],r=2.2);
            translate([0,0,7]) facet_box([30,16,8],r=1.6);
        }
        for (x=[-14,14]) translate([x,0,0]) cylinder(h=20,d=M3_CLEARANCE,center=true);
        translate([0,0,8]) rotate([90,0,0]) cylinder(h=30,d=PIVOT_CLEAR,center=true);
    }
}

module leg(side=1,x=80,front=true) {
    hip=[x,side*HIP_Y,BODY_Z-37];
    knee=[x+(front?-48:48),side*(HIP_Y+9),42];
    ankle=[x+(front?-6:6),side*(HIP_Y+14),18];
    foot=[x+(front?-22:22),side*(HIP_Y+18),2];

    // servo envelope tucked inward; side hub remains the visible concept feature
    color([0.050,0.050,0.050]) translate(hip+[0,-side*9,0]) scale([0.72,0.88,0.72]) hp_standard_servo_envelope("S");
    translate(hip+[15,side*7,0]) side_hub(32,12,"HIP");
    translate(knee) side_hub(23,9,"KNEE");
    translate(ankle) side_hub(19,8,"ANK");

    color([0.035,0.035,0.035]) for (o=[-5,5]) {
        link_plate(hip+[0,o,-8],knee+[0,o,0]);
        link_plate(knee+[0,o,0],ankle+[0,o,0]);
    }
    color([0.035,0.035,0.035]) link_plate(ankle,foot+[0,0,10]);

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

module print_layout() {
    translate([-122,72,0]) armor_shard(84,16,4,"SIDE");
    translate([-32,72,0]) armor_shard(52,16,3,"TOP");
    translate([42,72,0]) hoof_adapter_28mm();
    translate([110,72,0]) alien_hoof_type_a();
    translate([-108,0,0]) link_plate([-34,0,0],[34,0,0]);
    translate([-18,0,0]) link_plate([-46,0,0],[46,0,0]);
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
else if (PART == "hoof") alien_hoof_type_a();
else if (PART == "print_layout") print_layout();
else assembly();
