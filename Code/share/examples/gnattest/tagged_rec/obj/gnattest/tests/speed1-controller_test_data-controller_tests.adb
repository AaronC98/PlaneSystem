--  This package has been generated automatically by GNATtest.
--  You are allowed to add your code to the bodies of test routines.
--  Such changes will be kept during further regeneration of this file.
--  All code placed outside of test routine bodies will be lost. The
--  code intended to set up and tear down the test environment should be
--  placed into Speed1.Controller_Test_Data.

with AUnit.Assertions; use AUnit.Assertions;

package body Speed1.Controller_Test_Data.Controller_Tests is


--  begin read only
--  id:2/bdc8045e732efa1b/Speed/0/0/
   procedure Test_Speed_bdc804 (Gnattest_T : in out Test_Controller) is
   --  speed1.ads:12:4:Speed
--  end read only

   begin

      Gnattest_T.Fixture.all.Actual_Speed := 5;
      Assert (Gnattest_T.Fixture.Speed = 5,
              "wrong speed displayed");

--  begin read only
   end Test_Speed_bdc804;
--  end read only


--  begin read only
--  id:2/6fd48ff933c1edff/Adjust_Speed/0/0/
   procedure Test_Adjust_Speed_6fd48f (Gnattest_T : in out Test_Controller) is
   --  speed1.ads:13:4:Adjust_Speed
--  end read only

   begin
      Gnattest_T.Fixture.Actual_Speed := 0;
      Gnattest_T.Fixture.Adjust_Speed (4);
      Assert (Gnattest_T.Fixture.Speed = 4,
              "wrong speed after first assignment:" &
                Integer'Image (Gnattest_T.Fixture.Speed));
      Gnattest_T.Fixture.Adjust_Speed (-2);
      Assert (Gnattest_T.Fixture.Speed = 2,
              "wrong speed after second assignment" &
                Integer'Image (Gnattest_T.Fixture.Speed));

--  begin read only
   end Test_Adjust_Speed_6fd48f;
--  end read only

end Speed1.Controller_Test_Data.Controller_Tests;
