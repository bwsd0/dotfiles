#!/bin/sh

# shellcheck disable=SC1090
[ -e "$HOME/.xrandrrc" ] && . "$HOME/.xrandrrc"
xset -b
xrdb -merge "$HOME/.Xresources"
setxkbmap -option caps:none

case $1 in
	dwm)
		while true
		do
			xsetroot -name "$(date +"%a %b %d %r")"
			sleep 30s
		done &
		urxvtd -q -o -f
		dwm
		;;
	rio)
		exec 9 rio
		;;
	*)
		exec "$DEFAULT_SESSION"
		;;
esac
