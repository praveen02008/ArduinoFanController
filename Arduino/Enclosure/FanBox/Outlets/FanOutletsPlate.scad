

module noCornersCube(width, height, depth, cornerRadius) {
    
    //cube([width, height, depth]);
    union() {
        linear_extrude(height=depth) {
            // Square with corners cut.
            polygon([
            [cornerRadius,0],
            [width-cornerRadius, 0],
            [width, cornerRadius],
            [width, height-cornerRadius],
            [width-cornerRadius, height],
            [cornerRadius, height],
            [0, height-cornerRadius],
            [0, cornerRadius],
            [cornerRadius,0]
            ]);
        }
        
    }
}

module roundedCube(width, height, depth, cornerRadius) {
    
    //cube([width, height, depth]);
    union() {
        translate([cornerRadius,cornerRadius,0]) {
            cylinder(r=cornerRadius, h=depth);   
        }
        translate([width-cornerRadius,cornerRadius,0]) {
            cylinder(r=cornerRadius, h=depth);
        }
        translate([cornerRadius,height-cornerRadius,0]) {
            cylinder(r=cornerRadius, h=depth);
        }
        translate([width-cornerRadius,height-cornerRadius,0]) {
            cylinder(r=cornerRadius, h=depth);
        }
        
        noCornersCube(width, height, depth, cornerRadius);
    }
}

module mountinghole(xOffset, yOffset) {
    // Mounting holes...
    // First hole, 10mm from left edge
    translate([5 + xOffset, 15 + yOffset, -0.01]) {
        cylinder(d=7, h=5, $fn=80);
        // 7mm hole to allow clearance for a M3 nut to drop in
        // so the bolt can be held in place.
        // this outlet place is then held in with an upper assembly.
    }
}

module mountingHoles() {
    // Holes 90mm appart on X (110mm x hole, 10mm in each side).
    // Holes -5 and +5 from Y edges. Y is 120 long
    translate([0,0,0]) {
        mountinghole(10, -5);
        #mountinghole(100, -5);
        mountinghole(10, 120+5);
        mountinghole(100, 120+5);
    }
}

// Inset piece.
// FIXED SIZE
translate([5,15,-5]) {
    difference() {
        union() {
            roundedCube(110, 120, 5, 4);
        }
        union() {
            translate([2,2,-0.01]) {
                #roundedCube(110-4, 120-4, 5.1, 4);
            }
        }
    }
}

// Face peice
// face is 5mm from edge in x (+/-5mm side to side
// 10mm in the y (+/-10mm back to front).
difference() {
    union() {
        roundedCube(120, 145,3, 4);
    }
    union() {
        translate([7,17,-0.01]) {
            #roundedCube(120-(4+10), 130-(4+10), 3.1, 4);
        }
        mountingHoles();
    }
}