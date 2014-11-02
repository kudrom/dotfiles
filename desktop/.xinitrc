#!/bin/sh
PATH=$PATH:$HOME/bin:/usr/sbin:/sbin
export PATH
export NOAPP=/home/kudrom/src/noapp

export LD_LIBRARY_PATH=/usr/local/lib
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig

xrdb -merge ~/.Xresources

xsetroot -cursor_name left_ptr 
xset m 5 1

feh --bg-scale /home/kudrom/datos/imagenes/objectivity-engine.jpg

setxkbmap -layout es
xmodmap ~/.bloqmayus
xset m 2/1 1

xcompmgr -cC -t-5 -l-5 -r4.2 -o.55 -D6 &

xscreensaver &
thunderbird &

#exec ck-launch-session dbus-launch startfluxbox
exec xmonad
