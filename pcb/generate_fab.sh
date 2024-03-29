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

INFILE="tritonmischer.kicad_pcb"
INFILE_SCH="tritonmischer.kicad_sch"
OUTDIR="fabrication"
OUTZIP="fab"

echo "Creating output directory"
rm -rf $OUTDIR
mkdir -p $OUTDIR

echo "Exporting drill files"
#kicad-cli pcb export drill -o $OUTDIR/ --format excellon --generate-map --map-format pdf $INFILE
kicad-cli pcb export drill -o $OUTDIR/ --format gerber --generate-map --map-format gerberx2 $INFILE

echo "Exporting gerber files"
#kicad-cli pcb export gerbers -o $OUTDIR/ $INFILE
kicad-cli pcb export gerbers -o $OUTDIR/ -l F.Cu,B.Cu,F.Mask,B.Mask,F.Paste,B.Paste,F.Silkscreen,B.Silkscreen,Edge.Cuts $INFILE

echo "Exporting BOM files"
kicad-cli sch export python-bom -o $OUTDIR/bom.xml $INFILE_SCH

# TODO convert BOM XML to proper format for JLCPCB

echo "Compressing archive"
rm -rf $OUTZIP.zip
zip -r $OUTZIP fabrication
