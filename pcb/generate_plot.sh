#!/bin/bash

# ----------------------------------------------------------------------------
# Copyright (c) 2023 - 2024 Thomas Buck (thomas@xythobuz.de)
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# See <http://www.gnu.org/licenses/>.
# ----------------------------------------------------------------------------

cd "$(dirname "$0")"

OUTDIR="plot"
LAYER="F.Cu,B.Cu,F.Mask,B.Mask,F.Paste,B.Paste,F.Silkscreen,B.Silkscreen,Edge.Cuts,User.Drawings"
LAYERMANUAL="B.Cu,Edge.Cuts"

rm -rf $OUTDIR
mkdir -p $OUTDIR

for VAR in pdf svg
do
    echo "Exporting schematic $VAR"
    rm -rf $OUTDIR/tritonmischer_sch.$VAR
    kicad-cli sch export $VAR \
        -t "KiCad Default" \
        -o $OUTDIR/tritonmischer_sch.$VAR \
        tritonmischer.kicad_sch

    echo "Exporting board $VAR"
    rm -rf $OUTDIR/tritonmischer_pcb.$VAR
    kicad-cli pcb export $VAR \
        -t "KiCad Classic"  \
        -l $LAYER \
        -o $OUTDIR/tritonmischer_pcb.$VAR \
        tritonmischer.kicad_pcb
    echo

    echo "Exporting DIY board $VAR"
    rm -rf $OUTDIR/tritonmischer_pcb_diy.$VAR
    kicad-cli pcb export $VAR \
        -t "KiCad Classic"  \
        -l $LAYERMANUAL \
        --black-and-white \
        --negative \
        -o $OUTDIR/tritonmischer_pcb_diy.$VAR \
        tritonmischer.kicad_pcb
    echo
done
