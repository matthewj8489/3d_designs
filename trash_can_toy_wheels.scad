include <BOSL2/std.scad>

$fn = 120;
$o = 0.1; // global overlap variable
$slop = 0.075; //0.05 // slop to make connectors fit snug: 20% infill, Fine resolution

wheel_thickness = 5;
wheel_radius = 9;
axle_length = 30;
axle_radius = 3;

yrot(90)
  cyl(wheel_thickness, wheel_radius);

right(0.5 * wheel_thickness + 0.5 * axle_length)
  yrot(90)
    cyl(axle_length, axle_radius);

right(axle_length)
  yrot(90)
    cyl(wheel_thickness, wheel_radius);
