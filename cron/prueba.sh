#!/bin/bash

source __Shared-Cron.sh

# export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
# export HOME=/home/carlos

#════════════════════════════════════════════════════════════════════
#                   Habilitando Modo Grafico
#════════════════════════════════════════════════════════════════════
# Variables necesarias para que cron hable con tu sesión gráfica
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
export XAUTHORITY=/home/carlos/.Xauthority # <-- esta asegura el acceso a tu sesión

# valor="ls"
# extra="-l -h"
# flag=(-l -h)
#
# # "$valor $extra"  Error
#
# # $valor $extra #Solo acepta uno no mas flag
#
# $valor ${flag[@]}


# valor="ls"
# extra="-l -h"
# flag=(-l -h)
#
# "$valor" "${flag[@]}"

#═══════════════════════════════
#   Variables - Paths Absolutos
#═══════════════════════════════
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
# notify="/usr/bin/notify-send



# find="/usr/bin/find"
# dirname="/usr/bin/dirname"
# basename="/usr/bin/basename"
# ls="/usr/bin/ls"
# grep="/usr/bin/grep"
# sort="/usr/bin/sort"
# uniq="/usr/bin/uniq"
# head="/usr/bin/head"
# awk="/usr/bin/awk"


notify-send "Hola"
/usr/bin/notify-send "yestr"

# spotdl
# /home/carlos/.local/bin/spotdl
