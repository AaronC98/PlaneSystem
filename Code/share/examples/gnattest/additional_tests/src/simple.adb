--
--  Copyright (C) 2011-2017, AdaCore
--

package body Simple is

   function Inc (X : Integer) return Integer
   is
   begin
      return X + 1;
   end Inc;

   function Legacy_Odd_Check (X : Integer) return String
   is
   begin
      if X mod 2 = 1 then
         return "odd";
      else
         return "even";
      end if;
   end Legacy_Odd_Check;

end Simple;
