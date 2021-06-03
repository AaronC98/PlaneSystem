with Ada.Text_IO; use Ada.Text_IO;

package body planestatus with SPARK_Mode is

    procedure TakeOff is
      begin
      if commercialPlane.mode = Idle and commercialPlane.ignition.status = On and
        commercialPlane.cockpit.door = ClosedAndLocked and commercialPlane.extDoor.door = ClosedAndLocked and commercialPlane.dashboard_system.fuel_tank >= 50 then
         commercialPlane.mode := TakeOff;
      end if;
   end TakeOff;

   procedure Flying is
   begin
      if commercialPlane.mode = TakeOff and commercialPlane.dashboard_system.velocity >= 250 and commercialPlane.dashboard_system.height >= 500 then
         commercialPlane.mode := Flying;
      end if;
   end Flying;

   procedure Landing is
   begin
      if commercialPlane.mode = Landing and commercialPlane.dashboard_system.velocity <= 100 and commercialPlane.dashboard_system.height <= 100 then
         commercialPlane.landGear := Lowered;
         commercialPlane.dashboard_system.height := 0;
         commercialPlane.dashboard_system.velocity := 0;
      end if;
   end Landing;

   end planestatus;
