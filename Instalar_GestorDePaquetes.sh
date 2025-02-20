#!/bin/bash
source __FuncionesCompartidas.sh

# ═══════════════════════════════
#           Variables
# ═══════════════════════════════

local array=(
  yay         # AUR Helper
  npm         # Node.js Package Manager
  pnpm        # Alternativa más eficiente a npm
  python-pip  # Gestor de paquetes de Python
  python-pipx # Para instalar herramientas Python en entornos aislados

)

# ═══════════════════════════════
#           Funciones
# ═══════════════════════════════

homeBrew() {
  __EstaInstalado brew && return 0    # Verificar [True/false]

  # Instalar Paquete
  txt_color "⏳ Instalando Homebrew ..." green
  __instalarPaquete base-devel
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
  source ~/.zshrc


  __EstaInstalado brew                # Verificar [True/false]
}

# ═══════════════════════════════
#             Main
# ═══════════════════════════════

main() {
  homeBrew

  __preguntaDeConfirmacion "¿Desea Continuar?" || __salir

  for gestor in "${array[@]}"; do

    # Verificacion - Verifcamos Si el paquete ya esta instalado ,Saltamos si el caso
    if __EstaInstalado "$gestor"; then
      continue # Evita instalación innecesaria
    fi

    # Ejecuta - Ejecutamos El comando de Instalacion
    txt_color "⏳ Instalando $gestor..." green
    __instalarPaquete "$gestor"

  done
}

main
