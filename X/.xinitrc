#!/bin/sh

unset LC_ALL
export LANG=en_US.UTF-8
export LC_MESSAGES=C

# shellcheck disable=SC1090
[ -e "$HOME/.xrandrrc" ] && . "$HOME/.xrandrrc"
xset -b
xset +dpms
[ -e "$HOME/.Xresources" ] && xrdb -merge "$HOME/.Xresources"

setxkbmap -option caps:none
setxkbmap -option terminate:ctrl_alt_bksp

case "$1" in
  i3)
    exec i3
    ;;
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
