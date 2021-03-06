pragma License (Modified_GPL);

------------------------------------------------------------------------------
--                                                                          --
--                                                                          --
--                                                                          --
--              Copyright (C) 2001-2003 Matthew J Heaney                    --
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
-- Utils is maintained by Matthew J Heaney.                               --
--                                                                          --
-- http://home.earthlink.net/~matthewjheaney/index.html                     --
-- mailto:matthewjheaney@earthlink.net                                      --
--                                                                          --
------------------------------------------------------------------------------
generic

   type Iterator_Type is private;
   
   with function Succ (Iterator : Iterator_Type)
      return Iterator_Type is <>;
   
   with function Pred (Iterator : Iterator_Type)
      return Iterator_Type is <>;
   
   with procedure Swap (L, R : Iterator_Type) is <>;

   with function "<" (L, R : Iterator_Type) return Boolean is <>;

   with function "=" (L, R : Iterator_Type) return Boolean is <>;

procedure Utils.Algorithms.Generic_Reverse_Random_Access
  (First, Back : Iterator_Type);
  
pragma Pure (Utils.Algorithms.Generic_Reverse_Random_Access);

