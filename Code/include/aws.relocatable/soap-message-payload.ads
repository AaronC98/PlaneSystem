------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2000-2015, AdaCore                     --
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

with SOAP.Name_Space;
with SOAP.Parameters;

package SOAP.Message.Payload is

   type Object is new Message.Object with private;

   function Procedure_Name (P : Object'Class) return String;
   --  Retruns the Payload procedure name

   procedure Set_Procedure_Name (P : in out Object'Class; Name : String);
   --  Set the payload procedure name

   function Build
     (Procedure_Name : String;
      P_Set          : SOAP.Parameters.List;
      Name_Space     : SOAP.Name_Space.Object := SOAP.Name_Space.AWS)
      return Object;
   --  Retruns a Payload object initialized with the procedure name,
   --  parameters and name space.

private

   type Object is new Message.Object with null record;

end SOAP.Message.Payload;
