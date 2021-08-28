#!/bin/bash

USER="$(who | grep :0\) | cut -f 1 -d ' ')"
export XAUTHORITY=/home/$USER/.Xauthority
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u $USER)/bus

xsetwacom set "HUION Huion Tablet_H640P Pad pad" button 1 key Ctrl z
xsetwacom set "HUION Huion Tablet_H640P Pad pad" button 2 key PgUp
xsetwacom set "HUION Huion Tablet_H640P Pad pad" button 3 key PgDn
xsetwacom set "HUION Huion Tablet_H640P Pad pad" button 8 2 # middle click (scroll)
xsetwacom set "HUION Huion Tablet_H640P Pad pad" button 9 key Ctrl c
xsetwacom set "HUION Huion Tablet_H640P Pad pad" button 10 key Ctrl v

xsetwacom set "HUION Huion Tablet_H640P stylus" button 1 1 # pen tip
xsetwacom set "HUION Huion Tablet_H640P stylus" button 2 key e # eraser
xsetwacom set "HUION Huion Tablet_H640P stylus" button 3 3 # right mouse click
