/*
Copyright (C) 2018 Lubos Dolezel <lubos@dolezel.info>
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
*/

include <tango_shape.scad>

COUNT = 2;

module base_shape() {
    hull() {
        scale([81/66,81/66,1])
        tango_shape(8);
        
        scale([75/66,75/66,1])
        tango_shape(11);
    }
}

module rounded_shape() {
    dd=12;
    
    intersection() {
        scale([100/(100+dd),100/(100+dd),100/120])
            minkowski() {
                base_shape();
                sphere(d=dd, $fn=50);
            };
        
        scale([81/66,81/66,1])
            tango_shape(11);
    }
}

module n_shape() {
    hull() {
        // left side
        intersection() {
            rounded_shape();
            translate([-200,-100,0])
            cube([200, 200, 30]);
        }
        
        // right side
        translate([(67+4)*(COUNT-1),0,0])
        intersection() {
            rounded_shape();
            translate([0,-100,0])
            cube([200, 200, 30]);
        }
    }
}

module rounded_rect(size, radius)
{
    x = size[0];
    y = size[1];
    z = size[2];

    linear_extrude(height=z)
    hull()
    {
        // place 4 circles in the corners, with the given radius
        translate([(-x/2)+(radius/2), (-y/2)+(radius/2), 0])
        circle(r=radius);

        translate([(x/2)-(radius/2), (-y/2)+(radius/2), 0])
        circle(r=radius);

        translate([(-x/2)+(radius/2), (y/2)-(radius/2), 0])
        circle(r=radius);

        translate([(x/2)-(radius/2), (y/2)-(radius/2), 0])
        circle(r=radius);
    }
}

module bottom() {
    difference() {
        // 57mm
        translate([0,0,1])
        cube([70,70,2], center=true);
    
        for (z=[0, 45])
            rotate([0,0,z])
            rounded_rect([57-6, 57-6, 2], 6);
    }
}

difference() {
    n_shape();
    
    for (i = [0 : COUNT-1]) {
        translate([(67+4)*i,0,0])
        scale([68/66,67/66,1])
        tango_shape(11);
    }
}

for (i = [0 : COUNT-1]) {
    translate([(67+4)*i,0,0])
        bottom();
}
