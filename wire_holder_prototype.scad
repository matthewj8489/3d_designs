$fn=50;
e=0.1;

wire_d=1.5;

wire_r=wire_d/2+0.4;
height=3;
thickness=2;


difference(){
    cube([2*wire_r+2*thickness, 2*wire_r+2*thickness, height]);

    translate([wire_r+thickness, wire_r+thickness,0])
        cylinder(height, r=wire_r);

}