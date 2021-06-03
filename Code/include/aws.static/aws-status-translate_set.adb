------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2008-2014, AdaCore                     --
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

function AWS.Status.Translate_Set
  (Status : Data) return Templates.Translate_Set
is
   use Templates;
   Tr : Templates.Translate_Set;
begin
   Insert (Tr, Assoc ("PEERNAME",     To_String (Status.Peername)));
   Insert (Tr, Assoc ("METHOD",       Method (Status)));
   Insert (Tr, Assoc ("URI",          AWS.URL.URL (Status.URI)));
   Insert (Tr, Assoc ("HTTP_VERSION", To_String (Status.HTTP_Version)));
   Insert (Tr, Assoc ("AUTH_MODE",
                     Authorization_Type'Image (Status.Auth_Mode)));
   Insert (Tr, Assoc ("SOAP_ACTION",  Status.SOAP_Action));
   Insert (Tr, Assoc ("PAYLOAD",      String'(AWS.Status.Payload (Status))));

   return Tr;
end AWS.Status.Translate_Set;
