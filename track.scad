use <trains/tracklib.scad>; //https://github.com/dotscad/trains

$fn=120;
$o=0.1; // global overlap variable


//translate([-5,0,wood_height()-5]) cube(5);
//wood_track();

//pillar_square(12, platform_height());
//pillar_square_bridge(70, wood_width()+4);

pillared_bridge_track_connector();
//pillar_bridge(60+pillar_male_height());


// two levels of brio bridge
//pillared_bridge_track_connector();
//
//translate([0, 0, 12]) {
//    pillar_bridge();
//}
//
//translate([0, 0, 70+pillar_male_height()*2])
//    pillared_bridge_track_connector();


// two levels of brio bridge
//translate([0, 2, 0])
//    pillared_bridge_track_connector();
//
//translate([0, 0, wood_height()-platform_height()])
//    pillar_square_bridge(70, wood_width()+4);
//
//translate([0, 2, 70+wood_height()-platform_height()])
//    pillared_bridge_track_connector();


module pillar_bridge(pillar_height=70) {
    pillar_connector_height = 10;
    translate([pillar_radius(), -pillar_radius(), 0]) pillar(pillar_height);
    translate([pillar_radius(), wood_width()+pillar_radius(), 0]) pillar(pillar_height);
    
    translate([0, -pillar_radius(), pillar_height-pillar_connector_height])
        cube([pillar_radius()*2, wood_width()+pillar_radius()*2, pillar_connector_height-$o]);
}

module pillar_square_bridge(pillar_height, bridge_width) {
    pillar_connector_height = 6;
    pillar_male_h = platform_height();
    
    translate([pillar_thickness()/2, -pillar_thickness()/2, 0]) 
        pillar_square(pillar_height, pillar_male_h);
    translate([pillar_thickness()/2, bridge_width+pillar_thickness()/2, 0]) 
        pillar_square(pillar_height, pillar_male_h);
    translate([0, 0-$o, pillar_male_h+pillar_height-pillar_connector_height-pillar_male_h])
        cube([pillar_thickness(), bridge_width+$o, pillar_connector_height-$o]);
}

function platform_height() = 8;

module pillared_bridge_track_connector() {
    platform_h = platform_height();
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

    pillared_square_bridge_pillars(platform_h);
}

module pillared_bridge_pillars(platform_h) {
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

module pillared_square_bridge_pillars(pillar_male_height) {
    track_connection_length = 2;
    track_connection_height = pillar_male_height;
    
    translate([pillar_thickness()/2, -pillar_thickness()/2 - track_connection_length, 0]) pillar_square(12, pillar_male_height);
    translate([pillar_thickness()/2, wood_width() + pillar_thickness()/2 + track_connection_length, 0]) pillar_square(12, pillar_male_height);

    // connection to pillar
    translate([0, -track_connection_length, pillar_male_height]) cube([pillar_thickness(), track_connection_length, track_connection_height]);
    translate([0, wood_width(), pillar_male_height]) cube([pillar_thickness(), track_connection_length, track_connection_height]);
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

function pillar_thickness() = 14;

module pillar_square(height, male_height) {
    assert(height>=male_height, "The pillar height must be at least as tall as the male pillar connector");
    
    play = 0.1;
    pillar_width = pillar_thickness();
    male_width = pillar_width - 4;
    
    translate([0,0,height/2+male_height]) {
        difference() {
            cube([pillar_width, pillar_width, height], true);
            translate([0, 0, height-male_height]) cube([male_width+play, male_width+play, male_height+$o], true);
        }
        translate([0,0,-height/2-male_height/2]) cube([male_width, male_width, male_height], true);
    }
}

module straight_track(length=53.5) {
    difference() {
        wood_track(length);
        translate([0, wood_width()/2, 0]) wood_cutout();
    }

    translate([length, wood_width()/2, 0]) wood_plug();
}