use <trains/tracklib.scad>; //https://github.com/dotscad/trains

$fn=120;
$o=0.1; // global overlap variable



//pillar();
pillared_bridge_track_connector();
//pillar_bridge();


// two levels of brio bridge
//pillared_bridge_track_connector();
//
//translate([0, 0, 12]) {
//    pillar_bridge();
//}
//
//translate([0, 0, 50+pillar_male_height()*2])
//    pillared_bridge_track_connector();


module pillar_bridge(pillar_height=50) {
    pillar_connector_height = 10;
    translate([pillar_radius(), -pillar_radius(), 0]) pillar(pillar_height);
    translate([pillar_radius(), wood_width()+pillar_radius(), 0]) pillar(pillar_height);
    
    translate([0, -pillar_radius(), pillar_height-pillar_connector_height])
        cube([pillar_radius()*2, wood_width()+pillar_radius()*2, pillar_connector_height-$o]);
}


module pillared_bridge_track_connector() {
    platform_h = pillar_male_height();
    length = 22;

    translate([0, 0, platform_h]) straight_track(length);
    
    // platform
    difference() {
        cube([length+wood_plug_radius()+wood_plug_neck_length(), wood_width(), platform_h]);
        // chamfer
        translate([-bevel(), 0, 0]) 
            rotate([0,45,0])
                cube([bevel(), wood_width(), bevel()]);
        translate([0, 0, -bevel()]) 
            rotate([45,0,0])
                cube([length+wood_plug_radius()+wood_plug_neck_length(), bevel(), bevel()]);
        translate([length+wood_plug_radius()+wood_plug_neck_length()-0.45, 0, 0]) 
            rotate([0,45,0])
                cube([bevel(), wood_width(), bevel()]);
        translate([0, wood_width(), -bevel()]) 
            rotate([45,0,0])
                cube([length+wood_plug_radius()+wood_plug_neck_length(), bevel(), bevel()]);
    }

    translate([pillar_radius(), -pillar_radius(), 0]) pillar();
    translate([pillar_radius(), wood_width() + pillar_radius(), 0]) pillar();

    // connection to pillar
    translate([0, -5, platform_h]) pillar_track_connection();
    translate([0, 5+wood_width(), platform_h]) mirror([0, 1, 0]) pillar_track_connection();
}

module pillar_track_connection(height=17) {
    difference() {
        translate([2.5, 0, 0]) cube([15, 5, height - pillar_male_height() - sqrt(.5)*bevel()]);
        translate([pillar_radius(), -pillar_radius() + 5, 0]) cylinder(height - pillar_male_height()+$o, pillar_radius(), pillar_radius());
    }
}

function pillar_male_height() = 6;
function pillar_radius() = 10;

module pillar(height=12) { 
    assert(height>=pillar_male_height(), "The pillar height must be at least as tall as the male pillar connector");
    play = 0.1;
    male_top_radius = pillar_radius() - 1;
    male_bottom_radius = pillar_radius() - 4;
    difference() {
        translate([0, 0, pillar_male_height()]) cylinder(height, pillar_radius(), pillar_radius());
        translate([0, 0, height]) cylinder(pillar_male_height()+$o, male_bottom_radius + play, male_top_radius + play);
    }
    cylinder(pillar_male_height(), male_bottom_radius, male_top_radius);
}

module straight_track(length=53.5) {
    difference() {
        wood_track(length);
        translate([0, wood_width()/2, 0]) wood_cutout();
    }

    translate([length, wood_width()/2, 0]) wood_plug();
}