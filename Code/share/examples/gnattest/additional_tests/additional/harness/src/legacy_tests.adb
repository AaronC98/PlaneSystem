--
--  Copyright (C) 2017, AdaCore
--
with Simple;           use Simple;
with AUnit.Assertions; use AUnit.Assertions;

package body Legacy_Tests is

   --------------
   -- Test_Odd --
   --------------

   procedure Test_Odd (T : in out Test) is
      pragma Unreferenced (T);
   begin
      Assert (Legacy_Odd_Check (1) = "odd", "1 not considered odd");
   end Test_Odd;

   ---------------
   -- Test_Even --
   ---------------

   procedure Test_Even (T : in out Test) is
      pragma Unreferenced (T);
   begin
      Assert (Legacy_Odd_Check (2) = "even", "2 not considered even");
   end Test_Even;

end Legacy_Tests;
