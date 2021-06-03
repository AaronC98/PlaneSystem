------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2004-2013, AdaCore                     --
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

--  Wait implementation on top of native poll call

with System;

separate (AWS.Net.Poll_Events)

procedure Wait
  (Fds : in out Set; Timeout : Timeout_Type; Result : out Integer)
is

   function Poll
     (Fds     : System.Address;
      Nfds    : OS_Lib.nfds_t;
      Timeout : Timeout_Type) return Interfaces.C.int
     with Import => True, Convention => C;

begin
   Result :=
     Integer (Poll (Fds.Fds'Address, OS_Lib.nfds_t (Fds.Length), Timeout));
end Wait;
