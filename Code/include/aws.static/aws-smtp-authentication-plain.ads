------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2007-2012, AdaCore                     --
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

--  This package provides implementation for the PLAIN ESMTP authentication

package AWS.SMTP.Authentication.Plain is

   type Credential is new Authentication.Credential with private;
   --  ESMTP's AUTH PLAIN method

   function Initialize (Auth_Cid, Password : String) return Credential;
   --  Create credentials using the authentication identity Authcid and the
   --  clear-text password Passwd.  Note that each of Authcid and Passwd must
   --  be UTF-8 encoded strings suitable for use in this authentication
   --  mathod, as is. They must not include Character'Val(0). A SASLprep
   --  profile string should work, I think.

   overriding function Image (Info : Credential) return String;
   --  Response to be sent to the server

private

   subtype Octet_255 is String (1 .. 255);
   --  For UTF-8 octects. Index must start at 1

   type Credential is new Authentication.Credential with record
      Auth_Cid : Octet_255;
      Last_A   : Natural range 0 .. Octet_255'Last;
      Password : Octet_255;
      Last_P   : Natural range 0 .. Octet_255'Last;
   end record;

   overriding procedure Before_Send
     (Credential : Plain.Credential;
      Sock       : in out Net.Socket_Type'Class;
      Status     : out SMTP.Status);

end AWS.SMTP.Authentication.Plain;
