with Dashboard; use Dashboard;
with Ada.Text_IO; use Ada.Text_IO;

package WarningSystem is

   type WarningLight is (Green, Amber, Red);
   type Warning_System is record 
      fuelWarning: WarningLight;
      heightWarning: WarningLight;
      speedWarning: WarningLight;
   end record;
   
    procedure fuelWarning(light: in out Warning_System; dashboard: in out DashboardSystem)  with
        Global => (In_Out => (File_System)),
        Pre => dashboard.fuel_tank <= 25,
        Post => light.fuelWarning = Red;

    procedure speedWarning(light: in out Warning_System; dashboard: in out DashboardSystem) with
        Global =>(In_Out => (File_System)),
        Pre =>  dashboard.velocity < 250 and dashboard.velocity > 1000,
        Post => light.speedWarning = Red;

      procedure altitudeWarning(light: in out Warning_System; dashboard: in out DashboardSystem) with
        Global =>(In_Out => (File_System)),
        Pre => dashboard.height < 500 and dashboard.height > 1200,
        Post => light.heightWarning = Red;

end WarningSystem;
