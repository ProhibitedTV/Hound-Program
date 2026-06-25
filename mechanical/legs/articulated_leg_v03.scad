/*
Hound Program // Articulated Leg v0.3

This replaces the v0.2 stick-leg placeholder with a more believable alien quadruped leg.
The goal is visual and mechanical plausibility:
- hip/shoulder output joint tucked under the body
- upper link
- knee joint
- lower link
- ankle/pastern joint
- short foot adapter before the hoof

This does not imply an actively powered ankle yet. The ankle/pastern can be passive or fixed
in early prototypes, but it makes the leg read correctly and gives the foot a serviceable mount.

PART options:
- leg_front_left
- leg_front_right
- leg_rear_left
- leg_rear_right
- joint_set
- foot_proxy
- layout
*/

include <../lib/hound_constants.scad>
include <../lib/hound_primitives.scad>

$fn = 56;
PART = "layout";

module capsule_between(p1=[0,0,0], p2=[10,0,0], d=8) {
    hull() {
        translate(p1) sphere(d=d);
        translate(p2) sphere(d=d);
    }
}

module joint_disc(d=22, w=8, axis="y") {
    color(MECHANICAL_DARK)
    if (axis == "y") rotate([90,0,0]) cylinder(h=w,d=d,center=true);
    else if (axis == "x") rotate([0,90,0]) cylinder(h=w,d=d,center=true);
    else cylinder(h=w,d=d,center=true);
}

module joint_hub(d=18) {
    color([0.05,0.05,0.05]) sphere(d=d);
    color([0.14,0.14,0.14]) joint_disc(d=d+6,w=8,axis="y");
}

module servo_pod(label="HIP") {
    difference() {
        union() {
            color(MECHANICAL_DARK) hp_rounded_box([44,30,28], r=5);
            color([0.08,0.08,0.08]) translate([18,0,0]) rotate([90,0,0]) cylinder(h=36,d=24,center=true);
        }
        translate([-6,0,0]) hp_rounded_box([24,18,18], r=3);
        translate([18,0,0]) rotate([90,0,0]) cylinder(h=40,d=11,center=true);
    }
    translate([-8,-18,-10]) rotate([90,0,0]) hp_revision_tag(label, size=2.5, height=0.5);
}

module alien_hoof_proxy() {
    // Lightweight visual proxy matching the tri-lobed hoof language.
    color(BODY_BLACK)
    difference() {
        union() {
            hull() {
                translate([-16,-7,0]) sphere(d=22);
                translate([ 16,-7,0]) sphere(d=22);
                translate([0,16,0]) sphere(d=22);
            }
            translate([0,0,8]) hp_rounded_box([42,22,10], r=3);
        }
        translate([0,0,-14]) cube([80,80,24], center=true);
        for (a=[0,120,240]) rotate([0,0,a]) translate([0,16,1]) hp_rounded_box([5,20,6], r=1.4);
    }
}

module pastern_link(p1=[0,0,0], p2=[0,0,-18]) {
    color([0.06,0.06,0.06]) capsule_between(p1,p2,d=8);
    translate(p1) joint_hub(d=14);
    translate(p2) joint_disc(d=16,w=7,axis="y");
}

module articulated_leg(side=1, front=true) {
    // Local leg coordinates. X is forward/back, Y is side, Z is up.
    // Front and rear mirror slightly so the stance feels animal-like.
    hip_x = 0;
    hip_y = side * 0;
    hip_z = 86;

    knee_x = front ? -30 : 30;
    knee_y = side * 6;
    knee_z = 48;

    ankle_x = front ? 8 : -8;
    ankle_y = side * 12;
    ankle_z = 21;

    foot_x = front ? -4 : 4;
    foot_y = side * 15;
    foot_z = 4;

    hip = [hip_x,hip_y,hip_z];
    knee = [knee_x,knee_y,knee_z];
    ankle = [ankle_x,ankle_y,ankle_z];
    foot = [foot_x,foot_y,foot_z];

    // Tucked hip pod; rotated so it feels mounted into the underside cowl.
    translate(hip) rotate([0,front?8:-8,side>0?0:180]) servo_pod(front ? "F-HIP" : "R-HIP");

    // Upper and lower links. Use paired rods to avoid the stick-leg look.
    for (offset=[-4,4]) {
        color([0.055,0.055,0.055]) capsule_between(hip + [0,offset,0], knee + [0,offset,0], d=7);
        color([0.055,0.055,0.055]) capsule_between(knee + [0,offset,0], ankle + [0,offset,0], d=7);
    }

    // Alien side brace / actuator-looking link.
    color([0.09,0.09,0.09]) capsule_between(hip + [front?-10:10, side*8, -5], ankle + [front?5:-5, side*8, 6], d=4.5);

    // Major visible joints.
    translate(hip) joint_hub(d=18);
    translate(knee) joint_hub(d=20);
    translate(ankle) joint_hub(d=17);

    // Extra ankle/pastern segment before the foot.
    pastern_link(ankle, foot + [0,0,9]);

    translate(foot) rotate([0,0,side*9]) alien_hoof_proxy();
}

module joint_set() {
    translate([-40,0,0]) joint_hub(18);
    translate([0,0,0]) joint_hub(20);
    translate([40,0,0]) joint_hub(17);
}

module layout() {
    translate([-70,44,0]) articulated_leg(1,true);
    translate([70,44,0]) articulated_leg(1,false);
    translate([-70,-44,0]) articulated_leg(-1,true);
    translate([70,-44,0]) articulated_leg(-1,false);
}

if (PART == "leg_front_left") articulated_leg(1,true);
else if (PART == "leg_front_right") articulated_leg(-1,true);
else if (PART == "leg_rear_left") articulated_leg(1,false);
else if (PART == "leg_rear_right") articulated_leg(-1,false);
else if (PART == "joint_set") joint_set();
else if (PART == "foot_proxy") alien_hoof_proxy();
else layout();
