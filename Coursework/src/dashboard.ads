package Dashboard is

   type Fuel is range 0..100;
   type Airspeed is range 0..1000;
   type Altitude is range 0..1200;
   
   type DashboardSystem is record
      fuel_tank: Fuel; 
      velocity: Airspeed;
      height: Altitude;
   end record; 

end Dashboard;
