# PCB Layout

This page shows the current version of the PCB layout as SVG graphics.

## DIY PCB Fabrication

If you want to etch a PCB by yourself, use [this PDF of the copper layer](./plot/tritonmischer_pcb_diy.pdf).
You need to fabricate three each of the two left most designs, and one of the remaining design on the right.

<script src="js/svg-pan-zoom.js" charset="UTF-8"></script>
<div style="background-color: white; border: 1px solid black;">
    <embed type="image/svg+xml" src="./plot/tritonmischer_pcb_diy.svg" id="pz_tritonmischer_diy" style="width: 100%;"/>
    <script>
        document.getElementById('pz_tritonmischer_diy').addEventListener('load', function(){
            svgPanZoom(document.getElementById('pz_tritonmischer_diy'), {controlIconsEnabled: true, minZoom: 1.0});
        })
    </script>
</div>

[Direct link to this file](./plot/tritonmischer_pcb_diy.svg).

## 2D PCB Layout

You can also view the [Main-Board PCB layout as PDF](./plot/tritonmischer_pcb.pdf).

<script src="js/svg-pan-zoom.js" charset="UTF-8"></script>
<div style="background-color: white; border: 1px solid black;">
    <embed type="image/svg+xml" src="./plot/tritonmischer_pcb.svg" id="pz_tritonmischer" style="width: 100%;"/>
    <script>
        document.getElementById('pz_tritonmischer').addEventListener('load', function(){
            svgPanZoom(document.getElementById('pz_tritonmischer'), {controlIconsEnabled: true, minZoom: 1.0});
        })
    </script>
</div>

[Direct link to this file](./plot/tritonmischer_pcb.svg).
