
------------------------------------------------------------------------------
--                                                                          --
--                         GNAT RUNTIME COMPONENTS                          --
--                                                                          --
--                                  F M                                     --
--                                                                          --
--                                 S p e c                                  --
--                                                                          --
--                            $Revision: 1.3 $                               --
--                                                                          --
--           Copyright (C) 1998-2000 Ada Core Technologies, Inc.            --
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

with Interfaces.Fortran;
use Interfaces.Fortran;
package FM is
   pragma Elaborate_Body;

   --  Root of the FM (Fortran Multitasking) Interface
   --  Interface to Fortran program can be found in FM.Interface

   NB_Workers : Integer := 6;
   --  This variable determines the number of workers that will work in
   --  parallel to statisfy the requests from the Fortran code. It is
   --  reinitialized in the body of this package if a file fm.ini is found
   --  in the current directory. This value can be interrogated from
   --  Fortran by means of function Nb_Tasks.

   Worker_Stack_Size : Integer;
   --  The size of the stack for each worker. This value is
   --  initialized in the body of this package.


   NB_Jobs : constant := 500;
   --  This constant determines the maximum number of jobs that can be
   --  posted asynchronously.

   NB_Sync : constant := 10;
   --  This constant determines the maximum number of calls to INITSYNC
   --  that can be made before doing a WAITSYNC. i.e. how many batch of
   --  parallel operations can be open at the same time

   Waiting_Time : duration := 0.1;
   --  This variable determines the polling rate used by a worker task to
   --  retrieve a work item from the queue. Reset by Set_Waiting_Time, which
   --  is called from Fortran.

   function Nb_Tasks return Fortran_Integer;
   pragma Export (Fortran, Nb_Tasks);

   procedure Set_Waiting_Time (T : Real);
   pragma Export (Fortran, Set_Waiting_Time);

private
   Stop_Called : Boolean := False;
end FM;
