$fn=50;

thick = 5;
bung_lock = [60, 60, thick];
ferm_rt = 18;
ferm_rb = 19;
neck_opening_start_x = 14; //13; -- third attempt //18; -- first attempt
neck_opening_end_x = bung_lock.x - neck_opening_start_x;
neck_opening_end_y = bung_lock.y;
neck_opening_start_y = bung_lock.y - 26;
neck_opening_offset_x = 8;

difference() {
    cube(bung_lock);

    // ferm hole
    translate([bung_lock.x / 2, bung_lock.y / 2, 0])
        cylinder(bung_lock.z, ferm_rt, ferm_rt);

    polyhedron(points = [[neck_opening_start_x, neck_opening_start_y, 0], [neck_opening_end_x, neck_opening_start_y, 0], [bung_lock.x - neck_opening_offset_x, neck_opening_end_y, 0], [neck_opening_offset_x, neck_opening_end_y, 0],
                         [neck_opening_start_x, neck_opening_start_y, bung_lock.z], [neck_opening_end_x, neck_opening_start_y, bung_lock.z], [bung_lock.x - neck_opening_offset_x, neck_opening_end_y, bung_lock.z], [neck_opening_offset_x, neck_opening_end_y, bung_lock.z]],
                faces = [[0, 1, 2, 3], [4, 5, 1, 0], [7, 6, 5, 4], 
                         [5, 6, 2, 1], [6, 7, 3, 2], [7, 4, 0, 3]]);
}

translate([-6, 0, 0])
    rubberband_holder(thick, 6, 6);

translate([bung_lock.x + 6, 0, thick])
    rotate([0, 180, 0])
        rubberband_holder(thick, 6, 6);

module rubberband_holder(thick, notch_r, peg_y)
{
    //thick = 2;
    //notch_r = 6;
    //peg_y = 6;
    
    difference() {
        cube([notch_r, bung_lock.y, thick]);
        
        translate([0, notch_r + peg_y, 0])
            cylinder(thick, notch_r, notch_r);
    
        translate([0, 2 * (notch_r + peg_y) + peg_y, 0])
            cylinder(thick, notch_r, notch_r);
        
        translate([0, 3 * (notch_r + peg_y) + 2 * peg_y, 0])
            cylinder(thick, notch_r, notch_r);
    }
}

module rubber_band_holder(peg, circ_r, chamf_z) {

    difference() {
        cube(peg);
        
        // chamfer
        translate([0, 0, chamf_z])
            rotate(a = [0, -30, 0])
                cube([6, peg.y, peg.z]);
        
        // circular notch
        translate([5.2 + circ_r, 0, chamf_z + circ_r])
            rotate(a = [-90, 0, 0])
                cylinder(peg.y, circ_r, circ_r);
        
        translate([5.2, 0, 2 + circ_r])
            cube([circ_r * 2, peg.y, peg.z - chamf_z - circ_r]);
        
        translate([5.2, 0, 2 + circ_r])
                rotate([0, -30, 0])
                    cube([1.5, peg.y, peg.z - chamf_z - circ_r]);
    }

}
