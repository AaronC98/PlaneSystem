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

--  The communication protocol uses a light encoding scheme based on the HTTP
--  GET method. For standard, XML based, communication you can use the SOAP
--  protocol. This API can be convenient if you do not plan to build AWS with
--  SOAP support.

with Ada.Strings.Unbounded;

package AWS.Communication is

   use Ada.Strings.Unbounded;

   type Parameter_Set is array (Positive range <>) of Unbounded_String;

   Null_Parameter_Set : constant Parameter_Set;

   function Parameters
     (P1, P2, P3, P4, P5 : String := "") return Parameter_Set;
   --  Constructor function to help create a Parameter_Set. This function will
   --  return a Parameter_Set array containing any parameter with a non emptry
   --  string value.

private

   AWS_Com : constant String := "/AWS_Com";
   --  This is the URI for communication messages

   Null_Parameter_Set : constant Parameter_Set (2 .. 1) :=
                          Parameter_Set'(2 .. 1 => Null_Unbounded_String);

end AWS.Communication;
