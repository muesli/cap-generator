use <threadlib/threadlib.scad>

// height of the cap (without thread)
cap_height = 3; // [0:0.1:20]
// diameter of the cap
cap_diameter = 52; // [46:0.5:80]
// thread turns
thread_turns = 4; // [1:1:20]
// thread style
thread_style = "12-UN-1 3/4";

cylinder(h=cap_height, d=cap_diameter, $fn=128);
translate([0, 0, cap_height + 0.1])
    nut(thread_style, turns=thread_turns, Douter=cap_diameter);