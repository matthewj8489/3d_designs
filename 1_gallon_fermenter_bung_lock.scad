$fn=50;

bung_lock = [30, 30, 5];
ferm_rt = 7;
ferm_rb = 8;
neck_opening_start_x = 11;
neck_opening_end_x = bung_lock.x - neck_opening_start_x;
neck_opening_end_y = bung_lock.y;
neck_opening_start_y = bung_lock.y - 14;

difference() {
    cube([30, 30, 5]);

    // ferm hole
    translate([bung_lock.x / 2, bung_lock.y / 2, 0])
        cylinder(bung_lock.z, ferm_rb, ferm_rt);

    polyhedron(points = [[neck_opening_start_x, neck_opening_start_y, 0], [neck_opening_end_x, neck_opening_start_y, 0], [bung_lock.x - 2, neck_opening_end_y, 0], [2, neck_opening_end_y, 0],
                         [neck_opening_start_x, neck_opening_start_y, bung_lock.z], [neck_opening_end_x, neck_opening_start_y, bung_lock.z], [bung_lock.x - 2, neck_opening_end_y, bung_lock.z], [2, neck_opening_end_y, bung_lock.z]],
                faces = [[0, 1, 2, 3], [4, 5, 1, 0], [7, 6, 5, 4], 
                         [5, 6, 2, 1], [6, 7, 3, 2], [7, 4, 0, 3]]);
}


translate([bung_lock.x + 10, 0, 5])
    rotate([180, 0, 180])
        rubber_band_holder([10, 5, 5], 1, 2);

translate([bung_lock.x + 10, 8, 5])
    rotate([180, 0, 180])
        rubber_band_holder([10, 5, 5], 1, 2);

translate([bung_lock.x + 10, 16, 5])
    rotate([180, 0, 180])
        rubber_band_holder([10, 5, 5], 1, 2);

translate([bung_lock.x + 10, 24, 5])
    rotate([180, 0, 180])
        rubber_band_holder([10, 5, 5], 1, 2);



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
