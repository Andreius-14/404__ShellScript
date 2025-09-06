#!/bin/bash

#════════════════════════════════════════════════════════════════════
#                   Habilitando Modo Grafico
#════════════════════════════════════════════════════════════════════
# Variables necesarias para que cron hable con tu sesión gráfica
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus
export XAUTHORITY=/home/carlos/.Xauthority # <-- esta asegura el acceso a tu sesión

#════════════════════════════════════════════════════════════════════
#                                UI
#════════════════════════════════════════════════════════════════════
# Voz en terminal (Speech Dispatcher)
/usr/bin/notify-send "Sincronizacion Rclone" "Sincronizacion Rclone y Google Drive hydra_falsa@outlook.com ✅"

# /usr/bin/spd-say "Sincronización completada con Rclone" >>/home/carlos/Documentos/Log-Crontab.log 2>&1
#════════════════════════════════════════════════════════════════════
#                      Ejecucion de Comandos
#════════════════════════════════════════════════════════════════════
