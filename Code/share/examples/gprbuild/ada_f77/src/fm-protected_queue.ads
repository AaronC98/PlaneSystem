------------------------------------------------------------------------------
--                                                                          --
--                         GNAT RUNTIME COMPONENTS                          --
--                                                                          --
--                   F M _ P R O T E C T E D _ Q U E U E                    --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--                            $Revision: 1.1 $                             --
--                                                                          --
--           Copyright (C) 1995-1998 Ada Core Technologies, Inc.            --
--                                                                          --
-- GNAT is free software;  you can  redistribute it  and/or modify it under --
-- terms of the  GNU General Public License as published  by the Free Soft- --
-- ware  Foundation;  either version 2,  or (at your option) any later ver- --
-- sion.  GNAT is distributed in the hope that it will be useful, but WITH- --
-- OUT ANY WARRANTY;  without even the  implied warranty of MERCHANTABILITY --
-- or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License --
-- for  more details.  You should have  received  a copy of the GNU General --
-- Public License  distributed with GNAT;  see file COPYING.  If not, write --
-- to  the Free Software Foundation,  59 Temple Place - Suite 330,  Boston, --
-- MA 02111-1307, USA.                                                      --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
-- GNAT is maintained by Ada Core Technologies Inc (http://www.gnat.com).   --
--                                                                          --
------------------------------------------------------------------------------

--  This package provides a generic protected queue type. Insertions and
--  deletions are serialized by an internal protected object. The package is
--  parametrized with the total queue capacity, and with the type of the
--  objects to be queued.

generic
   Cap : integer;
   type T is private;
package FM.Protected_Queue is
   type Jobs is array (0 .. Cap - 1) of T;

   protected Queue is
      entry Insert (Object : T);
      entry Remove (Object : out T);
   private
      Front, Back : Integer := 0;
      Contents    : Integer := 0;
      Pending     : Jobs;
   end Queue;
end FM.Protected_Queue;
