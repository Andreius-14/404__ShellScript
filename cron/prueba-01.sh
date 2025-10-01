#!/bin/bash

# valor="ls"
# extra="-l -h"
# flag=(-l -h)
#
# # "$valor $extra"  Error
#
# # $valor $extra #Solo acepta uno no mas flag
#
# $valor ${flag[@]}


valor="ls"
extra="-l -h"
flag=(-l -h)

"$valor" "${flag[@]}"
