$fn=50;
e=0.1;

// measurements
pitch=2.54;
wire_d=1.5;

// parameters
height=3;
thickness=2;
wire_r=wire_d/2+0.3;
pitch_p=wire_r*2+1;

idx=0;

difference(){
    cube([13*pitch_p+2*thickness+wire_r*2, pitch_p+2*thickness+wire_r*2, height]);

    for (idx=[0:13]){
        translate([pitch_p*idx,0,0])
            wire_cutout();
    }

    translate([0,pitch_p,0])
        for (idx=[0:13]){
            translate([pitch_p*idx,0,0])
                wire_cutout();
        }
}

module wire_cutout() {
    translate([wire_r + thickness, wire_r + thickness,0])
        cylinder(height, r=(wire_r + e), center=false);
}