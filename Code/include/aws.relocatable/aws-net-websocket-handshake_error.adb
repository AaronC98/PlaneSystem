------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                       Copyright (C) 2014, AdaCore                        --
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

package body AWS.Net.Websocket.Handshake_Error is

   ------------
   -- Create --
   ------------

   function Create
     (Status_Code   : Messages.Client_Error := Messages.S403;
      Reason_Phrase : String := "") return Object is
   begin
      return Object'
        (WebSocket.Object
         with Status_Code, To_Unbounded_String (Reason_Phrase));
   end Create;

   -------------------
   -- Reason_Phrase --
   -------------------

   function Reason_Phrase (Socket : Object'Class) return String is
   begin
      return To_String (Socket.Reason_Phrase);
   end Reason_Phrase;

   -----------------
   -- Status_Code --
   -----------------

   function Status_Code (Socket : Object'Class) return Messages.Client_Error is
   begin
      return Socket.Status_Code;
   end Status_Code;

end AWS.Net.WebSocket.Handshake_Error;
