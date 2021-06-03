--  This package has been generated automatically by GNATtest.
--  You are allowed to add your code to the bodies of test routines.
--  Such changes will be kept during further regeneration of this file.
--  All code placed outside of test routine bodies will be lost. The
--  code intended to set up and tear down the test environment should be
--  placed into Sorting_Algorithms.Test_Data.

with AUnit.Assertions; use AUnit.Assertions;

package body Sorting_Algorithms.Test_Data.Tests is


--  begin read only
   procedure Test_Selection_Sort (Gnattest_T : in out Test);
   procedure Test_Selection_Sort_2c4218 (Gnattest_T : in out Test) renames Test_Selection_Sort;
--  id:2.1/2c42186cf64f92e5/Selection_Sort/1/0/
   procedure Test_Selection_Sort (Gnattest_T : in out Test) is
   --  sorting_algorithms.ads:9:4:Selection_Sort
--  end read only

   begin

      Selection_Sort (Gnattest_T.Arr);
      for I in Gnattest_T.Arr'First .. Gnattest_T.Arr'Last - 1 loop
         AUnit.Assertions.Assert
           (not (Gnattest_T.Arr (I + 1) < Gnattest_T.Arr (I)),
            "array not sorted");
      end loop;

--  begin read only
   end Test_Selection_Sort;
--  end read only


--  begin read only
   procedure Test_Bubble_Sort (Gnattest_T : in out Test);
   procedure Test_Bubble_Sort_dec8d5 (Gnattest_T : in out Test) renames Test_Bubble_Sort;
--  id:2.1/dec8d51e221b14d9/Bubble_Sort/1/0/
   procedure Test_Bubble_Sort (Gnattest_T : in out Test) is
   --  sorting_algorithms.ads:11:4:Bubble_Sort
--  end read only

   begin

      Bubble_Sort (Gnattest_T.Arr);
      for I in Gnattest_T.Arr'First .. Gnattest_T.Arr'Last - 1 loop
         AUnit.Assertions.Assert
           (not (Gnattest_T.Arr (I + 1) < Gnattest_T.Arr (I)),
            "array not sorted");
      end loop;


--  begin read only
   end Test_Bubble_Sort;
--  end read only

end Sorting_Algorithms.Test_Data.Tests;
