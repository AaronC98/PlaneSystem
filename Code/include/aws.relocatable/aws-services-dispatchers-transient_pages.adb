------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2003-2012, AdaCore                     --
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

with AWS.Dispatchers.Callback;
with AWS.Messages;
with AWS.Resources.Streams;
with AWS.Services.Transient_Pages;

package body AWS.Services.Dispatchers.Transient_Pages is

   use AWS.Dispatchers;

   use type AWS.Resources.Streams.Stream_Access;

   -----------
   -- Clone --
   -----------

   overriding function Clone (Dispatcher : Handler) return Handler is
      New_Dispatcher : Handler;
   begin
      if Dispatcher.Action /= null then
         New_Dispatcher.Action :=
           new AWS.Dispatchers.Handler'Class'
             (AWS.Dispatchers.Handler'Class (Dispatcher.Action.Clone));
      end if;

      return New_Dispatcher;
   end Clone;

   --------------
   -- Dispatch --
   --------------

   overriding function Dispatch
     (Dispatcher : Handler;
      Request    : Status.Data) return Response.Data
   is
      use type Messages.Status_Code;

      Result : Response.Data;
   begin
      Result := Dispatch (Dispatcher.Action.all, Request);

      if Response.Status_Code (Result) = Messages.S404 then
         --  Page not found, look if this is a transient page

         declare
            URI    : constant String := Status.URI (Request);
            Stream : constant AWS.Resources.Streams.Stream_Access :=
                       Services.Transient_Pages.Get (URI);
         begin
            if Stream = null then
               --  This page is not a transient one
               return Result;

            else
               return Response.Stream
                 (Status.Content_Type (Request),
                  Stream,
                  Server_Close => False);
            end if;
         end;

      else
         return Result;
      end if;
   end Dispatch;

   --------------
   -- Register --
   --------------

   procedure Register
     (Dispatcher : in out Handler;
      Action     : AWS.Dispatchers.Handler'Class) is
   begin
      if Dispatcher.Action /= null then
         Free (Dispatcher.Action);
      end if;

      Dispatcher.Action := new AWS.Dispatchers.Handler'Class'(Action);
   end Register;

   procedure Register
     (Dispatcher : in out Handler;
      Action     : Response.Callback) is
   begin
      Register (Dispatcher, AWS.Dispatchers.Callback.Create (Action));
   end Register;

end AWS.Services.Dispatchers.Transient_Pages;
