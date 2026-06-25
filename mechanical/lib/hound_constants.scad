/*
Hound Program shared constants

All dimensions are millimeters.
This file should stay boring: hardware standards, clearances, common part sizes.
*/

// Global preview quality
$fn = 48;

// Fasteners
M2_CLEARANCE = 2.4;
M25_CLEARANCE = 2.9;
M3_CLEARANCE = 3.4;
M4_CLEARANCE = 4.5;

M2_HEAD_D = 4.4;
M25_HEAD_D = 5.2;
M3_HEAD_D = 6.6;
M4_HEAD_D = 8.4;

// Heat-set insert sockets. Tune after testing real inserts.
M2_INSERT_D = 3.6;
M2_INSERT_DEPTH = 4.2;
M3_INSERT_D = 4.8;
M3_INSERT_DEPTH = 5.8;
M4_INSERT_D = 6.3;
M4_INSERT_DEPTH = 7.5;

// Print tolerances
GENERAL_CLEARANCE = 0.35;
SLIP_FIT_CLEARANCE = 0.45;
PRESS_FIT_ALLOWANCE = -0.15;

// Default structural print assumptions
DEFAULT_WALL = 2.8;
DEFAULT_RIB = 3.0;
DEFAULT_FILLET = 2.5;

// Common tube candidates
CF_TUBE_8_OD = 8.0;
CF_TUBE_10_OD = 10.0;
CF_TUBE_12_OD = 12.0;
CF_TUBE_14_OD = 14.0;
CF_TUBE_CLEARANCE = 0.35;

// Common micro servo reference box, 9g-ish. Verify against actual servo.
MICRO_SERVO_W = 23.5;
MICRO_SERVO_D = 12.2;
MICRO_SERVO_H = 24.0;

// Common standard servo reference box. Verify against selected servo.
STD_SERVO_W = 40.5;
STD_SERVO_D = 20.5;
STD_SERVO_H = 40.0;
STD_SERVO_EAR_W = 54.0;
STD_SERVO_EAR_HOLE_SPACING = 49.0;
STD_SERVO_SPLINE_D = 6.0;

// Visual language
SENSOR_RED = [1, 0, 0, 0.65];
BODY_BLACK = [0.035, 0.035, 0.035];
ARMOR_DARK = [0.075, 0.075, 0.075];
MECHANICAL_DARK = [0.16, 0.16, 0.16];
