#!/bin/sh

[ -e "$HOME"/.xrandrrc ] && . "$HOME"/.xrandrrc
xset -b
xrdb -merge "$HOME"/.Xresources

case $1 in
	dwm)
		while true
		do
			xsetroot -name "$(date +"%a %b %d %r")"
			sleep 30s
		done &
		dwm
		;;
	rio)
		exec 9 rio
		;;
	*)
		exec "$DEFAULT_SESSION"
		;;
esac
