#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="${1:-/tmp/hound-openscad-out}"
mkdir -p "$OUT_DIR"

run_part() {
  local file="$1"
  local part="$2"
  local name
  name="$(echo "${file}_${part}" | tr '/" ' '____')"
  echo "[OpenSCAD] ${file} :: PART=${part}"
  openscad -q -o "${OUT_DIR}/${name}.stl" -D "PART=\"${part}\"" "$file"
}

# Core assembly modes
run_part mechanical/alpha_v0_1/hound_alpha_v0_1_assembly.scad assembly
run_part mechanical/alpha_v0_1/hound_alpha_v0_1_assembly.scad bare
run_part mechanical/alpha_v0_1/hound_alpha_v0_1_assembly.scad exploded
run_part mechanical/alpha_v0_1/hound_alpha_v0_1_assembly.scad print_layout

# Head identity shell
run_part mechanical/heads/alpha/hound_alpha_head_v02.scad assembly
run_part mechanical/heads/alpha/hound_alpha_head_v02.scad upper_shell
run_part mechanical/heads/alpha/hound_alpha_head_v02.scad lower_mandible
run_part mechanical/heads/alpha/hound_alpha_head_v02.scad neck_adapter
run_part mechanical/heads/alpha/hound_alpha_head_v02.scad expression_test_rack

# Feet
run_part mechanical/feet/alien-hoof-type-a/hound_alien_hoof.scad foot_core
run_part mechanical/feet/alien-hoof-type-a/hound_alien_hoof.scad mount_block
run_part mechanical/feet/alien-hoof-type-a/hound_alien_hoof.scad test_coupon

# Mounts / frame / trays
run_part mechanical/mounts/servo_mount_standard.scad servo_mount
run_part mechanical/mounts/tube_clamp.scad clamp_pair
run_part mechanical/frame/alpha_spine_plate.scad spine_plate
run_part mechanical/electronics_mounts/controller_tray.scad tray
run_part mechanical/power/battery_sled.scad sled
run_part mechanical/armor/armor_plate_family.scad medium_panel
run_part mechanical/expressions/expression_plate_test_rig.scad assembly

echo "OpenSCAD smoke test complete. STL output in ${OUT_DIR}"