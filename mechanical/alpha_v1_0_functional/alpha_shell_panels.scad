/*
Hound Alpha v1.0 functional shell panels.

Split shell panels derived from the v0.9 silhouette.
These are not final bodywork, but they create real printable panel candidates:
- rear dorsal panel
- mid dorsal panel
- front wedge panel
- left/right side panels
- lower skirt panels
- sensor diffuser carriers

PART options:
- rear_dorsal
- mid_dorsal
- front_wedge
- side_rear
- side_mid
- side_front
- skirt
- sensor_carrier
- panels
- print_layout
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

$fn = 36;
PART = "panels";

module panel_base(len=90,w=32,t=4,label="PANEL", slots=true) {
    difference() {
        union() {
            hull() {
                translate([-len/2+10,0,0]) hp_rounded_box([20,w,t],r=2);
                translate([ len/2-22,0,2]) hp_rounded_box([38,w*0.84,t],r=1.7);
                translate([ len/2-6,0,5]) hp_rounded_box([12,w*0.42,t],r=1.2);
            }
            // stiffening ribs on inside face
            translate([0,0,-3]) hp_rounded_box([len-22,5,4],r=1.2);
            for (x=[-len/4,len/4]) translate([x,0,-3]) hp_rounded_box([5,w-10,4],r=1.2);
        }
        for (x=[-len/2+14,len/2-22]) for (y=[-w/2+8,w/2-8])
            translate([x,y,0]) cylinder(h=t+12,d=M3_CLEARANCE,center=true);
        if (slots)
            for (x=[-len/4,0,len/4]) translate([x,0,0]) hp_rounded_box([4,w-14,t+10],r=1);
    }
    translate([0,-w/2-3,t/2+0.2]) hp_revision_tag(label,size=2.4,height=0.45);
}

module rear_dorsal() { panel_base(100,48,4,"DORSAL-R",false); }
module mid_dorsal() { panel_base(112,50,4,"DORSAL-M",false); }
module front_wedge() { panel_base(92,38,4,"FRONT-WEDGE",false); }
module side_rear() { panel_base(88,18,4,"SIDE-R",true); }
module side_mid() { panel_base(112,20,4,"SIDE-M",true); }
module side_front() { panel_base(76,18,4,"SIDE-F",true); }

module skirt() {
    difference() {
        union() {
            hp_rounded_box([118,18,4],r=2);
            for (x=[-42,0,42]) translate([x,0,3]) hp_rounded_box([28,12,4],r=1.3);
        }
        for (x=[-48,48]) translate([x,0,0]) cylinder(h=12,d=M3_CLEARANCE,center=true);
        hp_rounded_box([86,5,12],r=1);
    }
    translate([0,-13,2.2]) hp_revision_tag("LOWER-SKIRT",size=2.2,height=0.45);
}

module sensor_carrier() {
    difference() {
        union() {
            hp_rounded_box([66,12,6],r=2);
            translate([0,0,5]) hp_rounded_box([58,5,5],r=1.2);
        }
        hp_rounded_box([52,4.4,9],r=1.1); // diffuser insert channel
        for (x=[-26,26]) translate([x,0,0]) cylinder(h=14,d=M2_CLEARANCE,center=true);
    }
    translate([0,-10,3.2]) hp_revision_tag("RED-SLIT",size=2.0,height=0.4);
}

module panels() {
    translate([-120,70,0]) rear_dorsal();
    translate([0,70,0]) mid_dorsal();
    translate([118,70,0]) front_wedge();
    translate([-120,15,0]) side_rear();
    translate([-10,15,0]) side_mid();
    translate([96,15,0]) side_front();
    translate([-75,-35,0]) skirt();
    translate([70,-35,0]) sensor_carrier();
}

module print_layout() { panels(); }

if (PART == "rear_dorsal") rear_dorsal();
else if (PART == "mid_dorsal") mid_dorsal();
else if (PART == "front_wedge") front_wedge();
else if (PART == "side_rear") side_rear();
else if (PART == "side_mid") side_mid();
else if (PART == "side_front") side_front();
else if (PART == "skirt") skirt();
else if (PART == "sensor_carrier") sensor_carrier();
else print_layout();
