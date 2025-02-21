#!/bin/bash
source __FuncionesCompartidas.sh

# Dato: Preferible Instalar por pip
# Dato: Recuerda PIP - Necestita el sistema estar actualizado

arrayTermux=(
  starship
  stow
  fzf
  zoxide
  eza
  bat
  neovim
  ss
  nmap
  wget
  golang
  npm
  nodejs
)

paguetesPip=(
  youtube-dl
  yt-dlp
  tldr
  dust
)

# Actualiza el Sistema Linux
pkg update && upgrade -y


__instalarPaquetesArray arrayTermux

__preguntaDeConfirmacion "Instalar App disponibles desde otros Gestores" || return 1

npm install --global taskbook
pip install youtube-dl
pip install yt-dlp
