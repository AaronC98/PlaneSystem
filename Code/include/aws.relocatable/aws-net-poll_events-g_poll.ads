------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                       Copyright (C) 2017, AdaCore                        --
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

with Interfaces.C;

private generic
   type FD_Set_Type is private;
   with procedure FD_ZERO (Set : in out FD_Set_Type);
   with procedure FD_SET (FD : OS_Lib.FD_Type; Set : in out FD_Set_Type);
   with function FD_ISSET
          (FD : OS_Lib.FD_Type; Set : FD_Set_Type) return Interfaces.C.int;
procedure AWS.Net.Poll_Events.G_Poll
  (Fds : in out Set; Timeout : Timeout_Type; Result : out Integer);
--  Need to implement Wait routine on top of posix or win32 select
