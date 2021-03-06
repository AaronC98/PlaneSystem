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

with AWS.Messages;
with AWS.MIME;

with SOAP.Message.XML;

package body SOAP.Message.Response is

   -----------
   -- Build --
   -----------

   function Build
     (R      : Object'Class;
      Schema : WSDL.Schema.Definition := WSDL.Schema.Empty)
      return AWS.Response.Data
   is
      use AWS.Messages;
   begin
      return AWS.Response.Build
        (AWS.MIME.Text_XML,
         UString_Message => SOAP.Message.XML.Image (R, Schema),
         Status_Code     => (if Is_Error (R) then S500 else S200));
   end Build;

   ----------
   -- From --
   ----------

   function From (P : Message.Payload.Object) return Object is
      NP : Object;
   begin
      Set_Wrapper_Name (NP, Payload.Procedure_Name (P) & "Response");

      Set_Parameters   (NP, Parameters (P));

      Set_Name_Space (NP, Name_Space (P));

      return NP;
   end From;

   --------------
   -- Is_Error --
   --------------

   function Is_Error (R : Object) return Boolean is
      pragma Warnings (Off, R);
   begin
      return False;
   end Is_Error;

end SOAP.Message.Response;
