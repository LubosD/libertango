/*
Copyright (C) 2018 Lubos Dolezel <lubos@dolezel.info>
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
*/

include <tango_shape.scad>;

ROUNDED_TOP = true;
DOUBLE = false;

module front() {
    if (ROUNDED_TOP) {
        intersection() {
            translate([-33,0,-104])
            rotate([0,90,0])
            cylinder(h=66, r=120, $fn=600);
        
            tango_shape(20);
        }
    } else
        tango_shape(15);
}

module front_rounded() {
    intersection() {
        scale([100/106,100/106,100/120])
        minkowski() {
            front();
            sphere(d=6, $fn=50);
        }
        
        tango_shape(30);
    }
}

module screw_tunnelx() {
    difference() {
        cylinder(h=13, d=6.5);
        cylinder(h=13, d=3.5);
    }
    //translate([5,0,5])
    //cube([4, 2, 10], center=true);
}

module body() {
    difference() {
        union() {
            if (ROUNDED_TOP) {
                tango_shape(10);
                front_rounded();
            } else {
                tango_shape(15);
            }
        }
        
        if (!ROUNDED_TOP) {
            scale([0.94,0.94,1])
            tango_shape(9);
        } else {
            scale([0.94,0.94,0.94])
            tango_shape(9);
        }
        
        
    }
}

module panel_negative() {
    translate([0,0,ROUNDED_TOP ? 16.5 : 16])
        cube([45.5, 21.5, 10], center=true);
    
    translate([0,0,10])
        cube([24, 14, 5], center=true);
    
    // For M3*3*4 metal inserts (4mm diameter, 3mm height)
    for (z=[0,180]) {
        rotate([0,0,z])
        translate([17.25,0,8])
        cylinder(d=4, h=5, $fn=40);
    }
    
    
}

difference() {
    body();
    
    if (!DOUBLE) {
        panel_negative();
    } else {
        for (y=[-21.5/2, 21.5/2])
            translate([0,y,0])
            panel_negative();
    }
    
    for(z=[0,180]) {
            rotate([0,0,z]) {
                translate([58.5/2,0,13])
                cylinder(h=3, d=6.5, $fn=50);
                
                translate([58.5/2,0,7])
                cylinder(h=10, d=3.5, $fn=50);
            }
        }
}

for(z=[0,180])
    rotate([0,0,z])
    translate([58/2,0,0])
    screw_tunnel($fn=50);
