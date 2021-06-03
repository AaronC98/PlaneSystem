--
--  Copyright (C) 2017, AdaCore
--

with AUnit;
with AUnit.Test_Fixtures;

package Legacy_Tests is

   type Test is new AUnit.Test_Fixtures.Test_Fixture with null record;

   procedure Test_Odd (T : in out Test);
   procedure Test_Even (T : in out Test);

end Legacy_Tests;
