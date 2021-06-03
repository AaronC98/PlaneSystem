------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2007-2017, AdaCore                     --
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

package AWS.URL.Set is

   function Parameters
     (URL : not null access Object) return access AWS.Parameters.List
     with Inline;
   --  Returned the URL's parameters list object This is intended to pass
   --  the internal parameters list component to routines in
   --  AWS.Parameters.Set.

   procedure Parameters (URL : in out Object; Set : AWS.Parameters.List)
     with Inline;
   --  Set the URL's parameters list to Set

   procedure Connection_Data
     (URL      : in out Object;
      Host     : String;
      Port     : Positive;
      Security : Boolean);
   --  Update connection data, used by the server

   procedure Security (URL : in out Object; Flag : Boolean);
   --  Update protocol security flag of the URL.
   --  Change port to default of new protocol if port was default on
   --  previous protocol.

   procedure Parse
     (Item           : in out Object;
      URL            : String;
      Check_Validity : Boolean := True;
      Normalize      : Boolean := False);

end AWS.URL.Set;
