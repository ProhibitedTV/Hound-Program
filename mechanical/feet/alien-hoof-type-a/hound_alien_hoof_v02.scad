/*
Hound Program // Alien Hoof Type A v0.2

Manufacturing-minded revision of the first hoof concept.
Goals:
- easier batch printing
- cleaner coating workflow
- stronger mounting bosses
- more deliberate tread geometry
- simple 2x M3 interface

PART options:
- foot_core
- coating_shell_visual
- adapter_mock
- test_coupon
- batch_four
- assembly
*/

$fn = 48;
PART = "assembly";

// Main dimensions
FOOT_LEN = 62;
FOOT_W = 68;
FOOT_H = 18;
TOP_SCALE = 0.78;
RIM_H = 3;

// Interface
MOUNT_SPACING = 28;
M3_CLEAR = 3.4;
M3_HEAD = 6.8;
COUNTER_H = 3.2;
BOSS_D = 13;
BOSS_H = 6;

// Coating visual
COAT = 1.2;

module tri_lobe_2d(r=18, spread=18) {
    hull() {
        translate([-spread,-8]) circle(r=r);
        translate([ spread,-8]) circle(r=r);
        translate([0, spread]) circle(r=r);
    }
}

module hoof_outline_2d(delta=0) {
    offset(r=delta)
    difference() {
        scale([FOOT_W/68, FOOT_LEN/62]) tri_lobe_2d(r=18, spread=18);
        translate([0,-34]) circle(r=8.5);
    }
}

module m3_mount_holes() {
    for (x=[-MOUNT_SPACING/2, MOUNT_SPACING/2]) {
        translate([x,0,-2]) cylinder(d=M3_CLEAR, h=FOOT_H+BOSS_H+8);
        translate([x,0,FOOT_H+BOSS_H-COUNTER_H]) cylinder(d=M3_HEAD, h=COUNTER_H+2);
    }
}

module mounting_bosses() {
    for (x=[-MOUNT_SPACING/2, MOUNT_SPACING/2])
        translate([x,0,FOOT_H-0.2]) cylinder(d=BOSS_D, h=BOSS_H);

    // anti-rotation rib for ankle-side adapter
    translate([0,0,FOOT_H+BOSS_H/2-0.4]) cube([42,8,BOSS_H], center=true);
}

module bottom_tread_cut(depth=3) {
    translate([0,0,-0.4]) {
        // three directional channels
        for (a=[0,120,240]) {
            rotate([0,0,a]) translate([0,13,0]) hull() {
                cylinder(d=4,h=depth+1);
                translate([0,15,0]) cylinder(d=4,h=depth+1);
            }
        }
        // center compliance mark
        cylinder(d=13,h=depth+1);
        // small outer lobe marks
        for (a=[60,180,300]) rotate([0,0,a]) translate([0,24,0]) cylinder(d=5,h=depth+1);
    }
}

module hanging_hole() {
    translate([0,30,10]) rotate([90,0,0]) cylinder(d=3.2,h=10,center=true);
}

module revision_mark(txt="FOOT-A2") {
    translate([0,-27,FOOT_H+0.2]) linear_extrude(height=0.8)
        text(txt, size=4, halign="center", valign="center", font="Liberation Sans:style=Bold");
}

module foot_core() {
    difference() {
        union() {
            hull() {
                linear_extrude(height=2) hoof_outline_2d(-1.2);
                translate([0,1,FOOT_H-2]) scale([TOP_SCALE,TOP_SCALE,1]) linear_extrude(height=2) hoof_outline_2d(-2.0);
            }

            // coating-retention rim near bottom edge
            translate([0,0,2]) linear_extrude(height=RIM_H) difference() {
                hoof_outline_2d(-1.0);
                hoof_outline_2d(-5.4);
            }

            // top bosses and rib
            mounting_bosses();
        }

        m3_mount_holes();
        bottom_tread_cut(depth=3);

        // top lightening pocket; keeps perimeter and bosses intact
        translate([0,0,5]) linear_extrude(height=FOOT_H+2) offset(r=-10) hoof_outline_2d(-2.5);
        hanging_hole();
    }
    revision_mark();
}

module coating_shell_visual() {
    color([0.02,0.02,0.02,0.45])
    difference() {
        hull() {
            translate([0,0,-COAT]) linear_extrude(height=2) hoof_outline_2d(COAT);
            translate([0,0,7]) scale([0.95,0.95,1]) linear_extrude(height=2) hoof_outline_2d(COAT/2);
        }
        translate([0,0,1]) linear_extrude(height=12) hoof_outline_2d(-3.2);
    }
}

module adapter_mock() {
    difference() {
        union() {
            translate([0,0,6]) cube([46,24,12], center=true);
            translate([0,0,15]) rotate([90,0,0]) cylinder(d=14,h=34,center=true);
        }
        for (x=[-MOUNT_SPACING/2, MOUNT_SPACING/2])
            translate([x,0,-8]) cylinder(d=M3_CLEAR,h=30);
        translate([0,0,15]) rotate([90,0,0]) cylinder(d=9,h=40,center=true);
    }
}

module test_coupon() {
    difference() {
        linear_extrude(height=7) hoof_outline_2d(-7);
        bottom_tread_cut(depth=2.4);
        translate([0,20,4]) rotate([90,0,0]) cylinder(d=4,h=10,center=true);
    }
}

module batch_four() {
    for (x=[-45,45]) for (y=[-40,40]) translate([x,y,0]) rotate([0,0,(x+y)/20]) foot_core();
}

module assembly() {
    foot_core();
    translate([0,0,FOOT_H+BOSS_H+7]) color([0.22,0.22,0.22]) adapter_mock();
    coating_shell_visual();
}

if (PART == "foot_core") foot_core();
else if (PART == "coating_shell_visual") coating_shell_visual();
else if (PART == "adapter_mock") adapter_mock();
else if (PART == "test_coupon") test_coupon();
else if (PART == "batch_four") batch_four();
else assembly();
