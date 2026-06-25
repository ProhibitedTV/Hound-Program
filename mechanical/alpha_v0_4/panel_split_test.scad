/*
Alpha v0.4 panel split test.
Small panel experiments for converting the concept shell into separate printable pieces.
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

$fn = 36;
PART = "layout";

module panel_blank(len=96,w=42,t=4,label="PANEL") {
    difference() {
        union() {
            hp_rounded_box([len,w,t], r=3);
            for (x=[-len/2+15,len/2-15])
                translate([x,0,t/2+1.5]) hp_rounded_box([22,w-10,3], r=1.5);
        }
        for (x=[-len/2+12,len/2-12]) for (y=[-w/2+9,w/2-9])
            translate([x,y,0]) cylinder(h=t+8,d=M3_CLEARANCE,center=true);
    }
    translate([0,-w/2-3,t/2+0.2]) hp_revision_tag(label,size=2.8,height=0.5);
}

module dorsal_rear() { panel_blank(100,56,4,"DORSAL-R"); }
module dorsal_front() { panel_blank(88,48,4,"DORSAL-F"); }
module side_panel() { panel_blank(96,30,4,"SIDE-PNL"); }
module coupon() { panel_blank(56,22,5,"M3-CPN"); }

module layout() {
    translate([-70,45,0]) dorsal_rear();
    translate([70,45,0]) dorsal_front();
    translate([-70,-30,0]) side_panel();
    translate([60,-30,0]) coupon();
}

if (PART == "dorsal_rear") dorsal_rear();
else if (PART == "dorsal_front") dorsal_front();
else if (PART == "side_panel") side_panel();
else if (PART == "coupon") coupon();
else layout();
