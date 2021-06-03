------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2002-2012, AdaCore                     --
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

package body AWS.Resources.Streams is

   ------------
   -- Create --
   ------------

   procedure Create
     (Resource : out File_Type;
      Stream   : Stream_Access) is
   begin
      Resource := File_Type (Stream);
   end Create;

   ----------
   -- Name --
   ----------

   function Name (Resource : Stream_Type) return String is
      pragma Unreferenced (Resource);
   begin
      return "";
   end Name;

   ----------
   -- Size --
   ----------

   overriding function Size
     (Resource : Stream_Type) return Stream_Element_Offset
   is
      pragma Unreferenced (Resource);
   begin
      return Undefined_Length;
   end Size;

end AWS.Resources.Streams;
