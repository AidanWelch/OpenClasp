use <threadlib/threadlib.scad>
$fn = 300;

coin_diameter = 34;
coin_width = 2.25;
wall_thickness = 1.25;
gap = 0.5;
threading = "UNC-#6";
thread_turns = 4;

outer_diameter = coin_diameter + (wall_thickness * 2);
inner_diameter = coin_diameter - (wall_thickness * 2);
outer_width = coin_width + (wall_thickness * 2);

t_spec = thread_specs(str(threading, "-ext"));
thread_pitch = t_spec[0];
thread_height = thread_pitch * (thread_turns+1);
thread_dsup = t_spec[2]; // Dsup: Recommended diameter of support structure of the thread (i.e., of cylinder for external thread and hole for internal thread)


bolt_z_offset = -thread_pitch / 2;

loop_height = 2.5;
loop_diameter = 1.75;


difference(){
    union(){
        difference(){
            translate([0,0,outer_diameter / 2 + bolt_z_offset + thread_height])
            cylinder(h = loop_height, d=thread_dsup);
            
                        translate([0,0,outer_diameter / 2 + bolt_z_offset + thread_height + (loop_height/2)])
            rotate([0, 90, 0])
            cylinder(h = 9999, d=loop_diameter, center=true);
        };
            
        translate([0,0,outer_diameter / 2])
        bolt(threading, turns=thread_turns, higbee_arc=30);

        rotate([90,0,0])
        difference(){
            cylinder(h = outer_width, d = outer_diameter, center = true);
            cylinder(h = coin_width, d = coin_diameter, center = true);
            cylinder(h = outer_width + 1, d = inner_diameter, center = true);
        };
    };

    translate([0,0,(9999/2)])
    cube([gap, 9999, 9999], center = true);

};