--  This package is intended to set up and tear down  the test environment.
--  Once created by GNATtest, this package will never be overwritten
--  automatically. Contents of this package can be modified in any way
--  except for sections surrounded by a 'read only' marker.

package body Instantiations.Test_Data.Tests.Sort_Integers.Test_Data is

   procedure Set_Up (Gnattest_T : in out Test) is
      pragma Unreferenced (Gnattest_T);
   begin
      null;
   end Set_Up;

   procedure Tear_Down (Gnattest_T : in out Test) is
      pragma Unreferenced (Gnattest_T);
   begin
      null;
   end Tear_Down;

   procedure User_Set_Up (Gnattest_T : in out New_Test) is
   begin
      Gnattest_T.Arr := (3, 5, 2, 1, 4);
   end User_Set_Up;

   procedure User_Tear_Down (Gnattest_T : in out New_Test) is
      pragma Unreferenced (Gnattest_T);
   begin
      null;
   end User_Tear_Down;

end Instantiations.Test_Data.Tests.Sort_Integers.Test_Data;
