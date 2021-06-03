------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2003-2015, AdaCore                     --
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

with Ada.Strings.Unbounded;

with SOAP.Message.XML;

package body SOAP.Dispatchers is

   use Ada.Strings.Unbounded;

   --------------
   -- Dispatch --
   --------------

   overriding function Dispatch
     (Dispatcher : Handler;
      Request    : AWS.Status.Data) return AWS.Response.Data is
   begin
      if AWS.Status.Is_SOAP (Request) then
         declare
            SOAPAction : constant String := AWS.Status.SOAPAction (Request);
         begin
            return Dispatch_SOAP
              (Handler'Class (Dispatcher),
               SOAPAction,
               SOAP.Message.XML.Load_Payload
                 (Unbounded_String'(AWS.Status.Payload (Request)),
                  Schema => Schema (Handler'Class (Dispatcher), SOAPAction)),
               Request);
         end;

      else
         return Dispatch_HTTP (Handler'Class (Dispatcher), Request);
      end if;
   end Dispatch;

   ------------
   -- Schema --
   ------------

   function Schema
     (Dispatcher : Handler;
      SOAPAction : String)
      return WSDL.Schema.Definition
   is
      pragma Unreferenced (SOAPAction);
   begin
      return Dispatcher.Schema;
   end Schema;

end SOAP.Dispatchers;
