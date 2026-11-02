#!/bin/bash

source __Shared.sh

#          ╭──────────────────────────────────────────────────────────╮
#          │                          Rutar                           │
#          ╰──────────────────────────────────────────────────────────╯


ruta="$HOME" 
r_termux="$HOME/.termux"


txt_color "Elige una fuente .ttf [Evita font.ttf]"
__DirectorioExiste "$r_termux" || __Error 
name=$(__seleccionar_archivo "$r_termux")

if [[ "$name" == "font.ttf" ]]; then
  echo "Selecciona otra fuente adios"
  exit 0
fi

cp "$r_termux"/"$name" "$r_termux"/font.ttf
termux-reload-settings

