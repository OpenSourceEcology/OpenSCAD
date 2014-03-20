use <../MCAD/regular_shapes.scad>

length=72;
left=5;
right=5;
collar_length=3;

module bolt() {
	cylinder(r=5/8/2, h=1+3/4);
	translate([0,0,0]) {
		linear_extrude(height=.5) {hexagon((1+1/8)/2);}
	}
	translate([0,0,1+3/4]) {
		linear_extrude(height=.5) {hexagon((1+1/8)/2);}
	}
}

module tine_end() {
	scale([1,2,1]) {
		intersection() {
			difference() {
				cylinder(r=1,h=2, center=true);
				cylinder(r=1-1/4,h=2+.2,center=true);
			}
			translate([-1,0,0]) {
				cube(1,1,1);
			}
		}
	}
}

module tine_plus(thickness) {
	translate([0,0,1/8]) {
		difference() {
			union() {
				cube(size=[2,7,1/4],center=true);
				cube(size=[7,2,1/4],center=true);
			}
			cylinder(r=1+1/32, h=collar_length, center=true);
		}
	}
}

module tine_plus_unbent(thickness) {
	translate([0,0,1/8]) {
		difference() {
			union() {
				cube(size=[2,10,1/4],center=true);
				cube(size=[10,2,1/4],center=true);
			}
			cylinder(r=1+1/32, h=collar_length, center=true);
		}
	}
}

module tine() {
	translate([0,1,-1+1/8]) {
		rotate([0,90,0]) {
			tine_end();
		}
	}
	translate([-1,1,-1+2-1/8]) {
		rotate([0,90,0]) {
			mirror([1,0,0]) {
				tine_end();
			}
		}
	}
}

module tine_collar(length, radius, bolt_angle, bolt_size) {
	// collar
	difference() {
		cylinder(r=radius+1/4, h=length);
		//inner
		translate([0,0,-.1]) {
			cylinder(r=radius, h=length+.2);
		}
		//bolt hole
		translate([0,0,2]) {
			rotate([90,0,bolt_angle]) {
				cylinder(r=bolt_size/2, h=2);
			}
		}
	}
}

module tine_module(collar_length, bolt_angle) {
	collar_radius = 1;
	collar_thickness = 1/4;

	tine_collar(collar_length, collar_radius, bolt_angle, 5/8);

	for(i = [0:3]) {
		rotate(90*i,0,0) {
			translate([0,2+1/4,1/8]) {
				tine();
			}
		}
	}
	tine_plus();
	translate([0,0,2]) {
		rotate([90,0,bolt_angle]) {
			translate([0,0,collar_radius+collar_thickness]) {
				bolt();
			}
		}
	}

}

module shaft(length, left, right) {
	keyway = (.5-.0025)/2;
	//shaft
	translate([0,0,-left]) {
		difference() {
			cylinder(r=(1+7/8)/2, h=left+length+right);
			//keyway
			translate([(1+7/8)/2-keyway/2,0,1-.05]) {
				cube(size=[keyway,.5,2+.1],center=true);
			}
			// screws
			translate([-(1+7/8)/2+15/16/2, 0, 5/6]) {
				rotate([0,90,0]) {
					cylinder(r=1/4, h=15/16, center=true);
					translate([-5/6,0,0]) {
						cylinder(r=1/4, h=15/16, center=true);
					}
				}
			}
		}
	}
}

module rotor(length,left,right,collar_length, spacing) {
	shaft(length,left,right);

	collar_total_length = collar_length + spacing;
	collars = floor(length / collar_total_length)-1;
	leftover = length - collars * collar_total_length;

	translate([0,0,collar_length+(leftover-collar_length)/2]) {
		for(i = [0 : collars-1]) {
			translate([0,0,collar_total_length * i]) {
				rotate([0,0,-45*(i%2)+$t*720]) {
					tine_module(collar_length, (i % 2)*45);
				}
			}
		}
	}
}
