/*
Hound Program OpenSCAD primitive helpers
*/

include <hound_constants.scad>

module hp_rounded_box(size=[10,10,10], r=2) {
    hull() {
        for (x=[-size[0]/2+r, size[0]/2-r])
        for (y=[-size[1]/2+r, size[1]/2-r])
        for (z=[-size[2]/2+r, size[2]/2-r])
            translate([x,y,z]) sphere(r=r);
    }
}

module hp_teardrop_hole(d=3.2, h=10, axis="x") {
    if (axis == "x") {
        rotate([0,90,0]) hp_teardrop_profile(d=d, h=h);
    } else if (axis == "y") {
        rotate([90,0,0]) hp_teardrop_profile(d=d, h=h);
    } else {
        hp_teardrop_profile(d=d, h=h);
    }
}

module hp_teardrop_profile(d=3.2, h=10) {
    union() {
        cylinder(h=h, d=d, center=true);
        translate([0,d*0.25,0]) rotate([0,0,45]) cube([d*0.72,d*0.72,h], center=true);
    }
}

module hp_countersunk_m3(depth=16, head_depth=3.2) {
    cylinder(h=depth, d=M3_CLEARANCE, center=true);
    translate([0,0,depth/2-head_depth/2]) cylinder(h=head_depth+0.2, d=M3_HEAD_D, center=true);
}

module hp_insert_socket_m3(depth=M3_INSERT_DEPTH) {
    cylinder(h=depth, d=M3_INSERT_D, center=true);
}

module hp_hex_lightening_grid(width=80, height=40, hole_d=9, spacing=14, cut_depth=10) {
    for (x=[-width/2:spacing:width/2])
    for (y=[-height/2:spacing*0.866:height/2]) {
        translate([x + ((floor((y+height/2)/(spacing*0.866)) % 2) * spacing/2), y, 0])
            cylinder(h=cut_depth, d=hole_d, center=true, $fn=6);
    }
}

module hp_revision_tag(txt="HP-R0", size=4, height=0.8) {
    linear_extrude(height=height)
        text(txt, size=size, halign="center", valign="center", font="Liberation Sans:style=Bold");
}

module hp_fin_plate(len=50, h=20, thick=4, sweep=0) {
    rotate([0,sweep,0])
    polyhedron(
        points=[
            [0,-thick/2,0],[0,thick/2,0],
            [len,-thick/2,0],[len,thick/2,0],
            [len*0.66,-thick/2,h],[len*0.66,thick/2,h]
        ],
        faces=[[0,2,3,1],[2,4,5,3],[0,1,5,4],[0,4,2],[1,3,5]]
    );
}

module hp_armor_scale(len=24, w=12, h=2.2, r=1.0) {
    hp_rounded_box([len,w,h], r=r);
}
