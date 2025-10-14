#!/bin/bash
source __Shared.sh

# ═══════════════════════════════
#           Variables
# ═══════════════════════════════
ruta_principal="/etc/systemd/system/"
ruta_ParentShell=""

name_timer=""
name_shell=""

path_file_shell=""
path_file_timer=""
path_file_service=""

# ═══════════════════════════════
#         Function Texto
# ═══════════════════════════════

get_timer_content() {
    cat <<EOF

[Unit]
Description=Run ${name_timer}.service

[Timer]
#OnBootSec=
#OnUnitActiveSec=
#OnCalendar=
Unit=${name_timer}.service

[Install]
WantedBy=timers.target
EOF

}

get_service_content() {
    cat <<EOF
[Unit]
Description=script ${name_timer}

[Service]
ExecStart=${ruta_ParentShell}/${name_shell}.sh

[Install]
WantedBy=multi-user.target
EOF

}

# ═══════════════════════════════
#           Funciones
# ═══════════════════════════════

make_service() {
    #Variables
    path_file_service="${ruta_principal}${name_timer}.service"

    get_service_content | sudo tee "$path_file_service" >/dev/null && {
        txt_color "===[Archivo Service Creado]===" "blue"
    }
    # local contenido=$(get_service_content)
    #
    # sudo cat <<<"$contenido" >"$path_file_service" && {
    #     txt_color "===[Archivo Service Creado]===" "blue"
    # }

}

make_timer() {
    #Variables
    path_file_timer="${ruta_principal}${name_timer}.timer"

    get_timer_content | sudo tee "$path_file_timer" >/dev/null && {
        txt_color "===[Archivo Timer Creado]===" "blue"
    }
    # local contenido=$(get_timer_content)
    #
    # sudo cat <<<"$contenido" >"$path_file_timer" && {
    #     txt_color "===[Archivo Timer Creado]===" "blue"
    # }
}

make_shell() {
    #Variables
    ruta_ParentShell=$(realpath .)
    path_file_shell="${ruta_ParentShell}/${name_shell}.sh"

    echo "#!/bin/bash" >"$path_file_shell"
    sudo chmod +x "$path_file_shell"

    txt_color "===[Archivo Shell Creado]===" "blue"
}

# ═══════════════════════════════
#             Main
# ═══════════════════════════════
main() {

    __DirectorioExiste "$ruta_principal" || __salir

    __preguntaDeConfirmacion "Esta Es la Ubicacion Adecuada Donde Crearas el Script $(pwd)" && {

        #Variables
        name_All=""
        # name_timer=$(input_validador "Ingresa El Nombre Para el Archivo - Timer")

        if __preguntaDeConfirmacion "¿Desea el mismo nombre para todos los archivos?"; then
            #Variables
            name_All=$(input_validador "Ingresar Name")
            name_timer="$name_All"
            name_shell="$name_All"

        else
            #Variables
            name_shell=$(input_validador "Ingresa El Nombre Para el Archivo - Shell (sin extension)")
            name_timer=$(input_validador "Ingresa El Nombre Para el Archivo - timer (sin extension)")
        fi

        #Funciones
        make_timer
        make_shell
        make_service

        __salir
    }

    txt_color "Situese en la ruta donde se Deseas Crear Su Script" "blue" && __salir
}

main
