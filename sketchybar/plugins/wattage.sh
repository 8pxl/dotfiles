#!/bin/sh

# Get combined power (CPU + GPU + ANE) from powermetrics in milliwatts
# Uses plist format for reliable parsing
# 5000ms sample window for accurate readings
POWER_MW=$(sudo powermetrics -n 1 -i 5000 --samplers cpu_power,gpu_power -f plist 2>/dev/null \
  | plutil -extract 'processor.combined_power' raw -o - -- - 2>/dev/null)

if [ -z "$POWER_MW" ]; then
  sketchybar --set "$NAME" label="--W"
  exit 0
fi

# Convert milliwatts to watts with 1 decimal place
POWER_W=$(printf "%.1f" "$(echo "$POWER_MW / 1000" | bc -l)")

sketchybar --set "$NAME" icon="󱐋" label="${POWER_W}W"
