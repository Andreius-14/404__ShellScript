#!/bin/bash
source __FuncionesCompartidas.sh

# ═══════════════════════════════
#           Variables
# ═══════════════════════════════

local array_General=(
  nodejs
  python
)

local array_Arch=(
  yay
  python-pip
  python-pipx # Para instalar herramientas Python en entornos aislados

)

# ═══════════════════════════════
#           Funciones
# ═══════════════════════════════

homeBrew() {
  __EstaInstalado brew && return 0 # Verificar [True/false]

  # Instalar Paquete
  txt_color "⏳ Instalando Homebrew ..." green
  __instalarPaquete base-devel
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
  source ~/.zshrc

  __EstaInstalado brew # Verificar [True/false]
}

# ═══════════════════════════════
#             Main
# ═══════════════════════════════

main() {

  __preguntaDeConfirmacion '¿Instalar HomeBrew?' && homeBrew

  __preguntaDeConfirmacion "¿Continuar con los Demas Gestores?" || __salir

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
