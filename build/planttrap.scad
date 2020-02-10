/* Note 


*/


/*set to tray dimmensions in mm*/
noz_w = 0.4; //nozzle width mm
num_walls = 3; //number of walls

/*Set to printer specs...
  These values will be used to calculate prints that
  do not require an infill. 
  This should reduce retracts and result 
  in better quality and faster prints. 
*/
lay_h=0.2;
lay_1=0.28;
base_layers=4;


/*Tray specs*/
tray_w=30; 
tray_d=10;

/*Pot specs set to radius of pot...
*  Radius = half the diameter 
*  There are 25.4mm to an inch 
*
*  i.e. 
*  5.5 inch pot
*	5.5in * 25.4mm = 139.7mm
*	140/2 = 70mm
*	pot is 10mm thick
*	70 - 10 = 60mm
*
*/

pot_od = 70;
pot_id = 60;

/*how much tray...*/
angle=90;


/*------------No Touch Below------------*/

/*calculated values*/

base_thk = lay_1 + ((base_layers-1) * lay_h);

/*supporting functions*/

module tray () {
	rotate_extrude(angle=angle, $fn=200)
	translate([pot_od,0,0])
	square([tray_w,tray_d]);
}


module tray_void(){
	rotate_extrude(angle=angle, $fn=200)
	//offset on 3 axis
	translate([pot_od + (noz_w*num_walls),base_thk])
	square([tray_w - ((noz_w*num_walls)*2),tray_d]);
}


module tray_in () {
	rotate_extrude(angle=angle, $fn=200)
	translate([pot_id - tray_w,0,0])
	square([tray_w,tray_d]);
}

module tray_in_void(){
	rotate_extrude(angle=angle, $fn=200)
	//offset on 3 axis
	translate([pot_id - tray_w + (noz_w*num_walls),base_thk])
	square([tray_w - ((noz_w*num_walls)*2),tray_d]);
}


module tray_ends(){
	//end 1
	translate([pot_od,0,0])
	cube([tray_w,(noz_w*num_walls),tray_d]);
	//end 2
	rotate([0,0,angle])
	translate([pot_od,-(noz_w*num_walls),0])
	cube([tray_w,(noz_w*num_walls),tray_d]);
}



module tray_in_ends(){
	//end 1
	translate([pot_id - tray_w,0,0])
	cube([tray_w,(noz_w*num_walls),tray_d]);
	//end 2
	rotate([0,0,angle])
	translate([pot_id - tray_w ,-(noz_w*num_walls),0])
	cube([tray_w,(noz_w*num_walls),tray_d]);
}


/*Higher order functinos */

module outer_tray(){
	//OD Tray
	union(){
		tray_ends();
		difference(){
			tray();
			color("blue")
			tray_void();
		}
	}
}

module inner_tray(){
	//ID Tray
	union(){
		tray_in_ends();
		difference(){
			tray_in();
			color("blue")
			tray_in_void();
		}
	}
}



/*---------Main------------*/

// Comment out here to produce only one tray.....

// e.g. 

//inner_tray();

inner_tray();

outer_tray();




