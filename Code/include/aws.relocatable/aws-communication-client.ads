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

with AWS.Response;

package AWS.Communication.Client is

   function Send_Message
     (Server     : String;
      Port       : Positive;
      Name       : String;
      Parameters : Parameter_Set := Null_Parameter_Set)
      return Response.Data;
   --  Send a message to server with a set of parameters. The destination is
   --  server is http://Server:Port, the message name is Name and the set of
   --  parameters is to be found into Parameters.
   --
   --  The complete message format is:
   --
   --  http://<Server>:<Port>/AWS_Com?HOST=<host>&NAME=<name>
   --    &P1=<param1>&P2=<param2>

end AWS.Communication.Client;
