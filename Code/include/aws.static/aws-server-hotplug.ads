------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2000-2014, AdaCore                     --
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

with AWS.Hotplug;

package AWS.Server.Hotplug is

   --  Messages used to register/unregister hotplug modules

   Register_Message      : constant String := "REGISTER";
   Unregister_Message    : constant String := "UNREGISTER";
   Request_Nonce_Message : constant String := "REQUEST_NONCE";

   --  The Authorization_File below is a file that contains authorizations
   --  for the hotplug modules. Only modules that have an entry into this
   --  file will be able to register to server. Each line on this file must
   --  have the following format:
   --
   --  <module_name>:<md5_password>:<host>:<port>
   --
   --  module_name  : The name of the module that will register
   --  md5_password : The corresponding password, use aws_password
   --                 tool to generate such password
   --  host         : The host name where requests will be redirected
   --  port         : and the corresponding port

   procedure Activate
     (Web_Server         : not null access HTTP;
      Port               : Positive;
      Authorization_File : String;
      Register_Mode      : AWS.Hotplug.Register_Mode := AWS.Hotplug.Add;
      Host               : String                    := "");
   --  Start hotplug server listening at the specified Port for the Web_Server.
   --  Only client modules listed in the authorization file will be able to
   --  connect to this server. For better securite the host of redictection
   --  must also be specified.

   procedure Shutdown;
   --  Shutdown hotplug server

end AWS.Server.Hotplug;
