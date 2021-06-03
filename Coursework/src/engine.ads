package engine with SPARK_Mode is

   type engine_status is (On, Off);
   
   type engine_state is record 
      status: engine_status;
   end record;
   
   procedure TurnOn(state: in out engine_state) with
     Pre=> state.status = Off,
     Post => state.status = On;
       
   procedure TurnOff(state: in out engine_state) with 
     Pre=> state.status = On,
     Post => state.status = Off;

end engine;
