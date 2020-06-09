module horn_goldilocks_array(
    height = 2.5,
    plot = 10,
    tolerances = [0, .1, .2, .3, .4, .5, .6, .7, .8, .9, 1],
    shim_counts = [0, 3, 6]
) {
    difference() {
        cube([
            plot * len(tolerances),
            plot * len(shim_counts),
            height
        ]);

        for (i_tolerance = [0 : len(tolerances) - 1]) {
            for (i_shim_count = [0 : len(shim_counts) - 1]) {
                translate([
                    i_tolerance * plot + plot / 2,
                    i_shim_count * plot + plot / 2,
                    0
                ]) {
                    // So now we have X and Y as tolerances[i_tolerance] and
                    // shim_counts[i_shim_count], and they can be used to make
                    // each individual test.
                    // Here, for example, they're passed as arguments to an
                    // external cavity() module.
                    cavity(
                        diameter = SERVO_SHAFT_DIAMETER
                            + tolerances[i_tolerance] * 2,
                        shim_count = shim_counts[i_shim_count],
                        height = height
                    );
                }
            }
        }
    }
}
