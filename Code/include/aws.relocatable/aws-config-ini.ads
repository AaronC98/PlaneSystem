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

--  Handle .ini style configuration files. In those files each option is on one
--  line. The first word is the option name and the second one is the option
--  value.

package AWS.Config.Ini is

   function Program_Ini_File (Full_Path : Boolean) return String;
   --  Returns initialization filename for current server (using the
   --  executable name and adding .ini).

   procedure Read
     (Config   : in out Object;
      Filename : String);
   --  Read Filename and update the configuration object with the
   --  options read from it. Raises Ada.Text_IO.Name_Error if Filename does
   --  not exist. Raises Constraint_Error in case of wrong any parameter name
   --  or value.

end AWS.Config.Ini;
