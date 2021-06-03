------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2005-2013, AdaCore                     --
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

pragma Ada_2012;

with Ada.Calendar;

with AWS.Resources;

package Templates_Parser.Configuration is

   subtype Time_Stamp is Ada.Calendar.Time;

   function "="
     (T1, T2 : Time_Stamp)
      return Boolean
      renames Ada.Calendar."=";

   function Is_Regular_File
     (Filename : String)
      return Boolean
      renames AWS.Resources.Is_Regular_File;

   function File_Time_Stamp
     (Filename : String)
      return Time_Stamp
      renames AWS.Resources.File_Timestamp;

end Templates_Parser.Configuration;
