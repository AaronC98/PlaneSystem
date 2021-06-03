------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2004-2017, AdaCore                     --
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

--  Services to be used to declare aliases based on URI. This is mostly
--  designed to be used with AWS.services.Dispatchers.URI.

with AWS.Response;
with AWS.Status;

package AWS.Services.Callbacks is

   generic
      Prefix    : String; -- the prefix found in the URI
      Directory : String; -- the directory where the file is
   function File (Request : Status.Data) return Response.Data;
   --  This is a callback function where URL:
   --     http://<host>/<prefix>toto
   --  references the file:
   --     <directory>/toto
   --
   --  If the URL does not start with Prefix it returns a 404 error page.
   --  This is designed to be use with AWS.Services.Dispatchers.URI.

end AWS.Services.Callbacks;
