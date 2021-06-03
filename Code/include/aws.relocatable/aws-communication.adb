------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2000-2012, AdaCore                     --
--                                                                          --
--  This library is free software;  you can redistribute it and/or modify   --
--  it under terms of the  GNU General Public License  as published by the  --
--  Free Software  Foundation;  either version 3,  or (at your  option) any --
--  later version. This library is distributed in the hope that it will be  --
--  useful, but WITHOUT ANY WARRANTY;  without even the implied warranty of --
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                    --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--  You should have received a copy of the GNU General Public License and   --
--  a copy of the GCC Runtime Library Exception along with this program;    --
--  see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see   --
--  <http://www.gnu.org/licenses/>.                                         --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
------------------------------------------------------------------------------

package body AWS.Communication is

   ---------------
   -- Parameter --
   ---------------

   function Parameters
     (P1, P2, P3, P4, P5 : String := "") return Parameter_Set
   is
      procedure Add (P : String);
      --  Add parameter P into PS

      PS : Parameter_Set (1 .. 5);
      I  : Natural := 0;

      ---------
      -- Add --
      ---------

      procedure Add (P : String) is
      begin
         I := I + 1;
         PS (I) := To_Unbounded_String (P);
      end Add;

   begin
      if P1 /= "" then
         Add (P1);
      end if;

      if P2 /= "" then
         Add (P2);
      end if;

      if P3 /= "" then
         Add (P3);
      end if;

      if P4 /= "" then
         Add (P4);
      end if;

      if P5 /= "" then
         Add (P5);
      end if;

      return PS (1 .. I);
   end Parameters;

end AWS.Communication;
