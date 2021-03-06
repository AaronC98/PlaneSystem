------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2003-2013, AdaCore                     --
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

with Ada.Unchecked_Conversion;

separate (AWS.Translator)

package body Conversion is

   --  Check if fast version usable on the platform

   subtype Test_S is String (1 .. 5);
   subtype Test_A is Ada.Streams.Stream_Element_Array (1 .. 5);

   Is_Fast_Possible : constant Boolean :=
                        Test_S'Size = Test_A'Size
                        and then Test_S'Alignment = Test_A'Alignment;

   --  Fast conversion between String and Stream_Element_Array.
   --  Only for Ada compilers and platforms, where it is possible.

   package Fast is

      function To_Stream_Element_Array
        (Data : String) return Stream_Element_Array with Inline;

      function To_String
        (Data : Stream_Element_Array) return String with Inline;

   end Fast;

   --  Portable conversion between String and Stream_Element_Array

   package Portable is

      function To_Stream_Element_Array
        (Data : String) return Stream_Element_Array with Inline;

      function To_String
        (Data : Stream_Element_Array) return String with Inline;

   end Portable;

   ----------
   -- Fast --
   ----------

   package body Fast is

      -----------------------------
      -- To_Stream_Element_Array --
      -----------------------------

      function To_Stream_Element_Array
        (Data : String) return Stream_Element_Array
      is

         subtype Fixed_String is String (Data'First .. Data'Last);

         subtype Fixed_Array is Stream_Element_Array
           (Stream_Element_Offset (Data'First)
            .. Stream_Element_Offset (Data'Last));

         function To_Stream_Elements is
           new Ada.Unchecked_Conversion (Fixed_String, Fixed_Array);

      begin
         return To_Stream_Elements (Data);
      end To_Stream_Element_Array;

      ---------------
      -- To_String --
      ---------------

      function To_String
        (Data : Stream_Element_Array) return String
      is

         Start : constant Positive :=
                   Positive (Stream_Element_Offset'Max (1, Data'First));
         --  If possible keep Data'Range

         subtype Fixed_String is
           String (Start .. Start + Natural (Data'Length) - 1);

         subtype Fixed_Array is Stream_Element_Array (Data'First .. Data'Last);

         function To_Characters is
           new Ada.Unchecked_Conversion (Fixed_Array, Fixed_String);

      begin
         return To_Characters (Data);
      end To_String;

   end Fast;

   --------------
   -- Portable --
   --------------

   package body Portable is

      -----------------------------
      -- To_Stream_Element_Array --
      -----------------------------

      function To_Stream_Element_Array
        (Data : String) return Stream_Element_Array
      is
         Result : Stream_Element_Array
           (Stream_Element_Offset (Data'First)
            .. Stream_Element_Offset (Data'Last));
      begin
         for K in Data'Range loop
            Result (Stream_Element_Offset (K)) := Character'Pos (Data (K));
         end loop;
         return Result;
      end To_Stream_Element_Array;

      ---------------
      -- To_String --
      ---------------

      function To_String (Data : Stream_Element_Array) return String is
         Start  : constant Positive :=
                    Positive (Stream_Element_Offset'Max (1, Data'First));
         --  If possible keep Data'Range

         Result : String (Start .. Start + Natural (Data'Length) - 1);
      begin
         for K in Data'Range loop
            Result (Start + Natural (K - Data'First)) :=
              Character'Val (Data (K));
         end loop;
         return Result;
      end To_String;

   end Portable;

   -----------------------------
   -- To_Stream_Element_Array --
   -----------------------------

   function To_Stream_Element_Array
     (Data : String) return Stream_Element_Array is
   begin
      if Is_Fast_Possible then
         return Fast.To_Stream_Element_Array (Data);
      else
         return Portable.To_Stream_Element_Array (Data);
      end if;
   end To_Stream_Element_Array;

   ---------------
   -- To_String --
   ---------------

   function To_String (Data : Stream_Element_Array) return String is
   begin
      if Is_Fast_Possible then
         return Fast.To_String (Data);
      else
         return Portable.To_String (Data);
      end if;
   end To_String;

end Conversion;
