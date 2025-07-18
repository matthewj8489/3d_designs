include <BOSL2/std.scad>; //https://github.com/BelfrySCAD/BOSL2
include <BOSL2/gears.scad>;
include <Technic.scad/Technic.scad>; //https://github.com/cfinke/Technic.scad

//$fn = 120;
$o = 0.1; // global overlap variable
$slop = 0.075; //0.05 // slop to make connectors fit snug: 20% infill, Fine resolution

// difference() {
//     cylinder(r=10, h=3, center=true);
//     cylinder(r=2, h=3+$o, center=true);
// }

module wheel() {
    difference() {
        cyl(h = 5, r = 15);
        cube([5, 5, 6], center=true);
    }
}

module gear_and_axle() {
    up(11)
    cube([5, 5, 30], center=true);

    spur_gear(circ_pitch=5, teeth=20, thickness=8, shaft_diam=5);
}



//technic_axle(3);
//technic_axle_connector();
//technic_axle_pin(2,1,false);
//technic_beam(length=3, axle_holes=[1,3]);
//technic_bush();
//technic_gear_single_sided();
//technic_gear_double_sided();
//technic_pin();
//technic_pin_connector(1);
//technic_wheel(diameter=6, width=2);