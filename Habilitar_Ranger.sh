#!/bin/bash
source __FuncionesCompartidas.sh

# ═══════════════════════════════
#         Funciones
# ═══════════════════════════════

instalar_configurarDefault() {
  echo "Configurando Ranger..."
  if ranger --copy-config=all; then
    echo "Archivos de configuración copiados correctamente."
  else
    echo "Error: No se pudieron copiar los archivos de configuración." >&2
    exit 1
  fi
}

instalar_Plugindevicons() {
  # Clonar el plugin ranger_devicons
  PLUGIN_DIR="$HOME/.config/ranger/plugins"
  REPO_URL="https://github.com/alexanderjeurissen/ranger_devicons"

  echo "Instalando el plugin ranger_devicons..."
  mkdir -p "$PLUGIN_DIR"

  if git clone "$REPO_URL" "$PLUGIN_DIR/ranger_devicons"; then
    echo "Plugin ranger_devicons clonado correctamente en $PLUGIN_DIR."
  else
    echo "Error: No se pudo clonar el repositorio ranger_devicons." >&2
    exit 1
  fi

  echo "¡Instalación y configuración completadas!"

}
# ═══════════════════════════════
#         Main
# ═══════════════════════════════

# Instalar Ranger si no está presente
__instalarPaquete ranger || Error "Error: No se pudo instalar Ranger."

# Confirmar si se desea instalar la configuración personalizada
__preguntaDeConfirmacion "¿Desea instalar la configuración personalizada?" || __salir

# Ejecutar instalación y configuración
instalar_configurarDefault
instalar_Plugindevicons

txt_color "🚀 ¡Instalación y configuración completadas!" cyan

# Copiar los archivos de configuración predeterminados de Ranger
