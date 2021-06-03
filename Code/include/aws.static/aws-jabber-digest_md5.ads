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

with Ada.Strings.Unbounded;

with AWS.Translator;

package AWS.Jabber.Digest_Md5 is

   use Ada.Strings.Unbounded;

   --  DIGEST-MD5 authentication mechanism for python SASL implementation.
   --
   --  Normative reference: RFC 2831 <http://www.ietf.org/rfc/rfc2831.txt>

   type Challenge is record
      Nonce : Unbounded_String;
      Realm : Unbounded_String;
   end record;

   function Decode_Challenge
     (Encoded_Challenge : Translator.Base64_String) return Challenge
   with
       Pre  => Encoded_Challenge'Length > 0,
       Post => Decode_Challenge'Result /=
                 (Null_Unbounded_String, Null_Unbounded_String);
   --  Decode the Base64 encoded message and returns the challenge

   function Reply_Challenge
     (Username, Realm, Password, Host, Nonce : String)
      return Translator.Base64_String
   with
     Pre =>
         Username'Length > 0
         and then Password'Length > 0
         and then Host'Length > 0
         and then Nonce'Length > 0;

end AWS.Jabber.Digest_Md5;
