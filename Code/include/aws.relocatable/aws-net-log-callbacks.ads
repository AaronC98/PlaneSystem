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

--  Some ready to use write procedures

package AWS.Net.Log.Callbacks is

   procedure Initialize
     (Filename : String;
      Callback : Write_Callback);
   --  Initialize the logging, must be called before using the callbacks below

   procedure Finalize;
   --  Stop logging, close log file

   procedure Text
     (Direction : Data_Direction;
      Socket    : Socket_Type'Class;
      Data      : Stream_Element_Array;
      Last      : Stream_Element_Offset);
   --  A text output, each chunk is output with an header and footer:
   --     Data sent/received to/from socket <FD> (<size>/<buffer size>)
   --     <data>
   --     Total data sent: <nnn> received: <nnn>

   procedure Binary
     (Direction : Data_Direction;
      Socket    : Socket_Type'Class;
      Data      : Stream_Element_Array;
      Last      : Stream_Element_Offset);
   --  A binary output, each chunk is output with an header and footer. The
   --  data itself is written using a format close to the Emacs hexl-mode:
   --     Data sent/received to/from socket <FD> (<size>/<buffer size>)
   --     HH HH HH HH HH HH HH HH HH HH HH HH   az.rt.mpl..q
   --     Total data sent: <nnn> received: <nnn>
   --
   --  HH is the hex character number, if the character is not printable a dot
   --  is written.

end AWS.Net.Log.Callbacks;
