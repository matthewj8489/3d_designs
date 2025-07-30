include <BOSL2/std.scad>; //https://github.com/BelfrySCAD/BOSL2
include <BOSL2/gears.scad>;
include <Technic.scad/Technic.scad>; //https://github.com/cfinke/Technic.scad
use <LEGO.scad/LEGO.scad>; //https://github.com/cfinke/LEGO.scad

//$fn = 120;
$o = 0.1; // global overlap variable
$slop = 0.075; //0.05 // slop to make connectors fit snug: 20% infill, Fine resolution


// Gear Ratios
// https://www.youtube.com/watch?v=txQs3x-UN34&t=136s
// gear ratio = driven teeth / driver teeth = driver rpm / driven rpm
// output torque = input torque * gear ratio
// output rpm = input rpm / gear ratio
// going from a smaller gear to a larger gear increases torque but decreases speed
// going from a larger gear to a smaller gear decreases torque but increases speed

//chassis(16, 2, 4);

// wheel, gear, axle connector
train_wheel();

function axle_receiver_radius() = 1 + get_slop();

module train_wheel(wheel_thickness=5, axle_receiver_h=5, gear_thickness=2) {
    // wheel
    cyl(wheel_thickness, 12);
    
    // gear
    up(wheel_thickness/2 + gear_thickness/2)
    spur_gear(circ_pitch=2, teeth=34, thickness=gear_thickness, shaft_diam=axle_receiver_radius()*2);

    // axle receiver
    up(wheel_thickness/2 + gear_thickness/2 + axle_receiver_h/2)
    difference() {
        cyl(axle_receiver_h, 2);
        cyl(axle_receiver_h+1, axle_receiver_radius());
    }
}

module gear_stabilizer() {
    r_big = 12;
    r_big_2 = 11.5;
    r_small = 4;
    r_peg = 3;
    r_peg_inner = 1.4;
    r_peg_h = 3;
    play = 0.5;

    difference() {
        cyl(r_peg_h, r_peg, center=true);
        cyl(r_peg_h+play, r_peg_inner, center=true);
    }

    right(r_big+r_big_2)
    difference() {
        cyl(r_peg_h, r_peg, center=true);
        cyl(r_peg_h+play, r_peg_inner, center=true);
    }

    right(r_big+r_big_2*2+r_small)
    difference() {
        cyl(r_peg_h, r_peg, center=true);
        cyl(r_peg_h+play, r_peg_inner, center=true);
    }

    fwd(r_peg) left(r_peg) down(r_peg_h/2)
    difference() {
        cube([r_big+r_big_2*2+r_small+r_peg*2, r_peg*2, r_peg_h]);
        right(r_peg-r_peg_inner*2) back(r_peg/2) down(play)
        cube([r_big+r_big_2*2+r_small+r_peg_inner*4, r_peg_inner*2, r_peg_h+play*2]);
    }
}


module chassis(axle_len, lego_width, lego_length) {
    difference() {
        union() {
            block(
                type="brick",
                brand="lego",
                block_bottom_type="closed",
                width=lego_width,
                length=lego_length,
                height=1/3
            );

            up(3) left(20) xrot(90) 
                cyl(axle_len, 3, center=true);

            left(20) fwd(axle_len / 2)
            cube([5, axle_len, 3.2]);
        }

        up(3) left(20) xrot(90) 
            cyl(axle_len+1, 1.4, center=true);
    }

}


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