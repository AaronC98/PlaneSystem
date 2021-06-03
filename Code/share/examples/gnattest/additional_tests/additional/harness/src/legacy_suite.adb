--
--  Copyright (C) 2017, AdaCore
--
with Legacy_Tests;         use Legacy_Tests;
with AUnit.Test_Caller;

package body Legacy_Suite is

   package Caller is new AUnit.Test_Caller (Legacy_Tests.Test);

   function Suite return Access_Test_Suite is
      Ret : constant Access_Test_Suite := new Test_Suite;
   begin
      Ret.Add_Test
        (Caller.Create ("Test odd", Test_Odd'Access));
      Ret.Add_Test
        (Caller.Create ("Test even", Test_Even'Access));
      return Ret;
   end Suite;

end Legacy_Suite;
