#!/bin/bash

# source config.sh
source "$(dirname "$0")/config.sh"
#════════════════════════════════════════════════════════════════════
#                   Habilitando Modo Grafico
#════════════════════════════════════════════════════════════════════
# Variables necesarias para que cron hable con tu sesión gráfica
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
export XAUTHORITY=/home/carlos/.Xauthority

rclone="/usr/bin/rclone"
send="/usr/bin/notify-send"


$send "Prueba Variables Cron ❌" "$DB_PASS"

