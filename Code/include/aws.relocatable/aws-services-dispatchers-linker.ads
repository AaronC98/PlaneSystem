------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2005-2012, AdaCore                     --
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

--  Link two dispatchers together

with AWS.Dispatchers;
with AWS.Response;
with AWS.Status;

package AWS.Services.Dispatchers.Linker is

   type Handler is new AWS.Dispatchers.Handler with private;

   procedure Register
     (Dispatcher    : in out Handler;
      First, Second : AWS.Dispatchers.Handler'Class);
   --  Set the dispatcher first and second handler. The First handler will be
   --  looked for before the second.

private

   overriding procedure Initialize (Dispatcher : in out Handler);
   overriding procedure Finalize   (Dispatcher : in out Handler);

   overriding function Dispatch
     (Dispatcher : Handler;
      Request    : Status.Data) return Response.Data;
   --  Dispatch to the first dispatcher, if the resources is not found (status
   --  code 404 returned) there try on the second one.

   overriding function Clone (Dispatcher : Handler) return Handler;
   --  Returns a deep copy of the dispatcher

   type Handler is new AWS.Dispatchers.Handler with record
      First, Second : AWS.Dispatchers.Handler_Class_Access;
   end record;

end AWS.Services.Dispatchers.Linker;
