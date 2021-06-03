------------------------------------------------------------------------------
--                                                                          --
--                           GPR PROJECT MANAGER                            --
--                                                                          --
--          Copyright (C) 2010-2017, Free Software Foundation, Inc.         --
--                                                                          --
-- This library is free software;  you can redistribute it and/or modify it --
-- under terms of the  GNU General Public License  as published by the Free --
-- Software  Foundation;  either version 3,  or (at your  option) any later --
-- version. This library is distributed in the hope that it will be useful, --
-- but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE.                            --
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
------------------------------------------------------------------------------

with GPR.Knowledge; use GPR.Knowledge;
with GPR.Sdefault;  use GPR.Sdefault;

separate (GPR.Util)
package body Knowledge is

   Base : Knowledge_Base;

   -------------------------
   -- Normalized_Hostname --
   -------------------------

   function Normalized_Hostname return String is
      Id : Targets_Set_Id;
   begin
      Get_Targets_Set (Base, Hostname, Id);
      return Normalized_Target (Base, Id);
   end Normalized_Hostname;

   --------------------------
   -- Parse_Knowledge_Base --
   --------------------------

   procedure Parse_Knowledge_Base
     (Project_Tree : Project_Tree_Ref;
      Directory : String := "")
   is

      function Dir return String;
      --  Returns Directory or if empty Default_Knowledge_Base_Directory
      pragma Inline (Dir);

      ---------
      -- Dir --
      ---------

      function Dir return String is
      begin
         if Directory'Length = 0 then
            return Default_Knowledge_Base_Directory;
         else
            return Directory;
         end if;
      end Dir;

   begin
      Parse_Knowledge_Base (Base, Dir, Parse_Compiler_Info => False);
   exception
      when Invalid_Knowledge_Base =>
         Fail_Program
           (Project_Tree, "could not parse the XML files in " & Dir);
   end Parse_Knowledge_Base;

end Knowledge;
