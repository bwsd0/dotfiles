#!/bin/sh

[ -e "$HOME"/.xrandrrc ] && . "$HOME"/.xrandrrc
xset -b
xrdb -merge "$HOME"/.Xresources

csum=$(sha256sum $(type -p dwm))
case $1 in
	dwm)
        echo "$csum"
		while true
		do
			xsetroot -name "$(date +"%a %b %d %r")"
			sleep 30s
		done &
		dwm
		;;
	*)
		exec "$DEFAULT_SESSION"
		;;
esac
