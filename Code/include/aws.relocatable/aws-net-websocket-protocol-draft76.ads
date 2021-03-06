------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2012-2014, AdaCore                     --
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

--  This implements the WebSocket protocol as defined in Draft-76
--  http://tools.ietf.org/html/draft-hixie-thewebsocketprotocol-76

package AWS.Net.WebSocket.Protocol.Draft76 is

   type State is new Protocol.State with null record;

   overriding procedure Send
     (Protocol    : in out State;
      Socket      : Object;
      Data        : Stream_Element_Array;
      From_Client : Boolean := False);
   --  Encode and send data to the WebSocket

   overriding procedure Send
     (Protocol    : in out State;
      Socket      : Object;
      Data        : Unbounded_String;
      From_Client : Boolean := False);
   --  Same as above but for an Unbounded_String. This version supports large
   --  messages possibly sent fragmented.

   overriding procedure Close
     (Protocol : in out State;
      Socket   : Object;
      Data     : String;
      Error    : Status_Code) is null;
   --  Send a close frame, this is not implemented on this protocol

   overriding procedure Receive
     (Protocol : in out State;
      Socket   : Object;
      Data     : out Stream_Element_Array;
      Last     : out Stream_Element_Offset);
   --  Receive and decode WebSocket data

   overriding function End_Of_Message (Protocol : State) return Boolean;
   --  Returns True if we have read a whole message

   procedure Send_Header
     (Sock : Net.Socket_Type'Class; Request : AWS.Status.Data);
   --  Send specific header for this protocol

   overriding procedure Add_Connect_Headers
     (Protocol : State;
      URI      : String;
      Headers  : in out AWS.Headers.List);
   --  See inherited documentation

end AWS.Net.WebSocket.Protocol.Draft76;
