with Ada.Text_IO; use Ada.Text_IO;

package body CommercialPlaneSystem with SPARK_Mode is

   procedure fuelUsage is
   begin
      if (commercialPlane.mode = Flying and commercialPlane.dashboard_system.fuel_tank >= 10) then
         commercialPlane.dashboard_system.fuel_tank := commercialPlane.dashboard_system.fuel_tank -10;
      end if;
   end fuelUsage;

   procedure InTow is
   begin
      if (commercialPlane.mode = Idle and commercialPlane.dashboard_system.velocity = 0 and commercialPlane.dashboard_system.height = 0) then
         commercialPlane.ignition.status := Off;
      end if;
   end InTow;

    procedure increaseAirspeed is
   begin
      commercialPlane.dashboard_system.velocity := commercialPlane.dashboard_system.velocity + 10;
   end increaseAirspeed;

    procedure decreaseAirspeed is
   begin
      if commercialPlane.mode = Flying and commercialPlane.dashboard_system.velocity <= 1000 and commercialPlane.dashboard_system.velocity >= 250 then
         commercialPlane.dashboard_system.velocity := commercialPlane.dashboard_system.velocity - 10;
         Put_Line("Slowing down. commercialPlane velocity is "&commercialPlane.dashboard_system.velocity'Image);
         end if;
   end decreaseAirspeed;

    procedure increaseAltitude is
    begin
      commercialPlane.dashboard_system.height := commercialPlane.dashboard_system.height + 50;
      if (commercialPlane.dashboard_system.height > 100 and commercialPlane.landGear = Lowered) then
         commercialPlane.landGear := Unlowered;
      end if;
   end increaseAltitude;

   procedure decreaseAltitude is
   begin
      commercialPlane.dashboard_system.height := commercialPlane.dashboard_system.height - 50;
      Put_Line("Decreasing altitude. commercialPlane altitude is "&commercialPlane.dashboard_system.height'Image);
   end decreaseAltitude;

   procedure addPassenger is
   begin
     if commercialPlane.mode = Idle and commercialPlane.extDoor.door = Open and commercialPlane.num_passengers < 100 then
         commercialPlane.num_passengers := commercialPlane.num_passengers + 1;
      end if;
   end addPassenger;

   procedure adjustFuelUsage is
   begin
      if commercialPlane.mode = Flying and commercialPlane.dashboard_system.fuel_tank >= 25 then
         commercialPlane.dashboard_system.fuel_tank := commercialPlane.dashboard_system.fuel_tank - 15;
      end if;

   end adjustFuelUsage;

end CommercialPlaneSystem;
