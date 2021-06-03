------------------------------------------------------------------------------
--                                                                          --
--                           GPR PROJECT MANAGER                            --
--                                                                          --
--          Copyright (C) 2001-2015, Free Software Foundation, Inc.         --
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

--  This package contains low level output routines for writing error messages
--  and informational output.

pragma Warnings (Off);
--  This package is used also by GNATCOLL.Projects
with System.OS_Lib; use System.OS_Lib;
pragma Warnings (On);

package GPR.Output is
   pragma Elaborate_Body;

   type Output_Proc is access procedure (S : String);
   --  This type is used for the Set_Special_Output procedure. If Output_Proc
   --  is called, then instead of lines being written to standard error or
   --  standard output, a call is made to the given procedure for each line,
   --  passing the line with an end of line character (which is a single
   --  ASCII.LF character, even in systems which normally use CR/LF or some
   --  other sequence for line end).

   -----------------
   -- Subprograms --
   -----------------

   procedure Set_Special_Output (P : Output_Proc);
   --  Sets subsequent output to call procedure P. If P is null, then the call
   --  cancels the effect of a previous call, reverting the output to standard
   --  error or standard output depending on the mode at the time of previous
   --  call. Any exception generated by calls to P is simply propagated to
   --  the caller of the routine causing the write operation.

   procedure Cancel_Special_Output;
   --  Cancels the effect of a call to Set_Special_Output, if any. The output
   --  is then directed to standard error or standard output depending on the
   --  last call to Set_Standard_Error or Set_Standard_Output. It is never an
   --  error to call Cancel_Special_Output. It has the same effect as calling
   --  Set_Special_Output (null).

   procedure Set_Standard_Error;
   --  Sets subsequent output to appear on the standard error file (whatever
   --  that might mean for the host operating system, if anything) when
   --  no special output is in effect. When a special output is in effect,
   --  the output will appear on standard error only after special output
   --  has been cancelled.

   procedure Set_Standard_Output;
   --  Sets subsequent output to appear on the standard output file (whatever
   --  that might mean for the host operating system, if anything) when no
   --  special output is in effect. When a special output is in effect, the
   --  output will appear on standard output only after special output has been
   --  cancelled. Output to standard output is the default mode before any call
   --  to either of the Set procedures.

   function Column return Pos;
   pragma Inline (Column);
   --  Returns the number of the column about to be written (e.g. a value of 1
   --  means the current line is empty).

   procedure Write_Char (C : Character);
   --  Write one character to the standard output file. If the character is LF,
   --  this is equivalent to Write_Eol.

   procedure Write_Eol;
   --  Write an end of line (whatever is required by the system in use, e.g.
   --  CR/LF for DOS, or LF for Unix) to the standard output file. This routine
   --  also empties the line buffer, actually writing it to the file. Note that
   --  Write_Eol is the only routine that causes any actual output to be
   --  written. Trailing spaces are removed.

   procedure Write_Int (Val : Int);
   --  Write an integer value with no leading blanks or zeroes. Negative values
   --  are preceded by a minus sign).

   procedure Write_Str (S : String);
   --  Write a string of characters to the standard output file. Note that
   --  end of line is normally handled separately using WRITE_EOL, but it is
   --  allowable for the string to contain LF (but not CR) characters, which
   --  are properly interpreted as end of line characters. The string may also
   --  contain horizontal tab characters.

   procedure Write_Line (S : String);
   --  Equivalent to Write_Str (S) followed by Write_Eol;

end GPR.Output;
