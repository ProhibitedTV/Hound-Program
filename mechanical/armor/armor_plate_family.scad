/*
Hound Program // Armor Plate Family v0.1

Non-load-bearing identity plates for silhouette, paneling, expression experiments, and visual language.
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

PART = "layout"; // small_panel, medium_panel, cheek_panel, dorsal_panel, layout

module mounting_tabs(spacing=28) {
    for (x=[-spacing/2, spacing/2]) {
        translate([x,0,-1.5]) hp_rounded_box([8,8,3], r=1.2);
    }
}

module panel_base(len=48, w=22, h=3, taper=0.72) {
    hull() {
        translate([0,0,0]) hp_rounded_box([len,w,h], r=1.8);
        translate([len*0.12,0,h*0.8]) scale([taper,0.70,0.45]) hp_rounded_box([len,w,h], r=1.2);
    }
}

module small_panel() {
    difference() {
        union() {
            panel_base(len=28,w=14,h=3,taper=0.68);
            mounting_tabs(spacing=18);
        }
        for (x=[-9,9]) translate([x,0,-2]) cylinder(h=8,d=M2_CLEARANCE,center=true);
    }
}

module medium_panel() {
    difference() {
        union() {
            panel_base(len=46,w=21,h=4,taper=0.72);
            mounting_tabs(spacing=30);
        }
        for (x=[-15,15]) translate([x,0,-2]) cylinder(h=10,d=M2_CLEARANCE,center=true);
        translate([0,0,2.8]) hp_revision_tag("ARM-M1", size=3);
    }
}

module cheek_panel() {
    difference() {
        union() {
            rotate([0,-8,0]) panel_base(len=72,w=26,h=5,taper=0.58);
            translate([-22,0,-1]) mounting_tabs(spacing=38);
        }
        for (x=[-41,-3]) translate([x,0,-4]) cylinder(h=14,d=M25_CLEARANCE,center=true);
        translate([8,0,3]) cube([36,4,4],center=true);
    }
}

module dorsal_panel() {
    difference() {
        union() {
            hp_fin_plate(len=92,h=34,thick=5,sweep=-8);
            translate([18,0,-2]) hp_rounded_box([42,14,4],r=1.5);
        }
        for (x=[8,30]) translate([x,0,-2]) cylinder(h=12,d=M25_CLEARANCE,center=true);
    }
}

module layout() {
    translate([-70,30,0]) small_panel();
    translate([-25,30,0]) medium_panel();
    translate([45,30,0]) cheek_panel();
    translate([-5,-35,0]) dorsal_panel();
}

if (PART == "small_panel") small_panel();
else if (PART == "medium_panel") medium_panel();
else if (PART == "cheek_panel") cheek_panel();
else if (PART == "dorsal_panel") dorsal_panel();
else layout();
