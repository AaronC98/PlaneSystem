with Ada.Text_IO; use Ada.Text_IO;
with engine; use engine;
with door; use door;
with Dashboard; use Dashboard;
with WarningSystem; use WarningSystem;
package CommercialPlaneSystem with SPARK_Mode is

   type LandingGear is (Lowered, Unlowered);
   type currentActivity is (TakeOff, Landing, Flying, Idle);
   type Passengers is range 0..100;

   engine_instance: engine_state := (status => Off);
   cockpit_instance: DoorSystem := (door => Closed);
   ext_instance: DoorSystem := (door => Closed);
   dashboard_instance: DashboardSystem := (fuel_tank => 100, velocity => 0, height => 0);
   warning_instance: Warning_System := (fuelWarning => Green, heightWarning => Green, speedWarning => Green);

   type Plane is record
      dashboard_system: DashboardSystem;
      landGear : LandingGear;
      cockpit : DoorSystem;
      extDoor : DoorSystem;
      ignition : engine_state;
      mode : currentActivity;
      num_passengers: Passengers;
      warning_lights: Warning_System;
   end record;

   commercialPlane : Plane :=
     (dashboard_system => dashboard_instance,
      landGear => Unlowered,
      cockpit => cockpit_instance,
      extDoor => ext_instance,
      ignition => engine_instance,
      mode => Idle,
      warning_lights => warning_instance,
      num_passengers => 0);

      procedure fuelUsage with
        Global =>(In_Out => commercialPlane),
        Pre => commercialPlane.mode = Flying and commercialPlane.dashboard_system.fuel_tank >= 10,
        Post => commercialPlane.dashboard_system.fuel_tank = commercialPlane.dashboard_system.fuel_tank'Old - 10;

      procedure InTow with
        Global =>(In_Out => commercialPlane),
        Pre => commercialPlane.mode = Idle and commercialPlane.dashboard_system.velocity = 0 and commercialPlane.dashboard_system.height = 0,
        Post => commercialPlane.ignition.status = Off;

      procedure increaseAirspeed with
        Global =>(In_Out => (commercialPlane)),
        Pre => commercialPlane.mode = TakeOff and commercialPlane.dashboard_system.velocity >= 0 and commercialPlane.dashboard_system.velocity <= 250,
        Post => commercialPlane.dashboard_system.velocity = commercialPlane.dashboard_system.velocity'Old + 10;

       procedure decreaseAirspeed with
        Global =>(In_Out => (commercialPlane, File_System)),
        Pre => commercialPlane.mode = Flying and commercialPlane.dashboard_system.velocity <= 1000 and commercialPlane.dashboard_system.velocity >= 250,
        Post => commercialPlane.dashboard_system.velocity = commercialPlane.dashboard_system.velocity'Old - 10;

       procedure increaseAltitude with
        Global =>(In_Out => (commercialPlane)),
        Pre => commercialPlane.mode = TakeOff and commercialPlane.dashboard_system.height >= 0 and commercialPlane.dashboard_system.height < 500,
        Post => commercialPlane.dashboard_system.height = commercialPlane.dashboard_system.height'Old + 50;

      procedure decreaseAltitude with
        Global =>(In_Out => (commercialPlane, File_System)),
        Pre => commercialPlane.mode = Flying and commercialPlane.dashboard_system.height <= 1200 and commercialPlane.dashboard_system.height > 500,
        Post => commercialPlane.dashboard_system.height = commercialPlane.dashboard_system.height'Old - 50;

     procedure addPassenger with
     Global => (In_Out => (commercialPlane)),
     Pre => commercialPlane.mode = Idle and commercialPlane.extDoor.door = Open and commercialPlane.num_passengers < 100,
     Post => commercialPlane.num_passengers = commercialPlane.num_passengers'Old + 1;

     procedure adjustFuelUsage with
     Global =>(In_Out => commercialPlane),
        Pre => commercialPlane.mode = Flying and commercialPlane.dashboard_system.fuel_tank >= 25,
        Post => commercialPlane.dashboard_system.fuel_tank = commercialPlane.dashboard_system.fuel_tank'Old - 15;



end CommercialPlaneSystem;
