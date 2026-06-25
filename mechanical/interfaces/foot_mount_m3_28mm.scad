/*
Hound Program // 28mm M3 Foot Interface Reference

This is a small reference part for the current foot interface.
It is not a final ankle. It defines the shared bolt pattern used by Alien Hoof Type A.

PART options:
- adapter_plate
- hole_gauge
- assembly
*/

$fn = 48;
PART = "assembly";

MOUNT_SPACING = 28;
M3_CLEAR = 3.4;
PLATE_L = 48;
PLATE_W = 24;
PLATE_H = 5;
TUBE_D = 12;

module rounded_box(size=[10,10,10], r=2) {
    hull() {
        for (x=[-size[0]/2+r,size[0]/2-r])
        for (y=[-size[1]/2+r,size[1]/2-r])
        for (z=[-size[2]/2+r,size[2]/2-r])
            translate([x,y,z]) sphere(r=r);
    }
}

module adapter_plate() {
    difference() {
        union() {
            rounded_box([PLATE_L,PLATE_W,PLATE_H], r=2);
            translate([0,0,PLATE_H/2+7]) rotate([90,0,0]) cylinder(d=TUBE_D+6,h=PLATE_W,center=true);
        }
        for (x=[-MOUNT_SPACING/2,MOUNT_SPACING/2])
            translate([x,0,0]) cylinder(d=M3_CLEAR,h=PLATE_H+20,center=true);
        translate([0,0,PLATE_H/2+7]) rotate([90,0,0]) cylinder(d=TUBE_D+0.4,h=PLATE_W+4,center=true);
    }
}

module hole_gauge() {
    difference() {
        rounded_box([42,14,3], r=1.2);
        for (x=[-MOUNT_SPACING/2,MOUNT_SPACING/2])
            translate([x,0,0]) cylinder(d=M3_CLEAR,h=8,center=true);
    }
    translate([0,-9,2]) linear_extrude(height=0.6)
        text("28mm M3", size=3.2, halign="center", valign="center", font="Liberation Sans:style=Bold");
}

module assembly() {
    adapter_plate();
    translate([0,38,0]) hole_gauge();
}

if (PART == "adapter_plate") adapter_plate();
else if (PART == "hole_gauge") hole_gauge();
else assembly();
