------------------------------------------------------------------------------
--                             Templates Parser                             --
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

package body Templates_Parser.Query is

   ---------------
   -- Composite --
   ---------------

   function Composite
     (Association : Templates_Parser.Association)
      return Tag is
   begin
      if Association.Kind = Composite then
         return Association.Comp_Value;
      else
         raise Constraint_Error
           with Variable (Association) & " is not a composite tag.";
      end if;
   end Composite;

   ----------
   -- Kind --
   ----------

   function Kind
     (Association : Templates_Parser.Association)
      return Association_Kind is
   begin
      return Association.Kind;
   end Kind;

   ------------------
   -- Nested_Level --
   ------------------

   function Nested_Level (T : Tag) return Positive is
   begin
      return T.Data.Nested_Level;
   end Nested_Level;

   --------------
   -- Variable --
   --------------

   function Variable
     (Association : Templates_Parser.Association)
      return String is
   begin
      return To_String (Association.Variable);
   end Variable;

end Templates_Parser.Query;
