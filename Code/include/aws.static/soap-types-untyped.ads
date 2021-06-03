------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2005-2015, AdaCore                     --
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

--  Internal unit only, should not be used by end-user. This is designed to
--  convert simple value without xsi:type information to typed data by the
--  SOAP engine.

package SOAP.Types.Untyped is

   type Untyped is new XSD_String with null record;
   --  This type is used to record value as a string for untyped value found
   --  while parsing a payload. Such a type will be automatically converted to
   --  another type (Integer, Short, Unsigned_Long, Time_Instant...) by the
   --  SOAP.Types.Get routine.

   overriding function S
     (V         : String;
      Name      : String := "item";
      Type_Name : String := XML_String;
      NS        : SOAP.Name_Space.Object := SOAP.Name_Space.No_Name_Space)
      return Untyped;

   overriding function S
     (V         : Unbounded_String;
      Name      : String  := "item";
      Type_Name : String := XML_String;
      NS        : SOAP.Name_Space.Object := SOAP.Name_Space.No_Name_Space)
      return Untyped;

end SOAP.Types.Untyped;
