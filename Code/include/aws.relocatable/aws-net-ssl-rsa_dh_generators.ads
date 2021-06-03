------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                       Copyright (C) 2014, AdaCore                        --
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

private package AWS.Net.SSL.RSA_DH_Generators is

   procedure Start_Parameters_Generation
     (DH : Boolean; Logging : access procedure (Text : String) := null);
   --  Start SSL parameters regeneration in background.
   --  DH is False mean only RSA parameters generated.
   --  DH is True mean RSA and DH both parameters generated.

   function Parameters_Filename (Kind : String; Exist : Boolean) return String;
   --  Returns DH parameters filename in internal AWS security storage
   --  directory. Returns empty string if filename does not exist and could
   --  not be created. Common code for use in GNUTLS and OpenSSL
   --  implementations.

end AWS.Net.SSL.RSA_DH_Generators;
