use <trains/tracklib.scad>; //https://github.com/dotscad/trains

$fn=120;
$o=0.1; // global overlap variable


//pillar(12, 8);
track_with_platform_and_pillar_connectors();
//bridge_riser(70, wood_width()+4);

// two levels of brio bridge
//translate([0, 2, 0])
//    track_with_platform_and_pillar_connectors();
//
//translate([0, 0, wood_height()-platform_height()])
//    bridge_riser(70, wood_width()+4);
//
//translate([0, 2, 70+wood_height()-platform_height()])
//    track_with_platform_and_pillar_connectors();


function platform_height() = 8;
function pillar_thickness() = 12;


module bridge_riser(pillar_height, bridge_width) {
    pillar_connector_height = 6;
    pillar_male_h = platform_height();
    play = 0.5;
    
    translate([pillar_thickness()/2, -pillar_thickness()/2, 0]) 
        pillar(pillar_height, pillar_male_h);
    translate([pillar_thickness()/2, bridge_width+pillar_thickness()/2, 0]) 
        pillar(pillar_height, pillar_male_h);
    translate([0, 0-$o, pillar_male_h+pillar_height-pillar_connector_height-pillar_male_h-play])
        cube([pillar_thickness(), bridge_width+$o, pillar_connector_height-$o]);
}

module track_with_platform_and_pillar_connectors() {
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

    pillar_connectors(platform_h);
}

module pillar_connectors(pillar_male_height) {
    track_connection_length = 2;
    track_connection_height = pillar_male_height;
    
    translate([pillar_thickness()/2, -pillar_thickness()/2 - track_connection_length, 0])
        pillar(12, pillar_male_height);
    translate([pillar_thickness()/2, wood_width() + pillar_thickness()/2 + track_connection_length, 0])
        pillar(12, pillar_male_height);

    // connection to pillar
    translate([0, -track_connection_length, pillar_male_height]) 
        cube([pillar_thickness(), track_connection_length, track_connection_height]);
    translate([0, wood_width(), pillar_male_height]) 
        cube([pillar_thickness(), track_connection_length, track_connection_height]);
}

module pillar(height, male_height) {
    assert(height>=male_height, "The pillar height must be at least as tall as the male pillar connector");
    
    play = 0.1;
    pillar_width = pillar_thickness();
    male_width = pillar_width - 4;
    
    translate([0,0,height/2+male_height]) {
        difference() {
            cube([pillar_width, pillar_width, height], true);
            translate([0, 0, (height-male_height)/2]) cube([male_width+play, male_width+play, male_height+$o], true);
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