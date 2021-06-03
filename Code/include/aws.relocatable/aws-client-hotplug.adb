------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2004-2012, AdaCore                     --
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

with GNAT.MD5;

with AWS.Communication.Client;
with AWS.Digest;
with AWS.Messages;
with AWS.Server.Hotplug;
with AWS.URL;

package body AWS.Client.Hotplug is

   --------------
   -- Register --
   --------------

   function Register
     (Name     : String;
      Password : String;
      Server   : String;
      Regexp   : String;
      URL      : String) return Response.Data
   is
      use type Messages.Status_Code;
      Srv      : AWS.URL.Object;
      Response : AWS.Response.Data;
      Digest   : AWS.Digest.Digest_String;
   begin
      Srv := AWS.URL.Parse (Server);

      --  Ask the server for a Nonce string

      Response := Communication.Client.Send_Message
        (AWS.URL.Host (Srv), AWS.URL.Port (Srv),
         AWS.Server.Hotplug.Request_Nonce_Message,
         Communication.Parameters (Name));

      if AWS.Response.Status_Code (Response) /= Messages.S200 then
         return Response;
      end if;

      --  Send registration with a digest encoded using the server Nonce

      declare
         Nonce : constant String := AWS.Response.Message_Body (Response);
      begin
         Digest := AWS.Digest.Create
           (Name, "hotplug",
            GNAT.MD5.Digest (Name & ":aws:" & Password),
            Nonce, "hotplug", Regexp);

         return AWS.Communication.Client.Send_Message
           (AWS.URL.Host (Srv), AWS.URL.Port (Srv),
            AWS.Server.Hotplug.Register_Message,
            Communication.Parameters (Name, Digest, Regexp, URL));
      end;
   exception
      when AWS.URL.URL_Error =>
         return AWS.Response.Acknowledge (Messages.S400, "Server URL error");
   end Register;

   ----------------
   -- Unregister --
   ----------------

   function Unregister
     (Name     : String;
      Password : String;
      Server   : String;
      Regexp   : String) return Response.Data
   is
      use type Messages.Status_Code;
      Srv      : AWS.URL.Object;
      Response : AWS.Response.Data;
      Digest   : AWS.Digest.Digest_String;
   begin
      Srv := AWS.URL.Parse (Server);

      --  Ask the server for a Nonce string

      Response := AWS.Communication.Client.Send_Message
        (AWS.URL.Host (Srv), AWS.URL.Port (Srv),
         AWS.Server.Hotplug.Request_Nonce_Message,
         Communication.Parameters (Name));

      if AWS.Response.Status_Code (Response) /= Messages.S200 then
         return Response;
      end if;

      --  Send unregister message with a digest encoded using the server Nonce

      declare
         Nonce : constant String := AWS.Response.Message_Body (Response);
      begin
         Digest := AWS.Digest.Create
           (Name, "hotplug",
            GNAT.MD5.Digest (Name & ":aws:" & Password),
            Nonce, "hotplug", Regexp);

         return AWS.Communication.Client.Send_Message
           (AWS.URL.Host (Srv), AWS.URL.Port (Srv),
            AWS.Server.Hotplug.Unregister_Message,
            Communication.Parameters (Name, Digest, Regexp));
      end;
   exception
      when AWS.URL.URL_Error =>
         return AWS.Response.Acknowledge (Messages.S400, "Server URL error");
   end Unregister;

end AWS.Client.Hotplug;
