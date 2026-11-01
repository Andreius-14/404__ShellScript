#!/bin/bash

DIR="$(dirname "${BASH_SOURCE[0]}")"


# Produccion
source "$DIR/Shared/__Base.sh"
source "$DIR/Shared/__Bool.sh"
source "$DIR/Shared/__Accion.sh"
source "$DIR/Shared/__String.sh"

# Develoment
source "./Shared/__Base.sh"
source "./Shared/__Bool.sh"
source "./Shared/__Accion.sh"
source "./Shared/__String.sh"
