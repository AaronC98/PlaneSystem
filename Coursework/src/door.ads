package door with SPARK_Mode is

   type door_state is (Open, Closed, ClosedAndLocked);

   type DoorSystem is record
      door: door_state;
   end record;

   procedure OpenDoor(current_door: in out DoorSystem) with
     Pre => current_door.door = Closed,
     Post => current_door.door = Open;

   procedure CloseDoor(current_door: in out DoorSystem) with
     Pre => current_door.door = Open,
     Post => current_door.door = Closed;

   procedure CloseLockDoor(current_door: in out DoorSystem) with
     Pre => current_door.door = Closed,
     Post => current_door.door = ClosedAndLocked;

end door;
