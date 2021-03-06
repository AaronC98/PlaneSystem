------------------------------------------------------------------------------
--                           G N A T C O L L . O S                          --
--                                                                          --
--                        Copyright (C) 2017, AdaCore                       --
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

package GNATCOLL.OS is
   pragma Pure;

   --  Supported OS types
   type OS_Type is (Windows, Unix, MacOS);

   --  The filename resolution policy of a given file system
   type Filename_Casing_Policy is (
      Lower_Case,  --  case insensitive file system, normalized lower case
      Upper_Case,  --  case insensitive file system, normalized upper case
      Preserving,  --  case insensitive file system, case is preserved
      Sensitive    --  case sensitive file system
      );

end GNATCOLL.OS;
