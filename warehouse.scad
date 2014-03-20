use <lib/warehouse_parts.scad>


module beams () {
	for (i = [1:24]) {
		translate([6*(i-1),0,0]) {
			ose_beam(thickness=1/4, length=i*4);
		}
	}
}

module plates() {
	for (i=[1:4]) {
		translate([6*(i-1),0,0]) {
			ose_plate(thickness=1/2, length=i*4, width=4);
		}
	}

	for (i=[2:4]) {
		translate([10*(i-2)+26,0,0]) {
			ose_plate(thickness=1/2, length=i*4, width=8);
		}
	}
	translate([56,0,0])
		pivot_plate();
}

module axles(axle_lengths = [3,6,7,8,9,10,14,18]) {
	for (i=[0:len(axle_lengths)-1]) {
		translate([i*4,0, 0]) {
			axle(axle_lengths[i]);
		}
	}
}


scale([25.4,25.4,25.4]) {

	beams();

	translate([0,64,0]) {
		plates();
	}

	translate([0,36,0]) {
		axles();
	}

}
