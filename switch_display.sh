#!/bin/bash

CONFIG_FILE="display_config.conf"

get_config_value() {
    awk -F '=' -v section="$1" -v key="$2" '
    $0 ~ "\\["section"\\]" {in_section=1; next}
    $0 ~ "\\[" {in_section=0}
    in_section && $1==key {print $2; exit}
    ' "$CONFIG_FILE"
}

apply_config() {
    output=$(get_config_value "$1" "output")
    resolution=$(get_config_value "$1" "resolution")
    scale=$(get_config_value "$1" "scale")
    dpi=$(get_config_value "$1" "dpi")
    rotate=$(get_config_value "$1" "rotate")
    mouse_map=$(get_config_value "$1" "mouse_map")

    xrandr --output "$output" --mode "$resolution" --scale "$scale" --dpi "$dpi" --rotate "$rotate"
    xinput set-button-map "pointer:DeviceName" $mouse_map
}

if xrandr | grep "HDMI-1 connected"; then
    internal_output=$(get_config_value "internal_display" "output")
    xrandr --output "$internal_output" --off
    apply_config "external_display"
else
    apply_config "internal_display"
fi

flip() {
    output=$(get_config_value "$1" "output")
    rotate=$(get_config_value "$1" "rotate")

    xrandr --output "$output" --rotate "$rotate"
}
