with CommercialPlaneSystem; use CommercialPlaneSystem;
with engine; use engine;
with door; use door;
with Dashboard;  use Dashboard;
package planestatus with SPARK_Mode is

   type currentActivity is (TakeOff, Landing, Flying, Idle);

   type current_mode is record
      mode: currentActivity;
   end record;


   procedure TakeOff with
        Global =>(In_Out => commercialPlane),
        Pre => commercialPlane.mode = Idle and commercialPlane.ignition.status = On and
        commercialPlane.cockpit.door = ClosedAndLocked and commercialPlane.extDoor.door = ClosedAndLocked and commercialPlane.dashboard_system.fuel_tank >= 50,
        Post => commercialPlane.mode = TakeOff;

   procedure Flying with
        Global =>(In_Out => commercialPlane),
        Pre => commercialPlane.mode = TakeOff and commercialPlane.dashboard_system.velocity >= 250 and commercialPlane.dashboard_system.height >= 500,
        Post => commercialPlane.mode = Flying;

    procedure Landing with
        Global =>(In_Out => commercialPlane),
        Pre => commercialPlane.mode = Landing and commercialPlane.dashboard_system.velocity <= 100 and commercialPlane.dashboard_system.height <= 100,
        Post => commercialPlane.landGear = Lowered and commercialPlane.dashboard_system.height = 0 and commercialPlane.dashboard_system.velocity = 0;


end planestatus;
