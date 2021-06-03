--
--  Copyright (C) 2017, AdaCore
--
with AUnit.Reporter.Text;
with AUnit.Run;
with Legacy_Suite; use Legacy_Suite;

procedure Test_Driver is
   procedure Runner is new AUnit.Run.Test_Runner (Suite);
   Reporter : AUnit.Reporter.Text.Text_Reporter;
begin
   Runner (Reporter);
end Test_Driver;
