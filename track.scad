use <trains/tracklib.scad>;

$fn=120;

straight_track();


module bridge(length=100) {
    translate([0, 0, 50]) straight_track(length);

    difference() {
        cube([118, 40, 50]);
        translate([0, 0, 10]) cube([118, 15, 30]);
        translate([0, 25, 10]) cube([118, 15, 30]);
        translate([18, 0, 0]) cube([75, 40, 50]);
    }
}

module straight_track(length=53.5) {
    difference() {
        wood_track(length);
        translate([0, 20, 0]) wood_cutout();
    }

    translate([length, 20, 0]) wood_plug();
}