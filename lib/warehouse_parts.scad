use <../MCAD/regular_shapes.scad>

module pipe(width, height, length, thickness) {
	difference() {
		cube(size=[width,height, length], center=true);
		cube(size=[width-thickness*2, height-thickness*2, length+.2], center=true);
	}
}

module holes(n, diameter, interval, thickness) {
	for (i = [0 : n-1]) {
		translate([0,interval*i,0]) {
			cylinder(h=thickness+1,r=diameter/2, center=true);
		}
	}
}

module grid_beam(side, thickness, length, interval, end, diameter) {
	holes = length/interval;

	difference() {
		translate([0,length/2,0]) {
			rotate(a=[90,0,0]) {
				pipe(side, side, length, thickness);
			}
		}
		translate([0,end,0]) {
			holes(holes, diameter, interval, side);
			rotate(a=[0,90,0]) {
				holes(holes,diameter, interval, side);
			}
		}
	}
}

module ose_beam(thickness,length) {
	grid_beam(4,thickness,length,4,2,1+1/8);
}

module grid_plate (thickness, width, length, interval, end, diameter) {
	holes = length/interval;
	difference() {
		translate([0,length/2,0]) cube(size=[width,length,thickness], center=true);
		translate([-width/2,end,0]) {
			for(i = [0:width/interval-1]) {
				translate([i*interval+end,0,0]) holes(holes,diameter,interval, thickness);
			}
		}
	}
}

module ose_plate(thickness, width, length) {
	grid_plate(thickness,width,length,4,2,1+1/8);
}

module pivot_plate() {
	difference() {
		union() {
			translate([0, (12-1/4)/2, 0]) {
				cube([8,12-1/4,1/2], center=true);
			}
			cylinder(r=4, h=1/2, center=true);
		}
	
		translate([0,12-1/4-10]) {
			translate([-2,,0])
				holes(3, 1+1/8, 4, 1/2);
			translate([2,,0])
				holes(3, 1+1/8, 4, 1/2);
		}

		cylinder(r=1.5, h=1,center=true);

	}
}

module axle(height) {
	cylinder(r=1/2, h=height, center=true);
	translate([0,0,height/2])
		linear_extrude(height=5/8) hexagon(7/8);
	translate([0,0,-height/2-5/8])
		linear_extrude(height=5/8) hexagon(7/8);
}

