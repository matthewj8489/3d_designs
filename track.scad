use <trains/tracklib.scad>; //https://github.com/dotscad/trains
include <BOSL2/std.scad>; //https://github.com/BelfrySCAD/BOSL2

$fn = 120;
$o = 0.1; // global overlap variable
$slop = 0.075; //0.05 // slop to make connectors fit snug

function pillar_height() = 62; //70

// shorten pillar by 8 mm
//      pillar total height: 62 mm
// shorten total support by 3 mm
//      shorten support between pillars by 2 mm
//      shorten platform/male connector height by 1 mm

//pillar(12, 8);

//track_with_platform_and_pillar_supports();
bridge_pier(pillar_height(), wood_width() + 4);

// two levels of brio bridge
//translate([0, 2, 0])
//    track_with_platform_and_pillar_supports();
//
//translate([22-pillar_thickness()/2, (wood_width()+4)/2, wood_height()])
//    bridge_pier(pillar_height(), wood_width()+4);
//
//translate([0, 2, pillar_height()+wood_height()])
//    track_with_platform_and_pillar_supports();

function platform_height() = 5; //8
function pillar_thickness() = 12;
function pillar_male_h() = 8;

module bridge_pier(pillar_height, bridge_width) {
  pillar_connector_height = 6; //6
  pillar_male_h = pillar_male_h(); //platform_height();
  play = get_slop() * 2;

  // pillars
  fwd((bridge_width + pillar_thickness()) / 2)
    pillar(pillar_height, pillar_male_h);
  back((bridge_width + pillar_thickness()) / 2)
    pillar(pillar_height, pillar_male_h);

  // connection between pillars
  up(pillar_male_h + pillar_height - pillar_connector_height / 2 - platform_height() - play)
    cube([pillar_thickness() - bevel() * 2, bridge_width + $o * 2, pillar_connector_height - $o], center=true);

  // support for connection between pillars
  up(pillar_male_h + pillar_height - bridge_width / 4 - platform_height() - pillar_connector_height)
    back(bridge_width / 4)
      back_half()
        top_half()
          difference() {
            cube([pillar_thickness() - bevel() * 2, bridge_width / 2, bridge_width / 2], center=true);
            yrot(90)
              cylinder(h=pillar_thickness() - bevel() * 2 + $o * 2, r=bridge_width / 4, center=true);
          }

  up(pillar_male_h + pillar_height - bridge_width / 4 - platform_height() - pillar_connector_height)
    fwd(bridge_width / 4)
      front_half()
        top_half()
          difference() {
            cube([pillar_thickness() - bevel() * 2, bridge_width / 2, bridge_width / 2], center=true);
            yrot(90)
              cylinder(h=pillar_thickness() - bevel() * 2 + $o * 2, r=bridge_width / 4, center=true);
          }
}

module track_with_platform_and_pillar_supports() {
  platform_h = platform_height();
  pillar_male_h = pillar_male_h();
  length = 22;

  translate([0, 0, pillar_male_h - platform_h]) {
    translate([0, 0, platform_h]) straight_track(length);

    // platform
    translate([(length + wood_plug_radius() + wood_plug_neck_length()) / 2, wood_width() / 2, platform_h / 2])
      cuboid([length + wood_plug_radius() + wood_plug_neck_length(), wood_width(), platform_h], chamfer=bevel(), edges=BOTTOM);
  }

  right(length - pillar_thickness()) pillar_supports(pillar_male_h);
}

module pillar_supports(pillar_male_height) {
  track_connection_length = 2;
  track_connection_height = pillar_male_height;

  translate([pillar_thickness() / 2, -pillar_thickness() / 2 - track_connection_length, 0])
    pillar(wood_height(), pillar_male_height);
  translate([pillar_thickness() / 2, wood_width() + pillar_thickness() / 2 + track_connection_length, 0])
    pillar(wood_height(), pillar_male_height);

  // connection to pillar
  translate([bevel(), -track_connection_length, pillar_male_height])
    cube([pillar_thickness() - bevel() * 2, track_connection_length, track_connection_height]);
  translate([bevel(), wood_width(), pillar_male_height])
    cube([pillar_thickness() - bevel() * 2, track_connection_length, track_connection_height]);
}

module pillar(height, male_height) {
  assert(height >= male_height, "The pillar height must be at least as tall as the male pillar connector");

  pillar_width = pillar_thickness();
  male_width = pillar_width - 4;
  play = get_slop() * 8;

  up(height / 2 + male_height) {
    difference() {
      cuboid([pillar_width, pillar_width, height], chamfer=bevel(), edges="Z");
      up((height - male_height) / 2) cube([male_width + play, male_width + play, male_height + $o], true);
    }
    up(-height / 2 - male_height / 2) cube([male_width, male_width, male_height], true);
  }
}

module straight_track(length = 53.5) {
  difference() {
    wood_track(length);
    translate([0, wood_width() / 2, 0])
      wood_cutout();
  }

  translate([length, wood_width() / 2, 0]) wood_plug();
}
