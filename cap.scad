use <threadlib/threadlib.scad>
// generate cap nut or bolt style
nut_or_bolt = "Nut"; //  [Nut,Bolt]

// height of the cap (without thread)
cap_height = 3; // [0:0.1:20]
// diameter of the cap
cap_diameter = 93; // [46:0.5:100]
// thread turns
thread_turns = 4; // [1:1:20]
// thread style
thread_style = "G2 3/4";

// should a knurl be added to the cap
knurl_enabled = true; // [true,false]
// space multiplier
knurl_spacer = 1; // [1:1:8]
// boldness of the knurl
knurl_boldness = 2.3; // [1:0.1:3]

// in bolt mode inner wall thickness
inner_wall_thickness = 5; // [0:0.5:30]
// bolt mode hollow
hollow = true; // [true;false]

/* [Hidden] */
// segments
cap_segments = 128;
specs = thread_specs(str(thread_style, "-int"));
P = specs[0];
Dsupport = specs[2];

thread_height = ((thread_turns+0.5) * P);
knurl_height = (nut_or_bolt == "Nut")?thread_height + cap_height:cap_height;

cylinder(h=cap_height, d=cap_diameter, $fn=cap_segments);
translate([0, 0, cap_height + 0.1]) {
    if (nut_or_bolt == "Nut") {
        nut(thread_style, turns=thread_turns, Douter=cap_diameter);
    } else {
        difference() {
            bolt(thread_style, turns=thread_turns);
            if (hollow) {
                cylinder(h=thread_height+1, d=Dsupport-P-inner_wall_thickness, $fn=cap_segments);
            }
        }
    }
}

if (knurl_enabled) {
    knurl_diameter = PI * cap_diameter / cap_segments * knurl_boldness;
    knurl_step = 360 / cap_segments * knurl_spacer*2;

    for (a = [0 : knurl_step : 359]) {
        dx = (cap_diameter / 2 - 1) * sin(a + knurl_step / 3);
        dy = (cap_diameter / 2 - 1) * cos(a + knurl_step / 3);

        translate([dx, dy, 0]) cylinder(d = knurl_diameter, h = knurl_height, $fn = 12);
    }
}
