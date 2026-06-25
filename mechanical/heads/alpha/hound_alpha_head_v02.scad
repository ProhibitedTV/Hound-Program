/*
HOUND ALPHA - Alien Animal Head Shell v0.2
OpenSCAD printable concept kit for a SpotMicro-style robot hound identity shell.

Vision lock:
- alien animal, not cute dog
- Alpha Centauri spacecraft skull + demon insectoid armor
- unsettling but physically safe: no sharp metal, no weaponry, no pursuit behavior
- printable as modular shells/plates with boring, strong mounting
- expressive micro-armor plates for limited non-cartoon emotion

Usage:
Set PART below to one of:
"assembly", "upper_shell", "lower_mandible", "neck_adapter", "camera_mount",
"center_eye_diffuser", "left_eye_diffuser", "right_eye_diffuser",
"left_brow", "right_brow", "left_gill", "right_gill",
"left_cheek_plate", "right_cheek_plate", "crown_fin_left", "crown_fin_right", "crown_fin_center",
"micro_servo_cradle", "linkage_arm", "expression_test_rack"

Set EXPR to:
"idle", "curious", "alert", "command", "friendly", "stealth"

Units: mm
*/

$fn = 56;
PART = "assembly";
EXPR = "alert";

head_len = 168;
head_w   = 78;
head_h   = 52;
wall     = 2.6;
clearance = 0.35;

m3_d = 3.25;
m3_clearance = 3.45;
m3_head_d = 6.6;
insert_d = 4.8;
insert_depth = 5.8;
servo9g_w = 23.5;
servo9g_d = 12.2;
servo9g_h = 24.0;

led_slot_w = 4.6;
led_slot_h = 3.2;
cam_hole_d = 12.5;
wire_channel_d = 8;

module rounded_box(size=[10,10,10], r=2){
    hull(){
        for(x=[-size[0]/2+r, size[0]/2-r])
        for(y=[-size[1]/2+r, size[1]/2-r])
        for(z=[-size[2]/2+r, size[2]/2-r])
            translate([x,y,z]) sphere(r=r);
    }
}

module screw_hole(depth=12, d=m3_d){ cylinder(h=depth, d=d, center=true); }
module countersink(depth=3){ cylinder(h=depth, d=m3_head_d, center=true); }
module heat_insert_socket(depth=insert_depth){ cylinder(h=depth, d=insert_d, center=true); }

module teardrop_hole(d=3.2, h=10){
    rotate([0,90,0]) union(){
        cylinder(h=h, d=d, center=true);
        translate([0,d*0.25,0]) rotate([0,0,45]) cube([d*0.72,d*0.72,h], center=true);
    }
}

module alien_wedge(len=head_len, w=head_w, h=head_h){
    polyhedron(
        points=[
            [-len/2, -w/2, -h/2], [-len/2,  w/2, -h/2], [-len/2, -w*0.42, h*0.18], [-len/2, w*0.42, h*0.18],
            [-len*0.10, -w*0.50, -h*0.45], [-len*0.10, w*0.50, -h*0.45], [-len*0.10, -w*0.38, h*0.54], [-len*0.10, w*0.38, h*0.54],
            [ len*0.31, -w*0.36, -h*0.42], [ len*0.31, w*0.36, -h*0.42], [ len*0.31, -w*0.27, h*0.38], [ len*0.31, w*0.27, h*0.38],
            [ len/2, -w*0.12, -h*0.28], [ len/2, w*0.12, -h*0.28], [ len/2, -w*0.07, h*0.03], [ len/2, w*0.07, h*0.03]
        ],
        faces=[
            [0,4,5,1], [2,3,7,6], [0,2,6,4], [1,5,7,3],
            [4,8,9,5], [6,7,11,10], [4,6,10,8], [5,9,11,7],
            [8,12,13,9], [10,11,15,14], [8,10,14,12], [9,13,15,11],
            [12,14,15,13], [0,1,3,2]
        ]
    );
}

module armor_scale(x=0,y=0,z=0, sx=18, sy=12, sz=2.2, yaw=0, pitch=0){
    translate([x,y,z]) rotate([0,pitch,yaw]) rounded_box([sx,sy,sz], r=0.9);
}

module upper_shell_core(){
    difference(){
        alien_wedge();
        translate([-3,0,-head_h*0.45]) scale([0.88,0.78,0.70]) alien_wedge(len=head_len*0.96,w=head_w,h=head_h);
        translate([-head_len*0.36,0,-2]) rounded_box([48, head_w*0.72, head_h*0.64], r=5);
        translate([0,0,-head_h*0.54]) cube([head_len*0.82, head_w*0.72, head_h*0.40], center=true);
    }
}

module side_eye_slot(side=1){
    translate([24, side*(head_w/2+0.2), 11]) rotate([0,-11,side*16]) cube([82, led_slot_w, led_slot_h], center=true);
    translate([60, side*(head_w/2+0.2), -7]) rotate([0,-18,side*25]) cube([34, led_slot_w, led_slot_h], center=true);
    for(i=[0:3]) translate([-6+i*12, side*(head_w/2+0.3), -1+i*0.7]) rotate([0,-8,side*18]) cube([6, 3.0, 2.4], center=true);
}

module center_sensor_slot(){
    translate([head_len/2-11,0,-5]) rotate([0,90,0]) rounded_box([25,5.4,10], r=1.3);
}

module top_scale_pattern(){
    for(row=[0:3])
    for(col=[-2:2]){
        x=-42 + row*25 + abs(col)*2;
        y=col*12 + (row%2)*5;
        z=head_h*0.31 - row*0.9;
        armor_scale(x,y,z, sx=18-row*1.5, sy=9, sz=1.6, yaw=col*3, pitch=8);
    }
}

module upper_shell(){
    difference(){
        union(){
            upper_shell_core();
            top_scale_pattern();
            fixed_spine_ridge();
            rear_mount_bosses();
        }
        side_eye_slot(1); side_eye_slot(-1); center_sensor_slot();
        translate([head_len/2-20,0,3]) rotate([0,90,0]) cylinder(h=26, d=cam_hole_d, center=true);
        translate([-head_len/2+16,0,-15]) rotate([0,90,0]) cylinder(h=38, d=wire_channel_d, center=true);
        for(y=[-24,24]) translate([-head_len/2+18,y,-head_h/2+9]) rotate([90,0,0]) teardrop_hole(d=m3_clearance,h=22);
        for(x=[-45,-15,15,45]) for(y=[-head_w*0.31,head_w*0.31])
            translate([x,y,-head_h*0.47]) cube([12,3,6], center=true);
    }
}

module rear_mount_bosses(){
    for(y=[-24,24]) translate([-head_len/2+20,y,-head_h/2+11]) rotate([90,0,0]) rounded_box([15,12,10], r=2);
}

module fixed_spine_ridge(){
    translate([-12,0,head_h*0.41]) fin_plate(len=72,h=11,thick=5, sweep=-8);
}

module fin_plate(len=50,h=20,thick=4,sweep=0){
    rotate([0,sweep,0]) polyhedron(
        points=[[0,-thick/2,0],[0,thick/2,0],[len,-thick/2,0],[len,thick/2,0],[len*0.66,-thick/2,h],[len*0.66,thick/2,h]],
        faces=[[0,2,3,1],[2,4,5,3],[0,1,5,4],[0,4,2],[1,3,5]]
    );
}

module lower_mandible(){
    difference(){
        union(){
            translate([34,0,-26]) scale([1,0.54,0.40]) alien_wedge(len=126,w=head_w,h=head_h);
            translate([68,0,-45]) rounded_box([58,18,11], r=3);
            for(y=[-17,17]) translate([60,y,-40]) rotate([0,-12,y>0?6:-6]) fin_plate(len=38,h=12,thick=4,sweep=-6);
        }
        translate([38,0,-27]) scale([0.82,0.42,0.25]) alien_wedge(len=110,w=head_w,h=head_h);
        for(y=[-18,18]) translate([-11,y,-20]) rotate([90,0,0]) teardrop_hole(d=m3_clearance,h=22);
        translate([40,0,-39]) cube([72,8,7], center=true);
    }
}

function expr_brow_angle(e) = e=="idle" ? 0 : e=="curious" ? 9 : e=="alert" ? -8 : e=="command" ? -14 : e=="friendly" ? 7 : e=="stealth" ? 4 : 0;
function expr_gill_angle(e) = e=="idle" ? 0 : e=="curious" ? 10 : e=="alert" ? 18 : e=="command" ? 4 : e=="friendly" ? -6 : e=="stealth" ? -12 : 0;
function expr_fin_angle(e) = e=="idle" ? 0 : e=="curious" ? 5 : e=="alert" ? 15 : e=="command" ? 22 : e=="friendly" ? -5 : e=="stealth" ? -12 : 0;

module brow_plate(side=1, pose=EXPR){
    mirror([0, side<0?1:0, 0])
    rotate([0,0,expr_brow_angle(pose)])
    difference(){
        union(){
            translate([24,34,12]) rotate([0,-12,13]) scale([1,0.33,0.12]) alien_wedge(len=92,w=28,h=21);
            translate([62,33,1]) rotate([0,-18,23]) rounded_box([40,5,6], r=1.5);
            translate([-22,30,4]) rotate([0,90,0]) rounded_box([16,10,9], r=2);
        }
        translate([26,34,12]) rotate([0,-12,13]) cube([66,3.2,5], center=true);
        translate([-22,30,4]) rotate([0,90,0]) cylinder(h=20,d=2.1,center=true);
        translate([28,31,7]) rotate([0,90,0]) cylinder(h=14,d=2.1,center=true);
    }
}

module side_gill(side=1, pose=EXPR){
    mirror([0, side<0?1:0, 0])
    rotate([0,0,expr_gill_angle(pose)])
    difference(){
        union(){
            for(i=[0:3]) translate([-42+i*19,43,-9+i*2.1]) rotate([0,-6,0]) rounded_box([34,4.5,12], r=1.4);
            translate([-53,40,-10]) rotate([0,90,0]) rounded_box([13,10,8], r=2);
        }
        for(i=[0:3]) translate([-42+i*19,43,-9+i*2.1]) cube([21,8,3], center=true);
        translate([-53,40,-10]) rotate([0,90,0]) cylinder(h=16,d=2.1,center=true);
        translate([-8,40,-3]) rotate([0,90,0]) cylinder(h=14,d=2.1,center=true);
    }
}

module cheek_plate(side=1){
    mirror([0, side<0?1:0, 0])
    difference(){
        union(){
            translate([42,31,-20]) rotate([0,-18,18]) scale([1,0.28,0.12]) alien_wedge(len=70,w=24,h=18);
            translate([18,29,-22]) rotate([0,90,0]) rounded_box([12,9,8], r=2);
        }
        translate([18,29,-22]) rotate([0,90,0]) cylinder(h=16,d=2.1,center=true);
        translate([46,29,-17]) rotate([0,90,0]) cylinder(h=12,d=2.1,center=true);
    }
}

module crown_fin(side=0, pose=EXPR){
    ang = expr_fin_angle(pose);
    y = side*19;
    mirror([0, side<0?1:0, 0])
    translate([-24,abs(y),head_h*0.42]) rotate([0,ang,side*7])
    difference(){
        fin_plate(len=72 - abs(side)*8, h=30 - abs(side)*4, thick=4, sweep=-6);
        translate([10,0,1]) rotate([0,90,0]) cylinder(h=12,d=2.1,center=true);
    }
}

module center_eye_diffuser(){ rounded_box([34,4.5,9], r=1.2); }
module side_eye_diffuser(side=1){
    mirror([0, side<0?1:0,0]) union(){
        translate([0,0,0]) rounded_box([78,4.2,4.2], r=1.2);
        translate([41,-1,-17]) rotate([0,-7,8]) rounded_box([32,4.2,4.2], r=1.2);
    }
}

module neck_adapter(){
    difference(){
        union(){
            rounded_box([76,62,9], r=4);
            translate([0,0,14]) rounded_box([46,36,24], r=4);
            translate([26,0,19]) rounded_box([24,42,18], r=3);
        }
        for(x=[-27,27]) for(y=[-22,22]) translate([x,y,0]) cylinder(h=24,d=m3_clearance,center=true);
        for(y=[-24,24]) translate([-20,y,15]) rotate([90,0,0]) heat_insert_socket(12);
        translate([10,0,10]) rounded_box([30,19,30], r=3);
    }
}

module camera_mount(){
    difference(){
        union(){
            rounded_box([40,30,4], r=2);
            translate([0,0,9]) rounded_box([26,22,18], r=2);
            translate([0,0,20]) rounded_box([32,26,5], r=2);
        }
        translate([0,0,9]) cylinder(h=35,d=cam_hole_d,center=true);
        for(x=[-12,12]) for(y=[-9,9]) translate([x,y,0]) cylinder(h=16,d=2.3,center=true);
        translate([0,0,20]) rounded_box([18,14,8], r=1.5);
    }
}

module micro_servo_cradle(){
    difference(){
        union(){
            rounded_box([servo9g_w+8, servo9g_d+8, 4], r=2);
            translate([0,-(servo9g_d/2+4),servo9g_h/2]) rounded_box([servo9g_w+8,4,servo9g_h], r=1.5);
            translate([0,(servo9g_d/2+4),servo9g_h/2]) rounded_box([servo9g_w+8,4,servo9g_h], r=1.5);
        }
        translate([0,0,servo9g_h/2]) rounded_box([servo9g_w+0.6, servo9g_d+0.6, servo9g_h+2], r=1);
        for(x=[-servo9g_w/2-2.5, servo9g_w/2+2.5]) translate([x,0,2]) cylinder(h=12,d=2.2,center=true);
    }
}

module linkage_arm(len=28){
    difference(){
        hull(){
            translate([-len/2,0,0]) cylinder(h=3,d=7,center=true);
            translate([len/2,0,0]) cylinder(h=3,d=7,center=true);
        }
        translate([-len/2,0,0]) cylinder(h=5,d=2.1,center=true);
        translate([len/2,0,0]) cylinder(h=5,d=2.1,center=true);
    }
}

module expression_test_rack(){
    translate([-100,0,0]) brow_plate(1,"idle");
    translate([-30,0,0]) brow_plate(1,"alert");
    translate([40,0,0]) side_gill(1,"curious");
    translate([105,0,0]) cheek_plate(1);
    translate([150,0,0]) crown_fin(0,"command");
}

module assembly(){
    color([0.035,0.035,0.035]) upper_shell();
    color([0.025,0.025,0.025]) lower_mandible();
    color([0.08,0.08,0.08]) brow_plate(1,EXPR);
    color([0.08,0.08,0.08]) brow_plate(-1,EXPR);
    color([0.06,0.06,0.06]) side_gill(1,EXPR);
    color([0.06,0.06,0.06]) side_gill(-1,EXPR);
    color([0.07,0.07,0.07]) cheek_plate(1);
    color([0.07,0.07,0.07]) cheek_plate(-1);
    color([0.055,0.055,0.055]) crown_fin(-1,EXPR);
    color([0.055,0.055,0.055]) crown_fin(0,EXPR);
    color([0.055,0.055,0.055]) crown_fin(1,EXPR);
    color([1,0,0,0.65]) translate([head_len/2-8,0,-5]) rotate([0,90,0]) center_eye_diffuser();
    color([1,0,0,0.55]) translate([24, head_w/2+2, 11]) rotate([0,-11,16]) side_eye_diffuser(1);
    color([1,0,0,0.55]) translate([24,-head_w/2-2, 11]) rotate([0,-11,-16]) side_eye_diffuser(-1);
    color([0.12,0.12,0.12]) translate([-head_len/2+20,0,-44]) neck_adapter();
}

if(PART=="assembly") assembly();
else if(PART=="upper_shell") upper_shell();
else if(PART=="lower_mandible") lower_mandible();
else if(PART=="neck_adapter") neck_adapter();
else if(PART=="camera_mount") camera_mount();
else if(PART=="center_eye_diffuser") center_eye_diffuser();
else if(PART=="left_eye_diffuser") side_eye_diffuser(1);
else if(PART=="right_eye_diffuser") side_eye_diffuser(-1);
else if(PART=="left_brow") brow_plate(1,"idle");
else if(PART=="right_brow") brow_plate(-1,"idle");
else if(PART=="left_gill") side_gill(1,"idle");
else if(PART=="right_gill") side_gill(-1,"idle");
else if(PART=="left_cheek_plate") cheek_plate(1);
else if(PART=="right_cheek_plate") cheek_plate(-1);
else if(PART=="crown_fin_left") crown_fin(-1,"idle");
else if(PART=="crown_fin_right") crown_fin(1,"idle");
else if(PART=="crown_fin_center") crown_fin(0,"idle");
else if(PART=="micro_servo_cradle") micro_servo_cradle();
else if(PART=="linkage_arm") linkage_arm();
else if(PART=="expression_test_rack") expression_test_rack();
