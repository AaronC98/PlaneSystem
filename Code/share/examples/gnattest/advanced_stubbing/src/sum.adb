--
--  Copyright (C) 2014, AdaCore
--

with Input;

package body Sum is

   function Sum return Integer is
      A, B : Integer := Input.Read_Number;
   begin
      return A + B;
   end Sum;

   function Sum_of_Sums return Integer is
   begin
      return Sum + Sum;
   end Sum_of_Sums;

end Sum;
