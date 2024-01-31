bissl=1/100;
$fa=1/1;
$fs=0.5;
peg_h=5;
peg_id=4;
peg_od=2*peg_id;
thickness=2;
connection=2;
width=89;
depth=119;
height=peg_h+32;
air=0.5;
wall=2;
floor=1.2;
power_pos=[0,2,0];
input_pos=[[0,47.72,0],[0,47.72+26.67,0],[0,47.72+2*26.67,0]];
output_holes=[[21.59,0,peg_h+24],[21.59+29.21,0,peg_h+24],[21.59+2*29.21,0,peg_h+24]];
cover_pegs=[[8,96],[8,32],[64,96],[64,32]];
potis=[for (x=[21.59-10,21.59-10+29.21,21.59-10+2*29.21]) for (y=[47.72+7.62+1,47.72+7.62+1+26.67,47.72+7.62+1+26.67*2]) [x,y]];
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
module power(positive=true) {
  pegs=[[13.97,7.62],[60.96,3.81]];
  holes=[[0,11.43/2,peg_h+5]];
  if(positive) for (tr=pegs) translate(tr) difference() {
    cylinder(d=peg_od,h=peg_h);
    cylinder(d=peg_id,h=peg_h+bissl);
  }
  else for (tr=holes) translate(tr) rotate([0,90,0]) cylinder(d=7,h=10,center=true);
}

module input(positive=true) {
  pegs=[[16.51,3.81],[64.77,11.43]];
  holes=[[0,7.62,peg_h+5]];
  if(positive) for (tr=pegs) translate(tr) difference() {
    cylinder(d=peg_od,h=peg_h);
    cylinder(d=peg_id,h=peg_h+bissl);
  }
  else for (tr=holes) translate(tr) rotate([0,90,0]) cylinder(d=7,h=10,center=true);
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
cover();
//box();