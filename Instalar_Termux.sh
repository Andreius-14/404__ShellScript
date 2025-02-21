#!/bin/bash
source __FuncionesCompartidas.sh

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
__instalarPaquetesArray arrayTermux  

__preguntaDeConfirmacion "Instalar App disponibles desde otros Gestores" || return 1

npm install --global taskbook
pip install youtube-dl
pip install yt-dlp


