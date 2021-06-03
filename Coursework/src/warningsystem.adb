package body WarningSystem is

  procedure fuelWarning(light: in out Warning_System; dashboard: in out DashboardSystem) is
   begin
      if (dashboard.fuel_tank <= 25) then
         light.fuelWarning := Red;
          Put_Line("Warning - Low fuel.");
      end if;
   end fuelWarning;

   procedure speedWarning(light: in out Warning_System; dashboard: in out DashboardSystem) is
   begin
      if (dashboard.velocity <= 250) then
         light.speedWarning := Red;
          Put_Line("Warning - going too slow.");
      end if;
      if (dashboard.velocity >= 1000) then
         light.speedWarning := Red;
          Put_Line("Warning - going too fast.");
      end if;
   end speedWarning;

   procedure altitudeWarning(light: in out Warning_System; dashboard: in out DashboardSystem)is
   begin
      if (dashboard.height < 500) then
         light.heightWarning := Red;
            Put_Line("Warning - flying too low.");
      end if;
      if (dashboard.height > 1200) then
         light.heightWarning := Red;
          Put_Line("Warning - flying to high.");
      end if;
   end altitudeWarning;

end WarningSystem;
