#!/bin/bash
source __Shared.sh

#======================================
# [Funciones]
#======================================

habilitar_zsh() {

    # Inicio
    if [ -d "$HOME/.oh-my-zsh" ]; then
        echo "Oh-My-Zsh ===> Ya instalado."

        # Verificar si está configurado en el archivo .zshrc
        if grep -q "oh-my-zsh" "$HOME/.zshrc"; then
            echo "Oh My Zsh está configurado en ~/.zshrc."
        else
            echo "Oh My Zsh no está configurado en ~/.zshrc."
        fi
    else
        # Mensaje
        echo "Oh My Zsh no está instalado."
        echo "Procediendo a Instalar ....."

        # Ejecutando
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    # Fin
}

Zsh_Plugins() {
    txt_color "Instalando Plugins" blue
    # you-should-use
    git clone https://github.com/MichaelAquilina/zsh-you-should-use.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/you-should-use
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    # Requiere - fzf
    git clone https://github.com/joshskidmore/zsh-fzf-history-search ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-fzf-history-search

}

habilitar_Plugin() {
    local zshrc="$HOME/.zshrc"

    txt_color ">> Configurando plugins en .zshrc..." "blue"

    if [ ! -f "$zshrc" ]; then
        txt_color "Error: No se encontró el archivo $zshrc" "red"
        return 1
    fi

    # Plugins que deseas tener sí o sí
    local plugins_to_add=(
        zsh-autosuggestions
        zsh-syntax-highlighting
        colored-man-pages
        history
        zoxide
        you-should-use
        copypath
        bgnotify
        zsh-fzf-history-search

        autojump
    )

    # Plugin txt - Habilitados
    local current_plugins=$(sed -n '/^plugins=(/,/^)/p' "$zshrc" | sed 's/plugins=(//g' | sed 's/)//g')

    for plugin in "${plugins_to_add[@]}"; do
        # Buscar si el plugin existe en el texto (palabra completa)
        if ! echo "$current_plugins" | grep -qw "$plugin"; then
            missing+=("$plugin")
        fi
    done

    if [ ${#missing[@]} -eq 0 ]; then
        txt_color "Todos los plugins ya están activos en ~/.zshrc." "green"
    else
        txt_color "Agregalos a tu archivo .zshrc:" "yellow"
        echo "${missing[*]}"
    fi

    txt_color "Comentados:" "yellow"
    echo "$(echo "$current_plugins" | grep "#")"
}

habilitar_zsh

__preguntaDeConfirmacion "Instalar/Actualizar plugins" && Zsh_Plugins

habilitar_Plugin
