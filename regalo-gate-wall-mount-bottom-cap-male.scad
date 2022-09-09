$fn=50;

e = 0.1;

// side 1
cap_h = 9;
cap_d = 39;
cap_wall_thick = 2;
ins_h = 15;
ins_d = 14;

// side 2
rec_h = 5;
rec_d = 10;
stop_h = 2;
stop_d = 7;

// helper vars
cap_r = cap_d / 2;
cap_r2 = (cap_d - cap_wall_thick) / 2;
ins_r = ins_d / 2;
rec_r = rec_d / 2;
stop_r = stop_d / 2;

// side 1
difference() {
    side1();

    // side 2
    translate([0, 0, -e])
        cylinder(rec_h, rec_r, rec_r);
}

translate([ins_r, 0, 0])
    spacer();
translate([-ins_r, 0, 0])
    spacer();
translate([0, ins_r, 0])
    spacer();
translate([0, -ins_r, 0])
    spacer();


module side1()
{
    difference() {
        cylinder(cap_h, cap_r, cap_r);
        
        translate([0, 0, cap_wall_thick])
            cylinder(cap_h - cap_wall_thick + e, cap_r2, cap_r2);
    }

    cylinder(ins_h, ins_r, ins_r);
}

module spacer()
{
    translate([0, 0, cap_wall_thick])
        cylinder(ins_h - cap_wall_thick, 0.5, 0);
}