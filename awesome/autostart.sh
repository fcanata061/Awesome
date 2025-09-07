#!/bin/bash

# Evitar que programas dupliquem no restart
function run {
  if ! pgrep -x "$1" > /dev/null ; then
    "$@" &
  fi
}

# Programas básicos
run nm-applet            # ícone de rede
run volumeicon           # ícone de volume
run blueman-applet       # bluetooth
run picom --experimental-backends # compositor
run nitrogen --restore   # restaura wallpaper
run xsetroot -cursor_name left_ptr

# Se quiser já abrir apps
# run firefox
# run discord
