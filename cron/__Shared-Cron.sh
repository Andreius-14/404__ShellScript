#!/bin/bash

#════════════════════════════════════════════════════════════════════
#                   Habilitando Modo Grafico
#════════════════════════════════════════════════════════════════════
# Variables necesarias para que cron hable con tu sesión gráfica
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus
export XAUTHORITY=/home/carlos/.Xauthority # <-- esta asegura el acceso a tu sesión

#════════════════════════════════════════════════════════════════════
#                           UI  -  Pruebas
#════════════════════════════════════════════════════════════════════
# Voz en terminal (Speech Dispatcher)
# /usr/bin/notify-send "Sincronizacion Rclone" "Sincronizacion Rclone y Google Drive hydra_falsa@outlook.com ✅"

# /usr/bin/spd-say "Sincronización completada con Rclone" >>/home/carlos/Documentos/Log-Crontab.log 2>&1

#════════════════════════════════════════════════════════════════════
#                   Herramientas Compartidas (Paths Absolutos)
#════════════════════════════════════════════════════════════════════
spotdl="/home/carlos/.local/bin/spotdl"
find="/usr/bin/find"
dirname="/usr/bin/dirname"
basename="/usr/bin/basename"
ls="/usr/bin/ls"
grep="/usr/bin/grep"
sort="/usr/bin/sort"
uniq="/usr/bin/uniq"
head="/usr/bin/head"
awk="/usr/bin/awk"
