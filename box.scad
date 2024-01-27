bissl=1/100;
$fa=1/1;
$fs=0.5;
peg_h=5;
peg_id=3;
peg_od=2*peg_id;
board=1.6;
connection=2;
width=128.8-46.25;
depth=146.58-27.2;
height=(55.93-30.53)+peg_h+board+connection;
air=0.5;
wall=1.6;
floor=1.2;
power_pos=[0,106.68,0];
input_pos=[[0,2.54,0],[0,29.21,0],[0,55.88,0]];
output_holes=[[],[],[]];
difference() {
  translate([-air-wall, -air-wall, -floor]) cube([width+2*air+2*wall, depth+2*air+2*wall, height+floor]);
  cube([width+2*air, depth+2*air, height+bissl]);
  translate(power_pos)power(false);
  for (tr=input_pos) translate(tr) input(false); 
  }
translate(power_pos) power(true);
for (tr=input_pos) translate(tr) input(true); 
module power(positive=true) {
  pegs=[[13.97,7.62],[60.96,3.81]];
  holes=[[0,11.43/2,3.5+peg_h+board]];
  if(positive) for (tr=pegs) translate(tr) difference() {
    cylinder(d=peg_od,h=peg_h);
    cylinder(d=peg_id,h=peg_h+bissl);
  }
  else for (tr=holes) translate(tr) rotate([0,90,0]) cylinder(d=7,h=10,center=true);
}

module input(positive=true) {
  pegs=[[16.51,3.81],[64.77,11.43]];
  holes=[[0,7.62,3.5+peg_h+board]];
  if(positive) for (tr=pegs) translate(tr) difference() {
    cylinder(d=peg_od,h=peg_h);
    cylinder(d=peg_id,h=peg_h+bissl);
  }
  else for (tr=holes) translate(tr) rotate([0,90,0]) cylinder(d=7,h=10,center=true);

}
