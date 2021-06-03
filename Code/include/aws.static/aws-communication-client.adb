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

with Ada.Strings.Fixed;

with AWS.Client;
with AWS.Net;
with AWS.Utils;

package body AWS.Communication.Client is

   ------------------
   -- Send_Message --
   ------------------

   function Send_Message
     (Server     : String;
      Port       : Positive;
      Name       : String;
      Parameters : Parameter_Set := Null_Parameter_Set) return Response.Data
   is
      URL : Unbounded_String := To_Unbounded_String ("http://");
   begin
      if Ada.Strings.Fixed.Index (Server, ":") > 0 then
         URL := URL & '[' & Server & ']';
      else
         URL := URL & Server;
      end if;

      URL := URL & ':' & Utils.Image (Port) & AWS_Com
        & "?HOST=" & Net.Host_Name
        & "&NAME=" & Name;

      for K in Parameters'Range loop
         URL := URL & "&P" & Utils.Image (K) & '=' & Parameters (K);
      end loop;

      return AWS.Client.Get (To_String (URL));
   end Send_Message;

end AWS.Communication.Client;
