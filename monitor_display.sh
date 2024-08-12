#!/bin/bash

while true; do
    if xrandr | grep "HDMI-1 connected"; then
        if [ ! -f /tmp/external_display ]; then
            ./external_display.sh
            touch /tmp/external_display
            rm -f /tmp/internal_display
        fi
    else
        if [ ! -f /tmp/internal_display ]; then
            ./internal_display.sh
            touch /tmp/internal_display
            rm -f /tmp/external_display
        fi
    fi
    sleep 5
done
