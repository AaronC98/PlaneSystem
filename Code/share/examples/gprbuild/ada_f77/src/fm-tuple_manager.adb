------------------------------------------------------------------------------
--                                                                          --
--                         GNAT RUNTIME COMPONENTS                          --
--                                                                          --
--                      F M - T U P L E _ M A N A G E R                     --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--                            $Revision: 1.1 $                             --
--                                                                          --
--           Copyright (C) 1995-1998 Ada Core Technologies, Inc.            --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 2,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License --
-- for  more details.  You should have  received  a copy of the GNU General --
-- Public License  distributed with GNAT;  see file COPYING.  If not, write --
-- to  the Free Software Foundation,  59 Temple Place - Suite 330,  Boston, --
-- MA 02111-1307, USA.                                                      --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
-- GNAT is maintained by Ada Core Technologies Inc (http://www.gnat.com).   --
--                                                                          --
------------------------------------------------------------------------------

with FM.Locks; use FM.Locks;
package body FM.Tuple_Manager is

   procedure Post (T : Tuple) is
   begin
      Inc (T.Synch);
      Queue.Insert (T);
   end;

   task body Worker is
      T : Tuple;

   begin
      while not Stop_Called loop
         select
         Queue.Remove (T);

          case T.N is
             when 1 =>
                To_Ptr1 (T.Ptr) (T.Actuals (1));
             when 2 =>
                To_Ptr2 (T.Ptr) (
                  T.Actuals (1),
                  T.Actuals (2));
             when 3 =>
                To_Ptr3 (T.Ptr) (
                  T.Actuals (1),
                  T.Actuals (2),
                  T.Actuals (3));
             when 4 =>
                To_Ptr4 (T.Ptr) (
                  T.Actuals (1),
                  T.Actuals (2),
                  T.Actuals (3),
                  T.Actuals (4));
             when 5 =>
                To_Ptr5 (T.Ptr) (
                  T.Actuals (1),
                  T.Actuals (2),
                  T.Actuals (3),
                  T.Actuals (4),
                  T.Actuals (5));
             when 6 =>
                To_Ptr6 (T.Ptr) (
                  T.Actuals (1),
                  T.Actuals (2),
                  T.Actuals (3),
                  T.Actuals (4),
                  T.Actuals (5),
                  T.Actuals (6));
             when others =>
                raise Program_Error;
          end case;

          --  Indicate that iterate is complete.
 
          Inc (T.Synch, -1);
 
          --  Deallocate the saved parameters
 
          for I in 1 .. T.N loop
             if T.Saved (I) then
                Free (T.Actuals (I));
             end if;
          end loop;
      or
         delay 0.1;
      end select;
      end loop;
   end Worker;
end FM.Tuple_Manager;
