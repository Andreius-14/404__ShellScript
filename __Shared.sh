#!/bin/bash

DIR="$(dirname "${BASH_SOURCE[0]}")"


# Produccion
source "$DIR/Shared/__Base.sh" 2>/dev/null || source "./Shared/__Base.sh"
source "$DIR/Shared/__Bool.sh" 2>/dev/null || source "./Shared/__Bool.sh"
source "$DIR/Shared/__Accion.sh" 2>/dev/null || source "./Shared/__Accion.sh"
source "$DIR/Shared/__String.sh" 2>/dev/null || source "./Shared/__String.sh"

