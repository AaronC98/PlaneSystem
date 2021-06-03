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

package body AWS.Dispatchers is

   ------------
   -- Adjust --
   ------------

   overriding procedure Adjust (Dispatcher : in out Handler) is
   begin
      Dispatcher.Ref_Counter.all := Dispatcher.Ref_Counter.all + 1;
   end Adjust;

   --------------
   -- Finalize --
   --------------

   overriding procedure Finalize (Dispatcher : in out Handler) is
      use type Utils.Counter_Access;
      Ref_Counter : Utils.Counter_Access := Dispatcher.Ref_Counter;
   begin
      --  Ensure call is idempotent

      Dispatcher.Ref_Counter := null;

      if Ref_Counter /= null then
         Ref_Counter.all := Ref_Counter.all - 1;
         if Ref_Counter.all = 0 then
            Utils.Unchecked_Free (Ref_Counter);
         end if;
      end if;
   end Finalize;

   ----------
   -- Free --
   ----------

   procedure Free (Dispatcher : in out Handler_Class_Access) is
      procedure Unchecked_Free is
        new Ada.Unchecked_Deallocation (Handler'Class, Handler_Class_Access);
   begin
      Unchecked_Free (Dispatcher);
   end Free;

   ----------------
   -- Initialize --
   ----------------

   overriding procedure Initialize (Dispatcher : in out Handler) is
   begin
      Dispatcher.Ref_Counter := new Natural'(1);
   end Initialize;

   -----------------
   -- Ref_Counter --
   -----------------

   function Ref_Counter (Dispatcher : Handler) return Natural is
      use type Utils.Counter_Access;
   begin
      if Dispatcher.Ref_Counter = null then
         return 0;
      else
         return Dispatcher.Ref_Counter.all;
      end if;
   end Ref_Counter;

end AWS.Dispatchers;
