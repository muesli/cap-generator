use <threadlib/threadlib.scad>

// height of the cap (without thread)
cap_height = 3; // [0:0.1:20]
// diameter of the cap
cap_diameter = 93; // [46:0.5:100]
// thread turns
thread_turns = 4; // [1:1:20]
// thread style
thread_style = "G2 3/4";

// space multiplier
knurl_spacer = 1; // [1:1:8]

// boldness of the knurl
knurl_boldness = 2.3; // [1:0.1:3]

// should a knurl be added to the cap
knurl_enabled = true; // [true,false]

/* [Hidden] */
// segments
cap_segments = 128;


cylinder(h=cap_height, d=cap_diameter, $fn=cap_segments);
translate([0, 0, cap_height + 0.1])
    nut(thread_style, turns=thread_turns, Douter=cap_diameter);
    
    
if (knurl_enabled) {
    knurl_diameter = 3.14 * cap_diameter / cap_segments * knurl_boldness;

    knurl_step = 360 / cap_segments * knurl_spacer*2;

    specs = thread_specs(str(thread_style, "-int"));
    P = specs[0];
    H = ((thread_turns+0.5) * P)+cap_height;

    for (a = [0 : knurl_step : 359]) {

        dx = (cap_diameter / 2 - 1) * sin(a + knurl_step / 3);

        dy = (cap_diameter / 2 - 1) * cos(a + knurl_step / 3);

        translate([dx, dy, 0]) cylinder(d = knurl_diameter, h = H, $fn = 12);

    }   
}
