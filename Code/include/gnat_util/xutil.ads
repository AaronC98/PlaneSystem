------------------------------------------------------------------------------
--                                                                          --
--                          GNAT SYSTEM UTILITIES                           --
--                                                                          --
--                                X U T I L                                 --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--          Copyright (C) 1992-2019, Free Software Foundation, Inc.         --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 3,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.                                     --
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
-- GNAT was originally developed  by the GNAT team at  New York University. --
-- Extensive contributions were provided by Ada Core Technologies Inc.      --
--                                                                          --
------------------------------------------------------------------------------

--  Shared routines for the build-time code generation utilities

with Ada.Streams.Stream_IO;
with Ada.Strings.Unbounded;

package XUtil is

   subtype VString is Ada.Strings.Unbounded.Unbounded_String;
   subtype Sfile is Ada.Streams.Stream_IO.File_Type;

   procedure Put (F : Sfile; S : String);
   procedure Put (F : Sfile; S : VString);
   procedure Put_Line (F : Sfile; S : String);
   procedure Put_Line (F : Sfile; S : VString);
   procedure New_Line (F : Sfile);
   --  Similar to the same-named Ada.Text_IO routines, but ensure UNIX line
   --  ending on all platforms.

end XUtil;
