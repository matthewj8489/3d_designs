use <trains/tracklib.scad>;

$fn=120;
$o=0.1; // global overlap variable


pillared_bridge_track_connector();


module pillared_bridge_track_connector() {
    platform_h = 5;

    translate([0, 0, platform_h]) straight_track(22);
    cube([40, wood_width(), platform_h]);

    translate([pillar_radius(), -pillar_radius(), 0]) pillar();
    translate([pillar_radius(), wood_width() + pillar_radius(), 0]) pillar();

    // connection to pillar
    translate([0, -5, platform_h]) pillar_track_connection();
    translate([0, 5+wood_width(), platform_h]) mirror([0, 1, 0]) pillar_track_connection();
}

module pillar_track_connection(height=17) {
    difference() {
        translate([2.5, 0, 0]) cube([15, 5, height - pillar_male_height()]);
        translate([pillar_radius(), -pillar_radius() + 5, 0]) cylinder(height - pillar_male_height(), pillar_radius(), pillar_radius());
    }
}

function pillar_male_height() = 5;
function pillar_radius() = 10;

module pillar(height=17) {    
    play = 0.5;
    difference() {
        translate([0, 0, pillar_male_height()]) cylinder(height - pillar_male_height(), pillar_radius(), pillar_radius());
        translate([0, 0, height - pillar_male_height()]) cylinder(pillar_male_height(), pillar_radius() - 4 + play, pillar_radius() - 2 + play);
    }
    cylinder(pillar_male_height(), pillar_radius() - 4, pillar_radius() - 2);
}

module straight_track(length=53.5) {
    difference() {
        wood_track(length);
        translate([0, wood_width()/2, 0]) wood_cutout();
    }

    translate([length, wood_width()/2, 0]) wood_plug();
}