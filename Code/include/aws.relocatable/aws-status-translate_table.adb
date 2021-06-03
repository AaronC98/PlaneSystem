------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2003-2014, AdaCore                     --
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

function AWS.Status.Translate_Table
  (Status : Data) return Templates.Translate_Table
is
   use Templates;
begin
   return (Assoc ("PEERNAME",     To_String (Status.Peername)),
           Assoc ("METHOD",       Method (Status)),
           Assoc ("URI",          AWS.URL.URL (Status.URI)),
           Assoc ("HTTP_VERSION", To_String (Status.HTTP_Version)),
           Assoc ("AUTH_MODE",    Authorization_Type'Image (Status.Auth_Mode)),
           Assoc ("SOAP_ACTION",  Status.SOAP_Action),
           Assoc ("PAYLOAD",      String'(AWS.Status.Payload (Status))));
end AWS.Status.Translate_Table;
