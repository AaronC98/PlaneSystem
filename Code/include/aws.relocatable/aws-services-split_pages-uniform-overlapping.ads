------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2004-2012, AdaCore                     --
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

package AWS.Services.Split_Pages.Uniform.Overlapping is

   --  Same as the uniform splitter, but pages (except the first one)
   --  repeat Overlap lines from the previous page in addition to the
   --  Max_Per_Page lines
   --
   --  Tags:
   --  Same as the Uniform splitter

   type Splitter
     (Max_Per_Page : Positive;
      Overlap      : Natural) is new Uniform.Splitter with private;

   overriding function Get_Page_Ranges
     (This  : Splitter;
      Table : Templates.Translate_Set) return Ranges_Table;

private

   type Splitter (Max_Per_Page : Positive; Overlap : Natural)
     is new Uniform.Splitter (Max_Per_Page) with null record;

end AWS.Services.Split_Pages.Uniform.Overlapping;
