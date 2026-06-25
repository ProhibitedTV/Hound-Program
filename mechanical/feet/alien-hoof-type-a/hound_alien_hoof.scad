/*
HOUND PROGRAM // ALIEN HOOF TYPE A
OpenSCAD printable modular foot system v0.1

Design intent:
- PLA/PLA+ printable consumable foot core
- Flex Seal / rubberized coating friendly geometry
- Tri-lobed alien hoof contact patch
- Universal 2x M3 mounting interface
- No nasty overhangs when printed sole-down or top-up depending part

Usage:
Set PART to one of:
  "assembly", "foot_core", "coating_mask", "mount_block", "test_coupon"

Recommended first print:
  PART="foot_core";
  material PLA+, 0.2 layer, 5 walls, 35-50% gyroid/cubic
*/

$fn = 48;
PART = "assembly";

// ---------- Global dimensions ----------
foot_w = 64;          // overall width X
foot_l = 58;          // overall length Y
foot_h = 18;          // PLA core height
dish_depth = 5;       // bottom convex/sole shaping
edge_round = 6;

mount_spacing = 28;   // M3 hole spacing X
mount_hole_d = 3.4;   // clearance for M3
mount_counter_d = 6.5;
mount_counter_h = 3.2;
mount_boss_d = 12;
mount_boss_h = 5;

coating_allowance = 1.2; // visual shell representing Flex Seal thickness

// ---------- Helpers ----------
module rounded_triangle_2d(r=18, spread=18) {
    // Tri-lobed footprint: rear-left, rear-right, forward lobe
    hull() {
        translate([-spread, -8]) circle(r=r);
        translate([ spread, -8]) circle(r=r);
        translate([0, spread]) circle(r=r);
    }
}

module alien_hoof_outline_2d(offset_amt=0) {
    offset(r=offset_amt)
    difference() {
        rounded_triangle_2d(r=18, spread=18);
        // very subtle rear notch so it does not look like a heart
        translate([0,-33]) circle(r=9);
    }
}

module screw_holes() {
    for (x=[-mount_spacing/2, mount_spacing/2]) {
        translate([x,0,-2]) cylinder(d=mount_hole_d, h=foot_h+10);
        translate([x,0,foot_h-mount_counter_h]) cylinder(d=mount_counter_d, h=mount_counter_h+2);
    }
}

module mount_bosses() {
    for (x=[-mount_spacing/2, mount_spacing/2]) {
        translate([x,0,foot_h-0.1]) cylinder(d=mount_boss_d, h=mount_boss_h);
    }
    // center alignment rib, shallow and printable
    translate([0,0,foot_h+1.8]) cube([42,8,3.6], center=true);
}

module tread_grooves(depth=2.2) {
    // recessed alien triangular channels on bottom
    translate([0,0,-0.2]) {
        for (a=[0,120,240]) {
            rotate([0,0,a]) translate([0,14,0])
                hull() {
                    translate([-2,0,0]) cylinder(d=3.6,h=depth+1);
                    translate([2,14,0]) cylinder(d=3.6,h=depth+1);
                }
        }
        cylinder(d=14,h=depth+1);
        for (a=[60,180,300]) {
            rotate([0,0,a]) translate([0,24,0]) cylinder(d=5,h=depth+1);
        }
    }
}

module revision_text(txt="FOOT-A1-R1") {
    translate([0,-25,foot_h+0.2])
        linear_extrude(height=0.8)
            text(txt, size=4, halign="center", valign="center", font="Liberation Sans:style=Bold");
}

// ---------- Main printable foot ----------
module foot_core() {
    difference() {
        union() {
            // main shallow wedge/hoof body
            hull() {
                translate([0,0,0]) linear_extrude(height=2) alien_hoof_outline_2d(-1.5);
                translate([0,1,foot_h-2]) scale([0.78,0.74,1]) linear_extrude(height=2) alien_hoof_outline_2d(-2);
            }
            mount_bosses();
            // raised rim keeps Flex Seal from peeling off edges quickly
            translate([0,0,2]) linear_extrude(height=3) difference() {
                alien_hoof_outline_2d(-1.2);
                alien_hoof_outline_2d(-5.2);
            }
        }
        screw_holes();
        // underside tread grooves
        tread_grooves(depth=3);
        // lighten from top, leaving ribs and perimeter intact
        translate([0,0,5]) linear_extrude(height=foot_h) offset(r=-9) alien_hoof_outline_2d(-2);
        // wiring / drain / hanging hole for coating cure hook
        translate([0,29,9]) rotate([90,0,0]) cylinder(d=3.2,h=8,center=true);
    }
    revision_text();
}

module flex_seal_visual_shell() {
    // not for printing necessarily: shows expected coating volume
    color([0.02,0.02,0.02,0.45])
    difference() {
        translate([0,0,-coating_allowance])
            hull() {
                linear_extrude(height=2) alien_hoof_outline_2d(coating_allowance);
                translate([0,0,6]) scale([0.96,0.96,1]) linear_extrude(height=2) alien_hoof_outline_2d(coating_allowance/2);
            }
        translate([0,0,1]) linear_extrude(height=10) alien_hoof_outline_2d(-3);
    }
}

module universal_mount_block() {
    // printable mockup of ankle-side interface for fit testing
    difference() {
        union() {
            translate([0,0,8]) cube([44,26,16], center=true);
            translate([0,0,0]) cube([36,18,6], center=true);
        }
        for (x=[-mount_spacing/2, mount_spacing/2])
            translate([x,0,-8]) cylinder(d=3.4,h=30);
        // tube/ankle placeholder clearance
        translate([0,0,10]) rotate([90,0,0]) cylinder(d=12,h=40,center=true);
    }
}

module coating_test_coupon() {
    // Print several of these to test Flex Seal adhesion, cure, wear, and tread depth.
    difference() {
        linear_extrude(height=7) alien_hoof_outline_2d(-6);
        tread_grooves(depth=2.2);
        translate([0,19,3.5]) rotate([90,0,0]) cylinder(d=4,h=8,center=true);
    }
}

module assembly() {
    color([0.12,0.12,0.12]) foot_core();
    translate([0,0,foot_h+mount_boss_h+9]) color([0.25,0.25,0.25]) universal_mount_block();
    flex_seal_visual_shell();
}

if (PART == "assembly") assembly();
else if (PART == "foot_core") foot_core();
else if (PART == "coating_mask") flex_seal_visual_shell();
else if (PART == "mount_block") universal_mount_block();
else if (PART == "test_coupon") coating_test_coupon();
