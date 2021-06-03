------------------------------------------------------------------------------
--                                                                          --
--                         GNAT RUN-TIME COMPONENTS                         --
--                                                                          --
--                       A D A . D I S P A T C H I N G                      --
--                                                                          --
--                                 B o d y                                  --
--                                                                          --
--             Copyright (C) 2015-2019, Free Software Foundation, Inc.      --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

with Ada.Exceptions;
with System.Tasking;
with System.Task_Primitives.Operations;

package body Ada.Dispatching is

   procedure Yield is
      Self_Id : constant System.Tasking.Task_Id :=
                  System.Task_Primitives.Operations.Self;

   begin
      --  If pragma Detect_Blocking is active, Program_Error must be
      --  raised if this potentially blocking operation is called from a
      --  protected action.

      if System.Tasking.Detect_Blocking
        and then Self_Id.Common.Protected_Action_Nesting > 0
      then
         Ada.Exceptions.Raise_Exception
           (Program_Error'Identity, "potentially blocking operation");
      else
         System.Task_Primitives.Operations.Yield;
      end if;
   end Yield;

end Ada.Dispatching;
