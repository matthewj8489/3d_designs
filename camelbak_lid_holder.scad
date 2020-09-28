$fn=50;
e=0.1;

bottle_radius = 15;
lid_width = 20;
lid_depth = 15;

height = 5;
thickness = 3;

difference() {
    cylinder(height, r=bottle_radius+thickness, true); 
    
    cylinder(height + e, r=bottle_radius, true);
}

translate([-(lid_width/2), bottle_radius, 0])
{
    difference() {
        cube([lid_width, lid_depth, height]);
        
        translate([thickness / 2, thickness / 2, 0])
            cube([lid_width - thickness, lid_depth - thickness, height + e]);
    }
}