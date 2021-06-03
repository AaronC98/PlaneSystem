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

--  This package and children provide a number of types and subprograms for
--  creating reponse text used in ESMTP authentication.

package AWS.SMTP.Authentication is

   type Credential is abstract tagged private;
   --  Information needed by some authentication protocol

   procedure Before_Send
     (Credential : Authentication.Credential;
      Sock       : in out Net.Socket_Type'Class;
      Status     : out SMTP.Status) is null;
   --  Null default implementation

   procedure After_Send
     (Credential : Authentication.Credential;
      Sock       : in out Net.Socket_Type'Class;
      Status     : out SMTP.Status) is null;
   --  Null default implementation

   function Image (Info : Credential) return String is abstract;
   --  Response to be sent to the server

private

   type Credential is abstract tagged null record;

end AWS.SMTP.Authentication;
