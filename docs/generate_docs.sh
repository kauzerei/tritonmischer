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

#echo "Generating plots"
rm -rf src/plot
../pcb/generate_plot.sh
cp -r ../pcb/plot src

echo "Generating plot includes"
rm -rf src/inc_tritonmischer_sch.md
echo "<script src=\"js/svg-pan-zoom.js\" charset=\"UTF-8\"></script>" >> src/inc_tritonmischer_sch.md
for f in `ls src/plot/tritonmischer_sch.svg/*.svg | sort -r`; do
    file=`echo $f | sed 's:src/:./:g'`
    name=`echo $f | sed 's:src/plot/tritonmischer_sch.svg/::g' | sed 's:.svg::g'`
    echo $name
    echo "<h2>$name</h2>" >> src/inc_tritonmischer_sch.md
    echo "<div style=\"background-color: white; border: 1px solid black;\">" >> src/inc_tritonmischer_sch.md
    echo "<embed type=\"image/svg+xml\" src=\"$file\" id=\"pz_$name\" style=\"width:100%;\"/>" >> src/inc_tritonmischer_sch.md
    echo "<script>" >> src/inc_tritonmischer_sch.md
    echo "document.getElementById('pz_$name').addEventListener('load', function(){" >> src/inc_tritonmischer_sch.md
    echo "svgPanZoom(document.getElementById('pz_$name'), {controlIconsEnabled: true, minZoom: 1.0});" >> src/inc_tritonmischer_sch.md
    echo "})" >> src/inc_tritonmischer_sch.md
    echo "</script>" >> src/inc_tritonmischer_sch.md
    echo "</div>" >> src/inc_tritonmischer_sch.md
    echo >> src/inc_tritonmischer_sch.md
    echo "[Direct link to \`$name\`]($file)." >> src/inc_tritonmischer_sch.md
    echo >> src/inc_tritonmischer_sch.md
done

echo "Generating docs"
if [ "$1" = "serve" ] ; then
    mdbook serve --open
elif [ "$1" = "build" ] ; then
    mdbook build
else
    echo "Invalid command. 'build' or 'serve'."
fi
