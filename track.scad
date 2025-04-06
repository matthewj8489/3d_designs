use <trains/tracklib.scad>;

$fn=120;


pillared_bridge_track_connector();


module pillared_bridge_track_connector() {
    platform_h = 5;

    translate([0, 0, platform_h]) straight_track(22);
    cube([40, 40, platform_h]);

    translate([10, -10, 0]) pillar();
    translate([10, 50, 0]) pillar();

    // connection to pillar
    translate([0, -5, platform_h]) pillar_track_connection();
    translate([0, 45, platform_h]) mirror([0, 1, 0]) pillar_track_connection();
}

module pillar_track_connection(height=17, pillar_male_h=5) {
    difference() {
        translate([2.5, 0, 0]) cube([15, 5, 17 - pillar_male_h]);
        translate([10, -10 + 5, 0]) cylinder(17 - pillar_male_h, 10, 10);
    }
}

module pillar(height=17, male_h=5) {
    play = 0.5;
    difference() {
        translate([0, 0, male_h]) cylinder(height - male_h, 10, 10);
        translate([0, 0, height - male_h]) cylinder(male_h, 6 + play, 8 + play);
    }
    cylinder(male_h, 6, 8);
}

module straight_track(length=53.5) {
    difference() {
        wood_track(length);
        translate([0, 20, 0]) wood_cutout();
    }

    translate([length, 20, 0]) wood_plug();
}