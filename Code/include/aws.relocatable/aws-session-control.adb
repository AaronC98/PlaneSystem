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

with Ada.Unchecked_Deallocation;

package body AWS.Session.Control is

   -----------
   -- Force --
   -----------

   procedure Force_Cleaner (Timeout : Duration := 0.0) is
   begin
      select
         Cleaner_Task.Force;
      or
         delay Timeout;
         --  It means that cleaner task is already running
      end select;
   end Force_Cleaner;

   --------------
   -- Shutdown --
   --------------

   procedure Shutdown is

      procedure Unchecked_Free is
         new Ada.Unchecked_Deallocation (Cleaner, Cleaner_Access);

      Need_Release : Boolean;

   begin
      Cleaner_Control.Stop (Need_Release);

      if Need_Release then

         Cleaner_Task.Stop;

         --  Wait for task termination

         while not Cleaner_Task'Terminated loop
            delay 0.5;
         end loop;

         --  Release memory

         Unchecked_Free (Cleaner_Task);
      end if;
   end Shutdown;

   -----------
   -- Start --
   -----------

   procedure Start
     (Session_Check_Interval : Duration; Session_Lifetime : Duration) is
   begin
      Cleaner_Control.Start (Session_Check_Interval, Session_Lifetime);
   end Start;

end AWS.Session.Control;
