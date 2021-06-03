package body door with SPARK_Mode is

   procedure OpenDoor(current_door: in out DoorSystem) is
   begin
     if current_door.door = Closed then
         current_door.door := Open;
      end if;
   end OpenDoor;

procedure CloseDoor(current_door: in out DoorSystem) is
begin
     if current_door.door = Open then
         current_door.door := Closed;
      end if;
end CloseDoor;

procedure CloseLockDoor(current_door: in out DoorSystem) is
begin
     if current_door.door = Closed then
        current_door.door := ClosedAndLocked;
   end if;

end CloseLockDoor;

end door;
