--  This package has been generated automatically by GNATtest.
--  You are allowed to add your code to the bodies of test routines.
--  Such changes will be kept during further regeneration of this file.
--  All code placed outside of test routine bodies will be lost. The
--  code intended to set up and tear down the test environment should be
--  placed into Speed2.Auto_Controller_Test_Data.

with AUnit.Assertions; use AUnit.Assertions;

package body Speed2.Auto_Controller_Test_Data.Auto_Controller_Tests is


--  begin read only
--  id:2/3a98136ae8d1ca89/Desired_Speed/0/0/
   procedure Test_Desired_Speed_3a9813 (Gnattest_T : in out Test_Auto_Controller) is
   --  speed2.ads:10:4:Desired_Speed
--  end read only

   begin
      Auto_Controller (Gnattest_T.Fixture.all).Desired_Speed := 5;
      Assert (Auto_Controller (Gnattest_T.Fixture.all).Desired_Speed = 5,
              "wrong speed displayed");

--  begin read only
   end Test_Desired_Speed_3a9813;
--  end read only


--  begin read only
--  id:2/42cd33c8ea29e2bf/Set_Desired_Speed/0/0/
   procedure Test_Set_Desired_Speed_42cd33 (Gnattest_T : in out Test_Auto_Controller) is
   --  speed2.ads:12:4:Set_Desired_Speed
--  end read only

   begin
      Auto_Controller (Gnattest_T.Fixture.all).Set_Desired_Speed (10);
      Assert (Auto_Controller (Gnattest_T.Fixture.all).Desired_Speed = 10,
              "wrong speed set");

--  begin read only
   end Test_Set_Desired_Speed_42cd33;
--  end read only


--  begin read only
--  id:2/6fd48ff933c1edff/Adjust_Speed/0/0/
   procedure Test_Adjust_Speed_6fd48f (Gnattest_T : in out Test_Auto_Controller) is
   --  speed2.ads:16:4:Adjust_Speed
--  end read only

   begin
      Gnattest_T.Fixture.Adjust_Speed (4);
      Assert (Gnattest_T.Fixture.Speed = 0, "Speed modified");

--  begin read only
   end Test_Adjust_Speed_6fd48f;
--  end read only

end Speed2.Auto_Controller_Test_Data.Auto_Controller_Tests;
