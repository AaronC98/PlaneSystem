------------------------------------------------------------------------------
--                                                                          --
--                           SPARK_IO EXAMPLES                              --
--                                                                          --
--                     Copyright (C) 2013, Altran UK                        --
--                                                                          --
-- SPARK is free software;  you can redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
------------------------------------------------------------------------------

pragma SPARK_Mode (On);

with Float_IO;      use Float_IO;
with SPARK.Text_IO; use SPARK.Text_IO; pragma Elaborate (SPARK.Text_IO);

procedure Use_Float_IO
  with Global => (In_Out => (Standard_Output, Standard_Error)),
       Pre    => Is_Writable (Standard_Error) and
                 Status (Standard_Error) = Success
is
   F : Float;
begin
   for I in 1 .. 10 loop
      F := Float (I) * 1.5;
      pragma Loop_Invariant (Is_Writable (Standard_Error) and
                             Status (Standard_Error) = Success);
      if Status (Standard_Output) /= Success then
         Put_Line (Standard_Error, "Error on Standard_Output");
         exit;
      end if;

      Put ("The number is: ");

      if Status (Standard_Output) /= Success then
         Put_Line (Standard_Error, "Error on Standard_Output");
         exit;
      end if;

      Put (Item => F, Fore => 4, Aft => 2, Exp => 0);

      if Status (Standard_Output) /= Success then
         Put_Line (Standard_Error, "Error on Standard_Output");
         exit;
      end if;

      New_Line;
   end loop;
end Use_Float_IO;
