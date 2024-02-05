bissl=1/100;
$fa=1/1;
$fs=1/2;

part="box";//[box, lid, OPT_visualization]

//standoffs for screws
peg_h=5;
peg_id=3.5;
peg_od=2*peg_id;

//box dimentions 
width=100;
depth=119;
height=peg_h+32;
wall=1.6;
floor=1.5;

//lid dimensions
thickness=2;
air=0.5;

//parts positions
power_pos=[1,2+2*26.67+50.8,0]; //measured from schematic
input_pos=[[1,2,0],[1,2+26.67,0],[1,2+2*26.67,0]]; //
output_holes=[ for (i=[0:2]) [21.59+i*29.21,120,peg_h+24]];
cover_pegs=[for (x=[8,92]) for (y=[22,96]) [x,y]];
potis=[for (x=[for (i=[0:2]) 10+21.59+i*29.21]) for (y=[ for (i=[0:2]) 1+7.62+i*26.67]) [x,y]];

module box() {
  difference() {
    translate([-wall, -wall, -floor]) cube([width+2*wall, depth+2*wall, height+floor]);
    cube([width, depth, height+bissl]);
    translate(power_pos)power(false);
    for (tr=input_pos) translate(tr) input(false); 
    for (tr=output_holes) translate(tr) rotate([90,0,0]) cylinder(h=10,d=7,center=true); 
  }
  translate(power_pos) power(true);
  for (tr=input_pos) translate(tr) input(true);
  for (tr=cover_pegs) translate(tr) difference() {
    union() {
      cylinder(h=32,d=peg_od);
      cylinder(h=5,d1=10,d2=0);
    }
    translate([0,0,22]) cylinder(h=32,d=peg_id);
  }
}

module power(positive=true) { //true: parts that need to be added, false: subtracted
  pegs=[[13.97,7.62],[60.96,3.81]]; //power-specific, measured from schematic
  holes=[[0,11.43/2,peg_h+5]];
  if(positive) for (tr=pegs) translate(tr) difference() {
    cylinder(d=peg_od,h=peg_h);
    cylinder(d=peg_id,h=peg_h+bissl);
  }
  else for (tr=holes) translate(tr) rotate([0,90,0]) cylinder(d=7,h=10,center=true); //sorry for hardcoded magic values
}

module input(positive=true) {
  pegs=[[16.51,3.81],[64.77,11.43]]; //output-specific, measured from schematic
  holes=[[0,7.62,peg_h+5]];
  if(positive) for (tr=pegs) translate(tr) difference() {
    cylinder(d=peg_od,h=peg_h);
    cylinder(d=peg_id,h=peg_h+bissl);
  }
  else for (tr=holes) translate(tr) rotate([0,90,0]) cylinder(d=7,h=10,center=true); //sorry for hardcoded magic values
}

module cover () {
  difference() {
    union() {
      translate([-wall, -wall, 0]) cube([width+2*wall, depth+2*wall, thickness]);
      translate([air, air, -thickness]) cube([width-2*air, depth-2*air, thickness]);
    }
    translate([air+wall, air+wall, -thickness-bissl]) cube([width-2*air-2*wall, depth-2*air-2*wall, thickness]);  
    translate ([0,0,-2*bissl]) for (tr=cover_pegs) translate(tr) cylinder(h=thickness+3*bissl,d=2);
    translate ([0,0,-2*bissl]) for (tr=potis) translate(tr) cylinder (h=thickness+3*bissl,d=8);
  }
}

if (part=="box") box();
else if (part=="lid") rotate([180,0,0])cover(); //printed upside down
else {translate([0,0,38]) cover(); box();}
