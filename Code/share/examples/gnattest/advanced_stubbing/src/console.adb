--
--  Copyright (C) 2014, AdaCore
--

with Text_IO;

package body Console is
   function Read_String return String renames Text_IO.Get_Line;
end Console;
