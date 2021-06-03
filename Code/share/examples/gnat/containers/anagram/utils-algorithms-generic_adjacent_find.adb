------------------------------------------------------------------------------
--                                                                          --
--                                                                          --
--                                                                          --
--              Copyright (C) 2001-2004 Matthew J Heaney                    --
--                                                                          --
-- The Utils Container Library ("Utils") is free software; you can      --
-- redistribute it and/or modify it under terms of the GNU General Public   --
-- License as published by the Free Software Foundation; either version 2,  --
-- or (at your option) any later version.  Utils is distributed in the    --
-- hope that it will be useful, but WITHOUT ANY WARRANTY; without even the  --
-- implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. --
-- See the GNU General Public License for more details.  You should have    --
-- received a copy of the GNU General Public License distributed with       --
-- Utils;  see file COPYING.TXT.  If not, write to the Free Software      --
-- Foundation,  59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.    --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
-- Utils is maintained by Matthew J Heaney.                               --
--                                                                          --
-- http://home.earthlink.net/~matthewjheaney/index.html                     --
-- mailto:matthewjheaney@earthlink.net                                      --
--                                                                          --
------------------------------------------------------------------------------

function Utils.Algorithms.Generic_Adjacent_Find
  (First, Back : Iterator_Type) return Iterator_Type is

   Iter, Next : Iterator_Type := First;

begin

   if Iter = Back then
      return Back;
   end if;

   loop

      Next := Succ (Next);

      if Next = Back then
         return Back;
      end if;

      if Is_Equal (Iter, Next) then
         return Iter;
      end if;

      Iter := Next;

   end loop;

end Utils.Algorithms.Generic_Adjacent_Find;




