#!/usr/bin/env bash

current=`cat /sys/class/backlight/intel_backlight/actual_brightness`
echo $current
max=`cat /sys/class/backlight/intel_backlight/max_brightness`
echo $max
display_current=$(((current*100)/max))
echo $display_current

notify-send " " -i notification-display-brightness -h int:value:$display_current -h string:x-cannonical-private-synchronous:brightness
