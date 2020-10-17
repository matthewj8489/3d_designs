$fn=50;
e=0.1;

bottle_radius = 36;
lid_width = 53;
lid_depth = 35;

height = 5;
thickness = 4;
thickness_lid = thickness * 2;

difference() {
    cylinder(height, r=bottle_radius+thickness, true); 
    
    cylinder(height + e, r=bottle_radius, true);
}

difference() {
    translate([-((lid_width + thickness_lid)/2), bottle_radius-10, 0])
    {
        difference() {
            cube([lid_width + thickness_lid, lid_depth + thickness_lid, height]);
            
            translate([thickness_lid / 2, thickness_lid / 2, 0])
                cube([lid_width, lid_depth + thickness_lid / 2 + e, height + e]);
        }
    }

    cylinder(height, r=bottle_radius+thickness, true);
    
}