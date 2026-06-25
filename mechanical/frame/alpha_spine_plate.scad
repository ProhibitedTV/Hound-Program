/*
Hound Program // Alpha Spine Plate v0.1

Generic central body/spine plate for early layout and electronics mounting.
Not final chassis geometry. Used to reason about mounting, wiring, and service access.
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

PART = "spine_plate"; // spine_plate, electronics_mock, assembly

PLATE_LEN = 220;
PLATE_W = 82;
PLATE_THICK = 5;
RAIL_SPACING = 56;
RAIL_OD = CF_TUBE_12_OD;

module rail_mock() {
    for (y=[-RAIL_SPACING/2, RAIL_SPACING/2])
        translate([0,y,10]) rotate([0,90,0]) cylinder(h=PLATE_LEN+30, d=RAIL_OD, center=true);
}

module electronics_mock() {
    color([0.1,0.25,0.1]) translate([-45,0,14]) hp_rounded_box([65,56,4], r=2); // controller board
    color([0.1,0.1,0.12]) translate([35,0,16]) hp_rounded_box([72,38,18], r=3); // battery / payload volume
}

module spine_plate() {
    difference() {
        union() {
            hp_rounded_box([PLATE_LEN, PLATE_W, PLATE_THICK], r=4);
            // raised rails for stiffness
            for (y=[-PLATE_W/2+10, PLATE_W/2-10])
                translate([0,y,PLATE_THICK/2+3]) hp_rounded_box([PLATE_LEN-22,5,6], r=1.5);
            // center cable spine
            translate([0,0,PLATE_THICK/2+2]) hp_rounded_box([PLATE_LEN-28,10,4], r=1.5);
        }
        // lightening holes
        translate([0,0,0]) hp_hex_lightening_grid(width=PLATE_LEN-42, height=PLATE_W-22, hole_d=12, spacing=19, cut_depth=PLATE_THICK+12);
        // rail clamp mounting rows
        for (x=[-86,-38,38,86])
        for (y=[-RAIL_SPACING/2, RAIL_SPACING/2])
            translate([x,y,0]) hp_countersunk_m3(depth=18);
        // electronics grid
        for (x=[-60,-40,-20,0,20,40,60])
        for (y=[-20,0,20])
            translate([x,y,0]) cylinder(h=12, d=M3_CLEARANCE, center=true);
        // wire channels
        translate([0,0,0]) cube([PLATE_LEN-30,6,PLATE_THICK+8], center=true);
    }
    translate([0,-PLATE_W/2+7,PLATE_THICK/2+0.3]) hp_revision_tag("SPINE-A1", size=4);
}

module assembly() {
    spine_plate();
    rail_mock();
    electronics_mock();
}

if (PART == "spine_plate") spine_plate();
else if (PART == "electronics_mock") electronics_mock();
else assembly();
