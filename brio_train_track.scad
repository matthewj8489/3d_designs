$fn=50;
e = 0.1;

// train track
width=40;
thickness=12;
conn_male_circle_diameter=12;
conn_male_straight_width=6;
conn_male_straight_length=6;
conn_female_circle_diameter=13;
conn_female_straight_width=7;
conn_female_straight_length=6;
track_side=4;
track_inset=6;
track_inset_depth=2;
track_mid=19;


// track
track_length=40;
translate([width / 2, track_length, 0])
    male_connector();
difference()
{
    track(track_length);
    
    translate([width / 2, 0, 0])
        female_connector();
}


module track(track_length)
{
    difference()
    {
        cube([width, track_length, thickness]);
        
        translate([track_side, 0, thickness - track_inset_depth + e])
            cube([track_inset, track_length, track_inset_depth]);
        
        translate([track_side + track_inset + track_mid, 0, thickness - track_inset_depth + e])
            cube([track_inset, track_length, track_inset_depth]);
    }
}

module male_connector()
{
    translate([-conn_male_straight_width / 2, 0, 0])
    {
        translate([conn_male_straight_width / 2, conn_male_straight_length + conn_male_circle_diameter / 2 - 1, 0])
            cylinder(thickness, r=conn_male_circle_diameter / 2);
        cube([conn_male_straight_width, conn_male_straight_length, thickness]);
    }
}

module female_connector()
{
    translate([-conn_female_straight_width / 2, 0, 0])
    {
        translate([conn_female_straight_width / 2, conn_female_straight_length + conn_female_circle_diameter / 2 - 1, 0])
            cylinder(thickness, r=conn_female_circle_diameter / 2);
        cube([conn_female_straight_width, conn_female_straight_length, thickness]);
    }
}
