package body engine with SPARK_Mode is

   procedure TurnOn(state: in out engine_state) is
   begin
      if state.status = Off then
         state.status := On;
      end if;
        
   end TurnOn;
   
   procedure TurnOff(state: in out engine_state) is
   begin
      if state.status = On then
         state.status := Off;
      end if;
      
   end TurnOff;
   
end engine;
