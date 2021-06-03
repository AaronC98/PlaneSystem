with CommercialPlaneSystem; use CommercialPlaneSystem;
with engine; use engine;
with door; use door;
with planestatus; use planestatus;
with ada.Text_IO; use ada.Text_IO;
with Dashboard; use Dashboard;
with WarningSystem; use WarningSystem;
procedure Main is

   Str : String (1..2);
   Last : Natural;

   task setUp;
   task fuelWarningSystem;
   task takingOff;
   task getFlightCommand;
   task landingPlane;

   task body setUp is
   begin
      loop
         if (commercialPlane.mode = Idle) then
            Put_Line("Press 1 to close external doors. Press 2 to close cockpit doors. Press 3 to turn on the engine.");
            Get_Line(Str, Last);
            case Str(1) is
               when '0' => addPassenger;
                  Put_Line("Number of passengers is now: "&commercialPlane.num_passengers'Image);
               when '1' => CloseLockDoor(commercialPlane.cockpit);
                  Put_Line("External doors are now: "&commercialPlane.extDoor.door'Image);
               when '2' => CloseLockDoor(commercialPlane.extDoor);
                  Put_Line("Cockpit is now: "&commercialPlane.extDoor.door'Image);
               when '3' => TurnOn(commercialPlane.ignition);
                  Put_Line("Engine is now: "&commercialPlane.ignition.status'Image);
               when '4' => OpenDoor(commercialPlane.extDoor);
                  Put_Line("External doors opened");
               when '5' => CloseDoor(commercialPlane.extDoor);
               Put_Line("External doors closed");
               when others => abort takingOff; abort getFlightCommand; abort landingPlane; exit;
            end case;
            if (commercialPlane.extDoor.door = ClosedAndLocked and commercialPlane.cockpit.door = ClosedAndLocked and commercialPlane.ignition.status = On) then
               Put_Line("Prepared for take off.");
               TakeOff;
            end if;

         end if;
      end loop;
      delay 0.5;
   end setUp;

   task body takingOff is
   begin
      loop
         if (commercialPlane.mode = TakeOff) then
            increaseAirspeed;
            increaseAirspeed;
            increaseAltitude;
            Put_Line("Alitude: " & commercialPlane.dashboard_system.height'Image);
            Put_Line("Speed: " & commercialPlane.dashboard_system.velocity'Image);

            if (commercialPlane.dashboard_system.height >= 500 and commercialPlane.dashboard_system.velocity >= 250) then
               Put_Line("Flying");
               Flying;
            end if;
         end if;
       delay 0.5;
      end loop;
   end takingOff;

   task body getFlightCommand is
   begin
      loop
         if (commercialPlane.mode = Flying and commercialPlane.dashboard_system.fuel_tank > 0) then
         Put_Line("Press i to close increase speed. Press d to decrease speed. Press u to increase altitude. Press q to decrease altitude. Press l to land.");
         Get_Line(Str, Last);
            case Str(1) is
               when 'i' => increaseAirspeed;
               when 'd' => decreaseAirspeed;
               when 'u' => increaseAltitude;
               when 'q' => decreaseAltitude;
               when 'l' => commercialPlane.mode := Landing;
               when others => abort takingOff; abort setUp; abort landingPlane; exit;
         end case;
         speedWarning(commercialPlane.warning_lights, commercialPlane.dashboard_system);
         altitudeWarning(commercialPlane.warning_lights, commercialPlane.dashboard_system);
      end if;
      end loop;
end getFlightCommand;

task body fuelWarningSystem is
begin
   loop
         if (commercialPlane.mode = Flying and commercialPlane.dashboard_system.fuel_tank /= 0) then
            if commercialPlane.num_passengers < 10 then
               fuelUsage;
            else
               adjustFuelUsage;
            end if;
         Put_Line("Remaining fuel: "&commercialPlane.dashboard_system.fuel_tank'Image);
         fuelWarning(commercialPlane.warning_lights, commercialPlane.dashboard_system);
         delay 1.0;
      end if;
      if (commercialPlane.mode = Flying and commercialPlane.dashboard_system.fuel_tank < 25) then
            if commercialPlane.num_passengers < 10 then
               fuelUsage;
            else
               adjustFuelUsage;
            end if;
            Put_Line("Fuel level critical. Level is: "&commercialPlane.dashboard_system.fuel_tank'Image);
         fuelWarning(commercialPlane.warning_lights, commercialPlane.dashboard_system);
         delay 1.0;
      end if;
         if (commercialPlane.mode = Flying and commercialPlane.dashboard_system.fuel_tank = 0) then
         Put_Line("Fuel tank empty.");
         decreaseAltitude;
         decreaseAirspeed;
         delay 0.5;
         if (commercialPlane.mode = Flying and commercialPlane.dashboard_system.fuel_tank = 0 and commercialPlane.dashboard_system.height = 0) then
            Put_Line("Crashed.");
            abort takingOff; abort setUp; abort landingPlane; abort getFlightCommand; abort fuelWarningSystem; exit;
         end if;
      end if;
   end loop;
end fuelWarningSystem;

task body landingPlane is
begin
   loop
      if (commercialPlane.mode = Landing) then
         decreaseAirspeed;
         decreaseAltitude;
         Landing;
            if (commercialPlane.landGear = Lowered and commercialPlane.dashboard_system.height = 0 and commercialPlane.dashboard_system.velocity = 0) then

            InTow;
         end if;
      end if;
      delay 0.5;
   end loop;
end landingPlane;


begin
   null;
end Main;
