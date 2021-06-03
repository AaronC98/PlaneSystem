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

--  Dispatcher for SOAP requests

with AWS.Dispatchers;
with AWS.Response;
with AWS.Status;
with SOAP.Message.Payload;
with SOAP.WSDL.Schema;

package SOAP.Dispatchers is

   type Handler is abstract new AWS.Dispatchers.Handler with private;
   --  This dispatcher will send SOAP and HTTP requests to different routines

   function Schema
     (Dispatcher : Handler;
      SOAPAction : String)
      return WSDL.Schema.Definition;
   --  Returns the schema for the given SOAPAction

   type SOAP_Callback is
     access function (SOAPAction : String;
                      Payload    : Message.Payload.Object;
                      Request    : AWS.Status.Data)
                      return AWS.Response.Data;
   --  This is the SOAP Server callback type. SOAPAction is the HTTP header
   --  SOAPAction value, Payload is the parsed XML payload, request is the
   --  HTTP request status.

   function Dispatch_SOAP
     (Dispatcher : Handler;
      SOAPAction : String;
      Payload    : Message.Payload.Object;
      Request    : AWS.Status.Data)
      return AWS.Response.Data is abstract;
   --  This dispatch function is called for SOAP requests

   function Dispatch_HTTP
     (Dispatcher : Handler;
      Request    : AWS.Status.Data)
      return AWS.Response.Data is abstract;
   --  This dispatch function is called for standard HTTP requests

private

   overriding function Dispatch
     (Dispatcher : Handler;
      Request    : AWS.Status.Data) return AWS.Response.Data;

   type Handler is abstract new AWS.Dispatchers.Handler with record
      Schema : WSDL.Schema.Definition;
   end record;

end SOAP.Dispatchers;
