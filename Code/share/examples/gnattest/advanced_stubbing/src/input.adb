--
--  Copyright (C) 2014, AdaCore
--

with Console;

package body Input is
   function Read_Number return Integer is
      S : String := Console.Read_String;
   begin
      return Integer'Value (S);
   end Read_Number;
end Input;
