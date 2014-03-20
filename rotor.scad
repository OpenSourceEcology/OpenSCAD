use <lib/rotor_parts.scad>

$fn = 24;

scale([25.4,25.4,25.4]) {
	//shaft(71+1/2,6+1/4,3.5+1/4);
	//tine_module(3,0);
	//tine_collar(3,1,0,1/2);
	//tine_plus_unbent(1/4);
	rotate([0,90,0]) {
		rotor(length=71+1/2,left=6+1/4,right=3.5+1/4,collar_length=3, spacing=3/4);
	}
}
