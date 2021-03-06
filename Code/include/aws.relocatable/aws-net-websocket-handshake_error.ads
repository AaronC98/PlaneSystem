------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2014-2019, AdaCore                     --
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

--  Support for denying an handshake

with AWS.Messages;

package AWS.Net.Websocket.Handshake_Error is

   type Object is new WebSocket.Object with private;

   function Create
     (Status_Code   : Messages.Client_Error := Messages.S403;
      Reason_Phrase : String := "") return Object;
   --  Create a WebSocket error response, Status_Code is the HTTP code that
   --  will be returned during the handshake.

   function Status_Code
     (Socket : Object'Class) return Messages.Client_Error with Inline;
   --  Returns the status code for the handshake

   function Reason_Phrase (Socket : Object'Class) return String with Inline;
   --  Returns the associated reason-phrase

private

   type Object is new WebSocket.Object with record
      Status_Code   : AWS.Messages.Client_Error;
      Reason_Phrase : Unbounded_String;
   end record;

end AWS.Net.WebSocket.Handshake_Error;
