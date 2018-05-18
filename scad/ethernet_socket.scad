/*
Copyright (C) 2018 Lubos Dolezel <lubos@dolezel.info>
This work is licensed under the Creative Commons Attribution-NonCommercial-ShareAlike 3.0 Unported License. To view a copy of this license, visit http://creativecommons.org/licenses/by-nc-sa/3.0/ or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
*/

DOUBLE = false;
ROUNDED_TOP = true;

include <tango_shape.scad>

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
            sphere(d=6, $fn=20);
        }
        
        tango_shape(30);
    }
}

module body() {
    difference() {
        union() {
            tango_shape(10);
            front_rounded();
        }
        
        if (!ROUNDED_TOP) {
            scale([0.94,0.94,1])
            tango_shape(12);
        } else {
            scale([0.94,0.94,0.94])
            tango_shape(12);
        }
    }
}

module screw_tunnel() {
    difference() {
        cylinder(h=13, d=6.5);
        cylinder(h=13, d=3.5);
    }
    //translate([5,0,5])
    //cube([4, 2, 10], center=true);
}

module locking_tunnel() {
    difference() {
        translate([0,0,9])
            cube([19, 28, 10], center=true);
        
        translate([0,0,11])
            cube([16,24,10], center=true);
        
        translate([0,0,5])
            cube([15,20,2], center=true);
    
    }
    
    if (ROUNDED_TOP) {
        translate([0,0,4])
        rotate([0,180,0])
        difference() {
            linear_extrude(5, scale=[1, 1.3])
                square([21,28], center=true);
            
            linear_extrude(5, scale=[1.1, 1.6])
                square([16.5,20], center=true);
        }
    }
}

module everything() {
    difference() {
        translate([0,0,ROUNDED_TOP ? -1 : 0]) body();
        
        if (!DOUBLE) {
            translate([0,1.5,10])
                linear_extrude(5, scale=[1,0.65])
                square([15,25.75], center=true);
        } else {
            for(z=[0,180])
            translate([0, 1.5, 0])
            rotate([0,0,z]) {
                translate([11,0,10])
                linear_extrude(5, scale=[1,0.65])
                square([15,25.75], center=true);
                
                //translate([11,-1,4])
                //cube([15,24,20], center=true);            
                
            }
        }
        
        for(z=[0,180]) {
            rotate([0,0,z]) {
                translate([58.5/2,0,12])
                cylinder(h=3, d=6.5, $fn=50);
                
                translate([58.5/2,0,8])
                cylinder(h=5, d=3.5, $fn=50);
            }
        }
    }

    if (!DOUBLE) {
        locking_tunnel();
        
        for(z=[0,180]) {
            rotate([0,0,z])
            translate([9,-1,0]) {
                if (ROUNDED_TOP)
                    translate([0,0,-1]) cube([17,2,14]);
                else
                    translate([0,0,4]) cube([17,2,8]);
            }
        }
    } else {
        for(z=[0,180]) {
            rotate([0,0,z]) {
                translate([11,0,0])
                locking_tunnel();

                translate([20,-1,ROUNDED_TOP ? -1 : 4])
                cube([6,2,10]);
            }
        }
    }

    for(z=[0,180])
    rotate([0,0,z])
    translate([58/2,0,ROUNDED_TOP ? -1 : 0])
    screw_tunnel($fn=50);

}

everything();


