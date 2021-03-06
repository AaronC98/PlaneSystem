------------------------------------------------------------------------------
--                              Ada Web Server                              --
--                                                                          --
--                     Copyright (C) 2008-2012, AdaCore                     --
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

with AWS.Headers;
with AWS.Messages;

package AWS.SMTP.Messages is

   --  SMTP headers

   subtype Header_Name is String;

   From_Token          : constant Header_Name := "From";
   To_Token            : constant Header_Name := "To";
   Message_Id_Token    : constant Header_Name := "Message-ID";
   Subject_Token       : constant Header_Name := "Subject";
   MIME_Version_Token  : constant Header_Name := "MIME-Version";
   Content_Type_Token  : constant Header_Name :=
                           AWS.Messages.Content_Type_Token;
   Date_Token          : constant Header_Name :=
                           AWS.Messages.Date_Token;

   --  A message as reported by the server

   type Data is private;

   function Message_Body (Message : Data) return String;
   --  Returns the message body

   function Headers (Message : Data) return Headers.List;
   --  Returns the SMTP headers

private

   type Data is record
      Message_Body : Unbounded_String;
      Headers      : AWS.Headers.List;
   end record;

end AWS.SMTP.Messages;
