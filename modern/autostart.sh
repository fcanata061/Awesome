#!/bin/bash
# ~/.config/awesome/modern/autostart.sh
# Programas que iniciam junto com o AwesomeWM (versão modern)

# Função para evitar processos duplicados
run() {
  if ! pgrep -x "$1" > /dev/null ; then
    "$@" &
  fi
}

# 🔊 Som
run pasystray         # ícone do pulseaudio
# run volumeicon       # alternativa

# 🌐 Rede
run nm-applet         # ícone do NetworkManager

# 🖥️ Compositor
run picom --experimental-backends --config ~/.config/picom/picom.conf

# 🖼️ Wallpaper
run nitrogen --restore  # restaura papel de parede salvo

# 🔔 Notificações
run dunst

# ⌨️ Layout de teclado (exemplo BR ABNT2)
# setxkbmap -layout br

# 💬 Mensageiros (opcional)
# run discord
# run telegram-desktop

# 🎵 MPD (opcional)
# run mpd
