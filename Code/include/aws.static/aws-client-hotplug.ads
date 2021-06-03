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

with AWS.Response;

package AWS.Client.Hotplug is

   --  Below are two routines to register/unregister hotplug modules into
   --  server. Note that such server must be configured to accept hotplug
   --  modules. Password parameter is the clear text paswword, it will be sent
   --  encoded. An authorization entry for module Name with Password (and the
   --  given URL host for registration) must be found in the server's
   --  authorization file. See AWS.Server.Hotplug.Activate.

   function Register
     (Name     : String;
      Password : String;
      Server   : String;
      Regexp   : String;
      URL      : String) return Response.Data;
   --  Register hotplug module Name into Server with address URL to respond to
   --  requests matching Regexp. Server must be a valid URL, http://host:port.
   --  If port is not specified the default HTTP port is used.

   function Unregister
     (Name     : String;
      Password : String;
      Server   : String;
      Regexp   : String) return Response.Data;
   --  Unregister hotplug module Name responding to Regexp requests from
   --  Server. See comment above about Password.

end AWS.Client.Hotplug;
