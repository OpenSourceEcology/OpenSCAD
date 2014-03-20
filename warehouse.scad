use <lib/warehouse_parts.scad>


axle_lengths = [3,6,7,8,9,10,14,18];

scale([25.4,25.4,25.4]) {

// beams
for (i = [1:24]) {
	translate([6*(i-1),0,0]) {
		ose_beam(thickness=1/4, length=i*4);
	}
}

// plates
translate([0,64,0]) {
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


// axles
for (i=[0:len(axle_lengths)-1]) {
	translate([i*4,36, 0]) {
		axle(axle_lengths[i]);
	}
}
//axle(3);
//}
	/*for (i = [1:6]) {
		//for (j = [1:2]) {
			translate([10*(i-1),0,0]) {
				//ose_beam(thickness=1/4,length=i*4);
				translate([0,2,0]) 
					//ose_plate(thickness=1/2,length=i*4, width=4);
				mirror([0,1,0]) {
					//ose_plate(thickness=1/2,length=i*4, width=8);
				}
			}
		//}
	}*/

	
	//axle(18);
	//pivot_plate();

}

//ose_plate(1/4, 2, 4);
