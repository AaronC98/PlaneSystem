------------------------------------------------------------------------------
--                                                                          --
--                           GPR PROJECT MANAGER                            --
--                                                                          --
--          Copyright (C) 2001-2016, Free Software Foundation, Inc.         --
--                                                                          --
-- This library is free software;  you can redistribute it and/or modify it --
-- under terms of the  GNU General Public License  as published by the Free --
-- Software  Foundation;  either version 3,  or (at your  option) any later --
-- version. This library is distributed in the hope that it will be useful, --
-- but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE.                            --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
------------------------------------------------------------------------------

--  This package implements parsing of string expressions in project files

private package GPR.Strt is

   procedure Parse_String_Type_List
     (In_Tree      : Project_Node_Tree_Ref;
      First_String : out Project_Node_Id;
      Flags        : Processing_Flags);
   --  Get the list of literal strings that are allowed for a typed string.
   --  On entry, the current token is the first literal string following
   --  a left parenthesis in a string type declaration such as:
   --    type Toto is ("string_1", "string_2", "string_3");
   --
   --  On exit, the current token is the right parenthesis. The parameter
   --  First_String is a node that contained the first literal string of the
   --  string type, linked with the following literal strings.
   --
   --  Report an error if
   --    - a literal string is not found at the beginning of the list
   --      or after a comma
   --    - two literal strings in the list are equal

   procedure Start_New_Case_Construction
     (In_Tree     : Project_Node_Tree_Ref;
      String_Type : Project_Node_Id);
   --  This procedure is called at the beginning of a case construction. The
   --  parameter String_Type is the node for the string type of the case label
   --  variable. The different literal strings of the string type are stored
   --  into a table to be checked against the labels of the case construction.

   procedure End_Case_Construction
     (Check_All_Labels : Boolean;
      Case_Location    : Source_Ptr;
      Flags            : Processing_Flags;
      String_Type      : Boolean);
   --  This procedure is called at the end of a case construction to remove
   --  the case labels and to restore the previous state. In particular, in the
   --  case of nested case constructions, the case labels of the enclosing case
   --  construction are restored. If When_Others is False and we are not in
   --  quiet output, a warning is emitted for each value of the case variable
   --  string type that has not been specified.

   procedure Parse_Choice_List
     (In_Tree      : Project_Node_Tree_Ref;
      First_Choice : out Project_Node_Id;
      Flags        : Processing_Flags;
      String_Type  : Boolean := True);
   --  Get the label for a choice list.
   --  Report an error if
   --    - a case label is not a literal string
   --    - a case label is not in the typed string list
   --    - the same case label is repeated in the same case construction

   procedure Parse_Expression
     (In_Tree         : Project_Node_Tree_Ref;
      Expression      : out Project_Node_Id;
      Current_Project : Project_Node_Id;
      Current_Package : Project_Node_Id;
      Optional_Index  : Boolean;
      Flags           : Processing_Flags);
   --  Parse a simple string expression or a string list expression
   --
   --  Current_Project is the node of the project file being parsed
   --
   --  Current_Package is the node of the package being parsed, or Empty_Node
   --  when we are at the project level (not in a package). On exit, Expression
   --  is the node of the expression that has been parsed.

   procedure Parse_Variable_Reference
     (In_Tree         : Project_Node_Tree_Ref;
      Variable        : out Project_Node_Id;
      Current_Project : Project_Node_Id;
      Current_Package : Project_Node_Id;
      Flags           : Processing_Flags;
      Allow_Attribute : Boolean := True);
   --  Parse variable or attribute reference. Used internally (in expressions)
   --  and for case variables (in Prj.Dect). Current_Package is the node of
   --  the package being parsed, or Empty_Node when we are at the project
   --  level (not in a package). On exit, Variable is the node of the variable
   --  or attribute reference. A variable reference is made of one to three
   --  simple names. An attribute reference is made of one or two simple names,
   --  followed by an apostrophe, followed by the attribute simple name. If
   --  Allow_Attribute is False, it is illegal to parse an attribute reference.

end GPR.Strt;
