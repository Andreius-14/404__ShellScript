#!/bin/bash

#════════════════════════════════════════════════════════════════════
#                   habilitando modo grafico
#════════════════════════════════════════════════════════════════════
# variables necesarias para que cron hable con tu sesión gráfica
export display=:0
export dbus_session_bus_address=unix:path=/run/user/$(id -u)/bus
export xauthority=/home/carlos/.xauthority # <-- esta asegura el acceso a tu sesión

#════════════════════════════════════════════════════════════════════
#                           UI  -  Pruebas
#════════════════════════════════════════════════════════════════════
# Voz en terminal (Speech Dispatcher)
# /usr/bin/notify-send "Sincronizacion Rclone" "Sincronizacion Rclone y Google Drive hydra_falsa@outlook.com ✅"

# /usr/bin/spd-say "Sincronización completada con Rclone" >>/home/carlos/Documentos/Log-Crontab.log 2>&1

#════════════════════════════════════════════════════════════════════
#                   Herramientas Compartidas (Paths Absolutos)
#════════════════════════════════════════════════════════════════════
# spotdl="/home/carlos/.local/bin/spotdl"
# find="/usr/bin/find"
# dirname="/usr/bin/dirname"
# basename="/usr/bin/basename"
# ls="/usr/bin/ls"
# grep="/usr/bin/grep"
# sort="/usr/bin/sort"
# uniq="/usr/bin/uniq"
# head="/usr/bin/head"
# awk="/usr/bin/awk"
# notifynotify="/usr/bin/notify-send"
#
# ruta_log="/home/carlos/Documentos/Log-Crontab.log" 
#

