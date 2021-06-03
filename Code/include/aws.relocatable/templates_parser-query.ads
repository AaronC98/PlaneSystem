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

package Templates_Parser.Query is

   function Kind
     (Association : Templates_Parser.Association) return Association_Kind;
   --  Returns the kind for this association

   function Variable
     (Association : Templates_Parser.Association) return String;
   --  Returns the variable name for Association

   function Composite
     (Association : Templates_Parser.Association) return Tag;
   --  Returns the vector tag for this association, raises Constraint_Error
   --  if it is not a vector.

   function Nested_Level (T : Tag) return Positive;
   --  Returns the nested level for tag T, 1 means that this is a vector tag,
   --  2 that it is a matrix.

end Templates_Parser.Query;
