------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2000-2013, AdaCore                     --
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

pragma Ada_2012;

function AWS.Hotplug.Get_Status
  (Filters : Filter_Set) return Templates_Parser.Translate_Set
is

   use Templates_Parser;

   --  Avoid : may be referenced before it has a value
   Regexp : Vector_Tag with Warnings => Off;
   URL    : Vector_Tag with Warnings => Off;

   Result : Translate_Set;

begin
   for K in 1 .. Filter_Table.Length (Filters.Set) loop
      declare
         Item : constant Filter_Data
           := Filter_Table.Element (Filters.Set, Positive (K));
      begin
         Regexp := Regexp & Item.Regexp_Str;
         URL    := URL    & Item.URL;
      end;
   end loop;

   Insert (Result, Assoc ("HP_REGEXP_V", Regexp));
   Insert (Result, Assoc ("HP_URL_V",    URL));

   return Result;
end AWS.Hotplug.Get_Status;
