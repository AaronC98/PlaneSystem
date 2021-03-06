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

with SPARK.Text_IO; use SPARK.Text_IO;
pragma Elaborate (SPARK.Text_IO);

procedure Echo
  with Global => (In_Out => (Standard_Input, Standard_Output, Standard_Error)),
       Pre    => Is_Writable (Standard_Error)
is
   C : Character_Result;
begin
   while not End_Of_File loop
      pragma Loop_Invariant (Is_Writable (Standard_Error));
      Get (C);
      if C.Status = Success then
         if Status (Standard_Output) = Success then
            Put (C.Item);
         else
            if Status (Standard_Error) = Success then
               Put_Line (Standard_Error, "Error on Standard_Output");
            end if;

            exit;
         end if;
      else
         if Status (Standard_Error) = Success then
            Put_Line (Standard_Error, "Error on Standard_Input");
         end if;
         exit;
      end if;
   end loop;
end Echo;
