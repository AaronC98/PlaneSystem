switches_comments={
    '-gnatwa': [
         """Activate most optional warnings.""",
         """
This switch activates most optional warning messages.  See the remaining list in this section for details on optional warning messages that can be individually controlled.  The warnings that are not turned on by this switch are: 

* -gnatwd (implicit dereferencing) 
* -gnatw.d (tag warnings with -gnatw switch) 
* -gnatwh (hiding) 
* -gnatw.h (holes in record layouts) 
* -gnatw.j (late primitives of tagged types) 
* -gnatw.k (redefinition of names in standard) 
* -gnatwl (elaboration warnings) 
* -gnatw.l (inherited aspects) 
* -gnatw.n (atomic synchronization) 
* -gnatwo (address clause overlay) 
* -gnatw.o (values set by out parameters ignored) 
* -gnatw.q (questionable layout of record types) 
* -gnatw.s (overridden size clause) 
* -gnatwt (tracking of deleted conditional code) 
* -gnatw.u (unordered enumeration) 
* -gnatw.w (use of Warnings Off) 
* -gnatw.y (reasons for package needing body) 
All other optional warnings are turned on.
"""],
    '-gnatwA': [
         """Suppress all optional errors.""",
         """
This switch suppresses all optional warning messages, see remaining list in this section for details on optional warning messages that can be individually controlled. Note that unlike switch -gnatws, the use of switch -gnatwA does not suppress warnings that are normally given unconditionally and cannot be individually controlled (for example, the warning about a missing exit path in a function). Also, again unlike switch -gnatws, warnings suppressed by the use of switch -gnatwA can be individually turned back on. For example the use of switch -gnatwA followed by switch -gnatwd will suppress all optional warnings except the warnings for implicit dereferencing.
"""],
    '-gnatw.a': [
         """Activate warnings on failing assertions.""",
         """
This switch activates warnings for assertions where the compiler can tell at compile time that the assertion will fail. Note that this warning is given even if assertions are disabled. The default is that such warnings are generated.
"""],
    '-gnatw.A': [
         """Suppress warnings on failing assertions.""",
         """
This switch suppresses warnings for assertions where the compiler can tell at compile time that the assertion will fail.
"""],
    '-gnatwb': [
         """Activate warnings on bad fixed values.""",
         """
This switch activates warnings for static fixed-point expressions whose value is not an exact multiple of Small. Such values are implementation dependent, since an implementation is free to choose either of the multiples that surround the value. GNAT always chooses the closer one, but this is not required behavior, and it is better to specify a value that is an exact multiple, ensuring predictable execution. The default is that such warnings are not generated.
"""],
    '-gnatwB': [
         """Suppress warnings on bad fixed values.""",
         """
This switch suppresses warnings for static fixed-point expressions whose value is not an exact multiple of Small.
"""],
    '-gnatw.b': [
         """Activate warnings on biased representation.""",
         """
This switch activates warnings when a size clause, value size clause, component clause, or component size clause forces the use of biased representation for an integer type (e.g. representing a range of 10..11 in a single bit by using 0/1 to represent 10/11). The default is that such warnings are generated.
"""],
    '-gnatw.B': [
         """Suppress warnings on biased representation.""",
         """
This switch suppresses warnings for representation clauses that force the use of biased representation.
"""],
    '-gnatwc': [
         """Activate warnings on conditionals.""",
         """
This switch activates warnings for conditional expressions used in tests that are known to be True or False at compile time. The default is that such warnings are not generated. Note that this warning does not get issued for the use of boolean variables or constants whose values are known at compile time, since this is a standard technique for conditional compilation in Ada, and this would generate too many false positive warnings. 
This warning option also activates a special test for comparisons using the operators '&gt;=' and' &lt;='. If the compiler can tell that only the equality condition is possible, then it will warn that the '&gt;' or '&lt;' part of the test is useless and that the operator could be replaced by '='. An example would be comparing a ``Natural`` variable &lt;= 0. 
This warning option also generates warnings if one or both tests is optimized away in a membership test for integer values if the result can be determined at compile time. Range tests on enumeration types are not included, since it is common for such tests to include an end point. 
This warning can also be turned on using -gnatwa.
"""],
    '-gnatwC': [
         """Suppress warnings on conditionals.""",
         """
This switch suppresses warnings for conditional expressions used in tests that are known to be True or False at compile time.
"""],
    '-gnatw.c': [
         """Activate warnings on missing component clauses.""",
         """
This switch activates warnings for record components where a record representation clause is present and has component clauses for the majority, but not all, of the components. A warning is given for each component for which no component clause is present.
"""],
    '-gnatw.C': [
         """Suppress warnings on missing component clauses.""",
         """
This switch suppresses warnings for record components that are missing a component clause in the situation described above.
"""],
    '-gnatwd': [
         """Activate warnings on implicit dereferencing.""",
         """
If this switch is set, then the use of a prefix of an access type in an indexed component, slice, or selected component without an explicit ``.all`` will generate a warning. With this warning enabled, access checks occur only at points where an explicit ``.all`` appears in the source code (assuming no warnings are generated as a result of this switch). The default is that such warnings are not generated.
"""],
    '-gnatwD': [
         """Suppress warnings on implicit dereferencing.""",
         """
This switch suppresses warnings for implicit dereferences in indexed components, slices, and selected components.
"""],
    '-gnatw.d': [
         """Activate tagging of warning and info messages.""",
         """
If this switch is set, then warning messages are tagged, with one of the following strings: 
- [-gnatw?] Used to tag warnings controlled by the switch -gnatwx where x is a letter a-z. 

- [-gnatw.?] Used to tag warnings controlled by the switch -gnatw.x where x is a letter a-z. 

- [-gnatel] Used to tag elaboration information (info) messages generated when the static model of elaboration is used and the -gnatel switch is set. 

- [restriction warning] Used to tag warning messages for restriction violations, activated by use of the pragma ``Restriction_Warnings``. 

- [warning-as-error] Used to tag warning messages that have been converted to error messages by use of the pragma Warning_As_Error. Note that such warnings are prefixed by the string "error: " rather than "warning: ". 

- [enabled by default] Used to tag all other warnings that are always given by default, unless warnings are completely suppressed using pragma Warnings(Off) or the switch -gnatws.
"""],
    '-gnatw.D': [
         """Deactivate tagging of warning and info messages messages.""",
         """
If this switch is set, then warning messages return to the default mode in which warnings and info messages are not tagged as described above for -gnatw.d.
"""],
    '-gnatwe': [
         """Treat warnings and style checks as errors.""",
         """
This switch causes warning messages and style check messages to be treated as errors. The warning string still appears, but the warning messages are counted as errors, and prevent the generation of an object file. Note that this is the only -gnatw switch that affects the handling of style check messages. Note also that this switch has no effect on info (information) messages, which are not treated as errors if this switch is present.
"""],
    '-gnatw.e': [
         """Activate every optional warning.""",
         """
This switch activates all optional warnings, including those which are not activated by -gnatwa. The use of this switch is not recommended for normal use. If you turn this switch on, it is almost certain that you will get large numbers of useless warnings. The warnings that are excluded from -gnatwa are typically highly specialized warnings that are suitable for use only in code that has been specifically designed according to specialized coding rules.
"""],
    '-gnatwE': [
         """Treat all run-time exception warnings as errors.""",
         """
This switch causes warning messages regarding errors that will be raised during run-time execution to be treated as errors.
"""],
    '-gnatwf': [
         """Activate warnings on unreferenced formals.""",
         """
This switch causes a warning to be generated if a formal parameter is not referenced in the body of the subprogram. This warning can also be turned on using -gnatwu. The default is that these warnings are not generated.
"""],
    '-gnatwF': [
         """Suppress warnings on unreferenced formals.""",
         """
This switch suppresses warnings for unreferenced formal parameters. Note that the combination -gnatwu followed by -gnatwF has the effect of warning on unreferenced entities other than subprogram formals.
"""],
    '-gnatwg': [
         """Activate warnings on unrecognized pragmas.""",
         """
This switch causes a warning to be generated if an unrecognized pragma is encountered. Apart from issuing this warning, the pragma is ignored and has no effect. The default is that such warnings are issued (satisfying the Ada Reference Manual requirement that such warnings appear).
"""],
    '-gnatwG': [
         """Suppress warnings on unrecognized pragmas.""",
         """
This switch suppresses warnings for unrecognized pragmas.
"""],
    '-gnatw.g': [
         """Warnings used for GNAT sources.""",
         """
This switch sets the warning categories that are used by the standard GNAT style. Currently this is equivalent to -gnatwAao.q.s.CI.V.X.Z but more warnings may be added in the future without advanced notice.
"""],
    '-gnatwh': [
         """Activate warnings on hiding.""",
         """
This switch activates warnings on hiding declarations that are considered potentially confusing. Not all cases of hiding cause warnings; for example an overriding declaration hides an implicit declaration, which is just normal code. The default is that warnings on hiding are not generated.
"""],
    '-gnatwH': [
         """Suppress warnings on hiding.""",
         """
This switch suppresses warnings on hiding declarations.
"""],
    '-gnatw.h': [
         """Activate warnings on holes/gaps in records.""",
         """
This switch activates warnings on component clauses in record representation clauses that leave holes (gaps) in the record layout. If this warning option is active, then record representation clauses should specify a contiguous layout, adding unused fill fields if needed.
"""],
    '-gnatw.H': [
         """Suppress warnings on holes/gaps in records.""",
         """
This switch suppresses warnings on component clauses in record representation clauses that leave holes (haps) in the record layout.
"""],
    '-gnatwi': [
         """Activate warnings on implementation units.""",
         """
This switch activates warnings for a |with| of an internal GNAT implementation unit, defined as any unit from the ``Ada``, ``Interfaces``, ``GNAT``, or ``System`` hierarchies that is not documented in either the Ada Reference Manual or the GNAT Programmer's Reference Manual. Such units are intended only for internal implementation purposes and should not be |withed| by user programs. The default is that such warnings are generated
"""],
    '-gnatwI': [
         """Disable warnings on implementation units.""",
         """
This switch disables warnings for a |with| of an internal GNAT implementation unit.
"""],
    '-gnatw.i': [
         """Activate warnings on overlapping actuals.""",
         """
This switch enables a warning on statically detectable overlapping actuals in a subprogram call, when one of the actuals is an in-out parameter, and the types of the actuals are not by-copy types. This warning is off by default.
"""],
    '-gnatw.I': [
         """Disable warnings on overlapping actuals.""",
         """
This switch disables warnings on overlapping actuals in a call..
"""],
    '-gnatwj': [
         """Activate warnings on obsolescent features (Annex J).""",
         """
If this warning option is activated, then warnings are generated for calls to subprograms marked with ``pragma Obsolescent`` and for use of features in Annex J of the Ada Reference Manual. In the case of Annex J, not all features are flagged. In particular use of the renamed packages (like ``Text_IO``) and use of package ``ASCII`` are not flagged, since these are very common and would generate many annoying positive warnings. The default is that such warnings are not generated. 
In addition to the above cases, warnings are also generated for GNAT features that have been provided in past versions but which have been superseded (typically by features in the new Ada standard). For example, ``pragma Ravenscar`` will be flagged since its function is replaced by ``pragma Profile(Ravenscar)``, and ``pragma Interface_Name`` will be flagged since its function is replaced by ``pragma Import``. 
Note that this warning option functions differently from the restriction ``No_Obsolescent_Features`` in two respects. First, the restriction applies only to annex J features. Second, the restriction does flag uses of package ``ASCII``.
"""],
    '-gnatwJ': [
         """Suppress warnings on obsolescent features (Annex J).""",
         """
This switch disables warnings on use of obsolescent features.
"""],
    '-gnatw.j': [
         """Activate warnings on late declarations of tagged type primitives.""",
         """
This switch activates warnings on visible primitives added to a tagged type after deriving a private extension from it.
"""],
    '-gnatw.J': [
         """Suppress warnings on late declarations of tagged type primitives.""",
         """
This switch suppresses warnings on visible primitives added to a tagged type after deriving a private extension from it.
"""],
    '-gnatwk': [
         """Activate warnings on variables that could be constants.""",
         """
This switch activates warnings for variables that are initialized but never modified, and then could be declared constants. The default is that such warnings are not given.
"""],
    '-gnatwK': [
         """Suppress warnings on variables that could be constants.""",
         """
This switch disables warnings on variables that could be declared constants.
"""],
    '-gnatw.k': [
         """Activate warnings on redefinition of names in standard.""",
         """
This switch activates warnings for declarations that declare a name that is defined in package Standard. Such declarations can be confusing, especially since the names in package Standard continue to be directly visible, meaning that use visibiliy on such redeclared names does not work as expected. Names of discriminants and components in records are not included in this check.
"""],
    '-gnatw.K': [
         """Suppress warnings on redefinition of names in standard.""",
         """
This switch activates warnings for declarations that declare a name that is defined in package Standard.
"""],
    '-gnatwl': [
         """Activate warnings for elaboration pragmas.""",
         """
This switch activates warnings for possible elaboration problems, including suspicious use of ``Elaborate`` pragmas, when using the static elaboration model, and possible situations that may raise ``Program_Error`` when using the dynamic elaboration model. See the section in this guide on elaboration checking for further details. The default is that such warnings are not generated.
"""],
    '-gnatwL': [
         """Suppress warnings for elaboration pragmas.""",
         """
This switch suppresses warnings for possible elaboration problems.
"""],
    '-gnatw.l': [
         """List inherited aspects.""",
         """
This switch causes the compiler to list inherited invariants, preconditions, and postconditions from Type_Invariant'Class, Invariant'Class, Pre'Class, and Post'Class aspects. Also list inherited subtype predicates.
"""],
    '-gnatw.L': [
         """Suppress listing of inherited aspects.""",
         """
This switch suppresses listing of inherited aspects.
"""],
    '-gnatwm': [
         """Activate warnings on modified but unreferenced variables.""",
         """
This switch activates warnings for variables that are assigned (using an initialization value or with one or more assignment statements) but whose value is never read. The warning is suppressed for volatile variables and also for variables that are renamings of other variables or for which an address clause is given. The default is that these warnings are not given.
"""],
    '-gnatwM': [
         """Disable warnings on modified but unreferenced variables.""",
         """
This switch disables warnings for variables that are assigned or initialized, but never read.
"""],
    '-gnatw.m': [
         """Activate warnings on suspicious modulus values.""",
         """
This switch activates warnings for modulus values that seem suspicious. The cases caught are where the size is the same as the modulus (e.g. a modulus of 7 with a size of 7 bits), and modulus values of 32 or 64 with no size clause. The guess in both cases is that 2**x was intended rather than x. In addition expressions of the form 2*x for small x generate a warning (the almost certainly accurate guess being that 2**x was intended). The default is that these warnings are given.
"""],
    '-gnatw.M': [
         """Disable warnings on suspicious modulus values.""",
         """
This switch disables warnings for suspicious modulus values.
"""],
    '-gnatwn': [
         """Set normal warnings mode.""",
         """
This switch sets normal warning mode, in which enabled warnings are issued and treated as warnings rather than errors. This is the default mode. the switch -gnatwn can be used to cancel the effect of an explicit -gnatws or -gnatwe. It also cancels the effect of the implicit -gnatwe that is activated by the use of -gnatg.
"""],
    '-gnatw.n': [
         """Activate warnings on atomic synchronization.""",
         """
This switch actives warnings when an access to an atomic variable requires the generation of atomic synchronization code. These warnings are off by default.
"""],
    '-gnatw.N': [
         """Suppress warnings on atomic synchronization.""",
         """
This switch suppresses warnings when an access to an atomic variable requires the generation of atomic synchronization code.
"""],
    '-gnatwo': [
         """Activate warnings on address clause overlays.""",
         """
This switch activates warnings for possibly unintended initialization effects of defining address clauses that cause one variable to overlap another. The default is that such warnings are generated.
"""],
    '-gnatwO': [
         """Suppress warnings on address clause overlays.""",
         """
This switch suppresses warnings on possibly unintended initialization effects of defining address clauses that cause one variable to overlap another.
"""],
    '-gnatw.o': [
         """Activate warnings on modified but unreferenced out parameters.""",
         """
This switch activates warnings for variables that are modified by using them as actuals for a call to a procedure with an out mode formal, where the resulting assigned value is never read. It is applicable in the case where there is more than one out mode formal. If there is only one out mode formal, the warning is issued by default (controlled by -gnatwu). The warning is suppressed for volatile variables and also for variables that are renamings of other variables or for which an address clause is given. The default is that these warnings are not given.
"""],
    '-gnatw.O': [
         """Disable warnings on modified but unreferenced out parameters.""",
         """
This switch suppresses warnings for variables that are modified by using them as actuals for a call to a procedure with an out mode formal, where the resulting assigned value is never read.
"""],
    '-gnatwp': [
         """Activate warnings on ineffective pragma Inlines.""",
         """
This switch activates warnings for failure of front end inlining (activated by -gnatN) to inline a particular call. There are many reasons for not being able to inline a call, including most commonly that the call is too complex to inline. The default is that such warnings are not given. Warnings on ineffective inlining by the gcc back-end can be activated separately, using the gcc switch -Winline.
"""],
    '-gnatwP': [
         """Suppress warnings on ineffective pragma Inlines.""",
         """
This switch suppresses warnings on ineffective pragma Inlines. If the inlining mechanism cannot inline a call, it will simply ignore the request silently.
"""],
    '-gnatw.p': [
         """Activate warnings on parameter ordering.""",
         """
This switch activates warnings for cases of suspicious parameter ordering when the list of arguments are all simple identifiers that match the names of the formals, but are in a different order. The warning is suppressed if any use of named parameter notation is used, so this is the appropriate way to suppress a false positive (and serves to emphasize that the "misordering" is deliberate). The default is that such warnings are not given.
"""],
    '-gnatw.P': [
         """Suppress warnings on parameter ordering.""",
         """
This switch suppresses warnings on cases of suspicious parameter ordering.
"""],
    '-gnatwq': [
         """Activate warnings on questionable missing parentheses.""",
         """
This switch activates warnings for cases where parentheses are not used and the result is potential ambiguity from a readers point of view. For example (not a &gt; b) when a and b are modular means ((not a) &gt; b) and very likely the programmer intended (not (a &gt; b)). Similarly (-x mod 5) means (-(x mod 5)) and quite likely ((-x) mod 5) was intended. In such situations it seems best to follow the rule of always parenthesizing to make the association clear, and this warning switch warns if such parentheses are not present. The default is that these warnings are given.
"""],
    '-gnatwQ': [
         """Suppress warnings on questionable missing parentheses.""",
         """
This switch suppresses warnings for cases where the association is not clear and the use of parentheses is preferred.
"""],
    '-gnatw.q': [
         """Activate warnings on questionable layout of record types.""",
         """
This switch activates warnings for cases where the default layout of a record type, that is to say the layout of its components in textual order of the source code, would very likely cause inefficiencies in the code generated by the compiler, both in terms of space and speed during execution. One warning is issued for each problematic component without representation clause in the nonvariant part and then in each variant recursively, if any. 
The purpose of these warnings is neither to prescribe an optimal layout nor to force the use of representation clauses, but rather to get rid of the most blatant inefficiencies in the layout. Therefore, the default layout is matched against the following synthetic ordered layout and the deviations are flagged on a component-by-component basis: 
* first all components or groups of components whose length is fixed and a multiple of the storage unit, 
* then the remaining components whose length is fixed and not a multiple of the storage unit, 
* then the remaining components whose length doesn't depend on discriminants (that is to say, with variable but uniform length for all objects), 
* then all components whose length depends on discriminants, 
* finally the variant part (if any), 
for the nonvariant part and for each variant recursively, if any. 
The exact wording of the warning depends on whether the compiler is allowed to reorder the components in the record type or precluded from doing it by means of pragma ``No_Component_Reordering``. 
The default is that these warnings are not given.
"""],
    '-gnatw.Q': [
         """Suppress warnings on questionable layout of record types.""",
         """
This switch suppresses warnings for cases where the default layout of a record type would very likely cause inefficiencies.
"""],
    '-gnatwr': [
         """Activate warnings on redundant constructs.""",
         """
This switch activates warnings for redundant constructs. The following is the current list of constructs regarded as redundant: 
* Assignment of an item to itself. 
* Type conversion that converts an expression to its own type. 
* Use of the attribute ``Base`` where ``typ'Base`` is the same as ``typ``. 
* Use of pragma ``Pack`` when all components are placed by a record representation clause. 
* Exception handler containing only a reraise statement (raise with no operand) which has no effect. 
* Use of the operator abs on an operand that is known at compile time to be non-negative 
* Comparison of an object or (unary or binary) operation of boolean type to an explicit True value. 
The default is that warnings for redundant constructs are not given.
"""],
    '-gnatwR': [
         """Suppress warnings on redundant constructs.""",
         """
This switch suppresses warnings for redundant constructs.
"""],
    '-gnatw.r': [
         """Activate warnings for object renaming function.""",
         """
This switch activates warnings for an object renaming that renames a function call, which is equivalent to a constant declaration (as opposed to renaming the function itself).  The default is that these warnings are given.
"""],
    '-gnatw.R': [
         """Suppress warnings for object renaming function.""",
         """
This switch suppresses warnings for object renaming function.
"""],
    '-gnatws': [
         """Suppress all warnings.""",
         """
This switch completely suppresses the output of all warning messages from the GNAT front end, including both warnings that can be controlled by switches described in this section, and those that are normally given unconditionally. The effect of this suppress action can only be cancelled by a subsequent use of the switch -gnatwn. 
Note that switch -gnatws does not suppress warnings from the ``gcc`` back end. To suppress these back end warnings as well, use the switch -w in addition to -gnatws. Also this switch has no effect on the handling of style check messages.
"""],
    '-gnatw.s': [
         """Activate warnings on overridden size clauses.""",
         """
This switch activates warnings on component clauses in record representation clauses where the length given overrides that specified by an explicit size clause for the component type. A warning is similarly given in the array case if a specified component size overrides an explicit size clause for the array component type.
"""],
    '-gnatw.S': [
         """Suppress warnings on overridden size clauses.""",
         """
This switch suppresses warnings on component clauses in record representation clauses that override size clauses, and similar warnings when an array component size overrides a size clause.
"""],
    '-gnatwt': [
         """Activate warnings for tracking of deleted conditional code.""",
         """
This switch activates warnings for tracking of code in conditionals (IF and CASE statements) that is detected to be dead code which cannot be executed, and which is removed by the front end. This warning is off by default. This may be useful for detecting deactivated code in certified applications.
"""],
    '-gnatwT': [
         """Suppress warnings for tracking of deleted conditional code.""",
         """
This switch suppresses warnings for tracking of deleted conditional code.
"""],
    '-gnatw.t': [
         """Activate warnings on suspicious contracts.""",
         """
This switch activates warnings on suspicious contracts. This includes warnings on suspicious postconditions (whether a pragma ``Postcondition`` or a ``Post`` aspect in Ada 2012) and suspicious contract cases (pragma or aspect ``Contract_Cases``). A function postcondition or contract case is suspicious when no postcondition or contract case for this function mentions the result of the function.  A procedure postcondition or contract case is suspicious when it only refers to the pre-state of the procedure, because in that case it should rather be expressed as a precondition. This switch also controls warnings on suspicious cases of expressions typically found in contracts like quantified expressions and uses of Update attribute. The default is that such warnings are generated.
"""],
    '-gnatw.T': [
         """Suppress warnings on suspicious contracts.""",
         """
This switch suppresses warnings on suspicious contracts.
"""],
    '-gnatwu': [
         """Activate warnings on unused entities.""",
         """
This switch activates warnings to be generated for entities that are declared but not referenced, and for units that are |withed| and not referenced. In the case of packages, a warning is also generated if no entities in the package are referenced. This means that if a with'ed package is referenced but the only references are in ``use`` clauses or ``renames`` declarations, a warning is still generated. A warning is also generated for a generic package that is |withed| but never instantiated. In the case where a package or subprogram body is compiled, and there is a |with| on the corresponding spec that is only referenced in the body, a warning is also generated, noting that the |with| can be moved to the body. The default is that such warnings are not generated. This switch also activates warnings on unreferenced formals (it includes the effect of -gnatwf).
"""],
    '-gnatwU': [
         """Suppress warnings on unused entities.""",
         """
This switch suppresses warnings for unused entities and packages. It also turns off warnings on unreferenced formals (and thus includes the effect of -gnatwF).
"""],
    '-gnatw.u': [
         """Activate warnings on unordered enumeration types.""",
         """
This switch causes enumeration types to be considered as conceptually unordered, unless an explicit pragma ``Ordered`` is given for the type. The effect is to generate warnings in clients that use explicit comparisons or subranges, since these constructs both treat objects of the type as ordered. (A client is defined as a unit that is other than the unit in which the type is declared, or its body or subunits.) Please refer to the description of pragma ``Ordered`` in the :title:`GNAT Reference Manual` for further details. The default is that such warnings are not generated.
"""],
    '-gnatw.U': [
         """Deactivate warnings on unordered enumeration types.""",
         """
This switch causes all enumeration types to be considered as ordered, so that no warnings are given for comparisons or subranges for any type.
"""],
    '-gnatwv': [
         """Activate warnings on unassigned variables.""",
         """
This switch activates warnings for access to variables which may not be properly initialized. The default is that such warnings are generated.
"""],
    '-gnatwV': [
         """Suppress warnings on unassigned variables.""",
         """
This switch suppresses warnings for access to variables which may not be properly initialized. For variables of a composite type, the warning can also be suppressed in Ada 2005 by using a default initialization with a box. For example, if Table is an array of records whose components are only partially uninitialized, then the following code: 

       Tab : Table := (others =&gt; &lt;&gt;);

  will suppress warnings on subsequent statements that access components
  of variable Tab.
"""],
    '-gnatw.v': [
         """Activate info messages for non-default bit order.""",
         """
This switch activates messages (labeled "info", they are not warnings, just informational messages) about the effects of non-default bit-order on records to which a component clause is applied. The effect of specifying non-default bit ordering is a bit subtle (and changed with Ada 2005), so these messages, which are given by default, are useful in understanding the exact consequences of using this feature.
"""],
    '-gnatw.V': [
         """Suppress info messages for non-default bit order.""",
         """
This switch suppresses information messages for the effects of specifying non-default bit order on record components with component clauses.
"""],
    '-gnatww': [
         """Activate warnings on wrong low bound assumption.""",
         """
This switch activates warnings for indexing an unconstrained string parameter with a literal or S'Length. This is a case where the code is assuming that the low bound is one, which is in general not true (for example when a slice is passed). The default is that such warnings are generated.
"""],
    '-gnatwW': [
         """Suppress warnings on wrong low bound assumption.""",
         """
This switch suppresses warnings for indexing an unconstrained string parameter with a literal or S'Length. Note that this warning can also be suppressed in a particular case by adding an assertion that the lower bound is 1, as shown in the following example: 

       procedure K (S : String) is
          pragma Assert (S'First = 1);
          ...
"""],
    '-gnatw.w': [
         """Activate warnings on Warnings Off pragmas.""",
         """
This switch activates warnings for use of ``pragma Warnings (Off, entity)`` where either the pragma is entirely useless (because it suppresses no warnings), or it could be replaced by ``pragma Unreferenced`` or ``pragma Unmodified``. Also activates warnings for the case of Warnings (Off, String), where either there is no matching Warnings (On, String), or the Warnings (Off) did not suppress any warning. The default is that these warnings are not given.
"""],
    '-gnatw.W': [
         """Suppress warnings on unnecessary Warnings Off pragmas.""",
         """
This switch suppresses warnings for use of ``pragma Warnings (Off, ...)``.
"""],
    '-gnatwx': [
         """Activate warnings on Export/Import pragmas.""",
         """
This switch activates warnings on Export/Import pragmas when the compiler detects a possible conflict between the Ada and foreign language calling sequences. For example, the use of default parameters in a convention C procedure is dubious because the C compiler cannot supply the proper default, so a warning is issued. The default is that such warnings are generated.
"""],
    '-gnatwX': [
         """Suppress warnings on Export/Import pragmas.""",
         """
This switch suppresses warnings on Export/Import pragmas. The sense of this is that you are telling the compiler that you know what you are doing in writing the pragma, and it should not complain at you.
"""],
    '-gnatw.x': [
         """Activate warnings for No_Exception_Propagation mode.""",
         """
This switch activates warnings for exception usage when pragma Restrictions (No_Exception_Propagation) is in effect. Warnings are given for implicit or explicit exception raises which are not covered by a local handler, and for exception handlers which do not cover a local raise. The default is that these warnings are given for units that contain exception handlers.
"""],
    '-gnatw.X': [
         """Disable warnings for No_Exception_Propagation mode.""",
         """
This switch disables warnings for exception usage when pragma Restrictions (No_Exception_Propagation) is in effect.
"""],
    '-gnatwy': [
         """Activate warnings for Ada compatibility issues.""",
         """
For the most part, newer versions of Ada are upwards compatible with older versions. For example, Ada 2005 programs will almost always work when compiled as Ada 2012. However there are some exceptions (for example the fact that ``some`` is now a reserved word in Ada 2012). This switch activates several warnings to help in identifying and correcting such incompatibilities. The default is that these warnings are generated. Note that at one point Ada 2005 was called Ada 0Y, hence the choice of character.
"""],
    '-gnatwY': [
         """Disable warnings for Ada compatibility issues.""",
         """
This switch suppresses the warnings intended to help in identifying incompatibilities between Ada language versions.
"""],
    '-gnatw.y': [
         """Activate information messages for why package spec needs body.""",
         """
There are a number of cases in which a package spec needs a body. For example, the use of pragma Elaborate_Body, or the declaration of a procedure specification requiring a completion. This switch causes information messages to be output showing why a package specification requires a body. This can be useful in the case of a large package specification which is unexpectedly requiring a body. The default is that such information messages are not output.
"""],
    '-gnatw.Y': [
         """Disable information messages for why package spec needs body.""",
         """
This switch suppresses the output of information messages showing why a package specification needs a body.
"""],
    '-gnatwz': [
         """Activate warnings on unchecked conversions.""",
         """
This switch activates warnings for unchecked conversions where the types are known at compile time to have different sizes. The default is that such warnings are generated. Warnings are also generated for subprogram pointers with different conventions.
"""],
    '-gnatwZ': [
         """Suppress warnings on unchecked conversions.""",
         """
This switch suppresses warnings for unchecked conversions where the types are known at compile time to have different sizes or conventions.
"""],
    '-gnatw.z': [
         """Activate warnings for size not a multiple of alignment.""",
         """
This switch activates warnings for cases of record types with specified ``Size`` and ``Alignment`` attributes where the size is not a multiple of the alignment, resulting in an object size that is greater than the specified size. The default is that such warnings are generated.
"""],
    '-gnatw.Z': [
         """Suppress warnings for size not a multiple of alignment.""",
         """
This switch suppresses warnings for cases of record types with specified ``Size`` and ``Alignment`` attributes where the size is not a multiple of the alignment, resulting in an object size that is greater than the specified size. The warning can also be suppressed by giving an explicit ``Object_Size`` value.
"""],
    '-gnatVa': [
         """All validity checks.""",
         """
All validity checks are turned on. That is, -gnatVa is equivalent to ``gnatVcdfimorst``.
"""],
    '-gnatVc': [
         """Validity checks for copies.""",
         """
The right hand side of assignments, and the initializing values of object declarations are validity checked.
"""],
    '-gnatVd': [
         """Default (RM) validity checks.""",
         """
Some validity checks are done by default following normal Ada semantics (RM 13.9.1 (9-11)). A check is done in case statements that the expression is within the range of the subtype. If it is not, Constraint_Error is raised. For assignments to array components, a check is done that the expression used as index is within the range. If it is not, Constraint_Error is raised. Both these validity checks may be turned off using switch -gnatVD. They are turned on by default. If -gnatVD is specified, a subsequent switch -gnatVd will leave the checks turned on. Switch -gnatVD should be used only if you are sure that all such expressions have valid values. If you use this switch and invalid values are present, then the program is erroneous, and wild jumps or memory overwriting may occur.
"""],
    '-gnatVe': [
         """Validity checks for elementary components.""",
         """
In the absence of this switch, assignments to record or array components are not validity checked, even if validity checks for assignments generally (-gnatVc) are turned on. In Ada, assignment of composite values do not require valid data, but assignment of individual components does. So for example, there is a difference between copying the elements of an array with a slice assignment, compared to assigning element by element in a loop. This switch allows you to turn off validity checking for components, even when they are assigned component by component.
"""],
    '-gnatVf': [
         """Validity checks for floating-point values.""",
         """
In the absence of this switch, validity checking occurs only for discrete values. If -gnatVf is specified, then validity checking also applies for floating-point values, and NaNs and infinities are considered invalid, as well as out of range values for constrained types. Note that this means that standard IEEE infinity mode is not allowed. The exact contexts in which floating-point values are checked depends on the setting of other options. For example, -gnatVif or -gnatVfi (the order does not matter) specifies that floating-point parameters of mode ``in`` should be validity checked.
"""],
    '-gnatVi': [
         """Validity checks for ``in`` mode parameters.""",
         """
Arguments for parameters of mode ``in`` are validity checked in function and procedure calls at the point of call.
"""],
    '-gnatVm': [
         """Validity checks for ``in out`` mode parameters.""",
         """
Arguments for parameters of mode ``in out`` are validity checked in procedure calls at the point of call. The ``'m'`` here stands for modify, since this concerns parameters that can be modified by the call. Note that there is no specific option to test ``out`` parameters, but any reference within the subprogram will be tested in the usual manner, and if an invalid value is copied back, any reference to it will be subject to validity checking.
"""],
    '-gnatVn': [
         """No validity checks.""",
         """
This switch turns off all validity checking, including the default checking for case statements and left hand side subscripts. Note that the use of the switch -gnatp suppresses all run-time checks, including validity checks, and thus implies -gnatVn. When this switch is used, it cancels any other -gnatV previously issued.
"""],
    '-gnatVo': [
         """Validity checks for operator and attribute operands.""",
         """
Arguments for predefined operators and attributes are validity checked. This includes all operators in package ``Standard``, the shift operators defined as intrinsic in package ``Interfaces`` and operands for attributes such as ``Pos``. Checks are also made on individual component values for composite comparisons, and on the expressions in type conversions and qualified expressions. Checks are also made on explicit ranges using :samp:`..` (e.g., slices, loops etc).
"""],
    '-gnatVp': [
         """Validity checks for parameters.""",
         """
This controls the treatment of parameters within a subprogram (as opposed to -gnatVi and -gnatVm which control validity testing of parameters on a call. If either of these call options is used, then normally an assumption is made within a subprogram that the input arguments have been validity checking at the point of call, and do not need checking again within a subprogram). If -gnatVp is set, then this assumption is not made, and parameters are not assumed to be valid, so their validity will be checked (or rechecked) within the subprogram.
"""],
    '-gnatVr': [
         """Validity checks for function returns.""",
         """
The expression in ``return`` statements in functions is validity checked.
"""],
    '-gnatVs': [
         """Validity checks for subscripts.""",
         """
All subscripts expressions are checked for validity, whether they appear on the right side or left side (in default mode only left side subscripts are validity checked).
"""],
    '-gnatVt': [
         """Validity checks for tests.""",
         """
Expressions used as conditions in ``if``, ``while`` or ``exit`` statements are checked, as well as guard expressions in entry calls. 

The -gnatV switch may be followed by a string of letters to turn on a series of validity checking options. For example, -gnatVcr specifies that in addition to the default validity checking, copies and function return expressions are to be validity checked. In order to make it easier to specify the desired combination of effects, the upper case letters ``CDFIMORST`` may be used to turn off the corresponding lower case option. Thus -gnatVaM turns on all validity checking options except for checking of ``in out`` parameters. 
The specification of additional validity checking generates extra code (and in the case of -gnatVa the code expansion can be substantial). However, these additional checks can be very useful in detecting uninitialized variables, incorrect use of unchecked conversion, and other errors leading to invalid values. The use of pragma ``Initialize_Scalars`` is useful in conjunction with the extra validity checking, since this ensures that wherever possible uninitialized variables have invalid values. 
See also the pragma ``Validity_Checks`` which allows modification of the validity checking mode at the program source level, and also allows for temporary disabling of validity checks.
"""],
    '-gnaty0': [
         """Specify indentation level.""",
         """
If a digit from 1-9 appears in the string after -gnaty then proper indentation is checked, with the digit indicating the indentation level required. A value of zero turns off this style check. The general style of required indentation is as specified by the examples in the Ada Reference Manual. Full line comments must be aligned with the ``--`` starting on a column that is a multiple of the alignment level, or they may be aligned the same way as the following non-blank line (this is useful when full line comments appear in the middle of a statement, or they may be aligned with the source line on the previous non-blank line.
"""],
    '-gnatya': [
         """Check attribute casing.""",
         """
Attribute names, including the case of keywords such as ``digits`` used as attributes names, must be written in mixed case, that is, the initial letter and any letter following an underscore must be uppercase. All other letters must be lowercase.
"""],
    '-gnatyA': [
         """Use of array index numbers in array attributes.""",
         """
When using the array attributes First, Last, Range, or Length, the index number must be omitted for one-dimensional arrays and is required for multi-dimensional arrays.
"""],
    '-gnatyb': [
         """Blanks not allowed at statement end.""",
         """
Trailing blanks are not allowed at the end of statements. The purpose of this rule, together with h (no horizontal tabs), is to enforce a canonical format for the use of blanks to separate source tokens.
"""],
    '-gnatyB': [
         """Check Boolean operators.""",
         """
The use of AND/OR operators is not permitted except in the cases of modular operands, array operands, and simple stand-alone boolean variables or boolean constants. In all other cases ``and then``/`or else` are required.
"""],
    '-gnatyc': [
         """Check comments, double space.""",
         """
Comments must meet the following set of rules: 
* The ``--`` that starts the column must either start in column one, or else at least one blank must precede this sequence. 
* Comments that follow other tokens on a line must have at least one blank following the ``--`` at the start of the comment. 
* Full line comments must have at least two blanks following the ``--`` that starts the comment, with the following exceptions. 
* A line consisting only of the ``--`` characters, possibly preceded by blanks is permitted. 
* A comment starting with ``--x`` where ``x`` is a special character is permitted. This allows proper processing of the output from specialized tools such as ``gnatprep`` (where ``--!`` is used) and in earlier versions of the SPARK annotation language (where ``--#`` is used). For the purposes of this rule, a special character is defined as being in one of the ASCII ranges ``16#21#...16#2F#`` or ``16#3A#...16#3F#``. Note that this usage is not permitted in GNAT implementation units (i.e., when -gnatg is used). 
* A line consisting entirely of minus signs, possibly preceded by blanks, is permitted. This allows the construction of box comments where lines of minus signs are used to form the top and bottom of the box. 
* A comment that starts and ends with ``--`` is permitted as long as at least one blank follows the initial ``--``. Together with the preceding rule, this allows the construction of box comments, as shown in the following example: 

       ---------------------------
       -- This is a box comment --
       -- with two text lines.  --
       ---------------------------
"""],
    '-gnatyC': [
         """Check comments, single space.""",
         """
This is identical to ``c`` except that only one space is required following the ``--`` of a comment instead of two.
"""],
    '-gnatyd': [
         """Check no DOS line terminators present.""",
         """
All lines must be terminated by a single ASCII.LF character (in particular the DOS line terminator sequence CR/LF is not allowed).
"""],
    '-gnatye': [
         """Check end/exit labels.""",
         """
Optional labels on ``end`` statements ending subprograms and on ``exit`` statements exiting named loops, are required to be present.
"""],
    '-gnatyf': [
         """No form feeds or vertical tabs.""",
         """
Neither form feeds nor vertical tab characters are permitted in the source text.
"""],
    '-gnatyg': [
         """GNAT style mode.""",
         """
The set of style check switches is set to match that used by the GNAT sources. This may be useful when developing code that is eventually intended to be incorporated into GNAT. Currently this is equivalent to -gnatwydISux) but additional style switches may be added to this set in the future without advance notice.
"""],
    '-gnatyh': [
         """No horizontal tabs.""",
         """
Horizontal tab characters are not permitted in the source text. Together with the b (no blanks at end of line) check, this enforces a canonical form for the use of blanks to separate source tokens.
"""],
    '-gnatyi': [
         """Check if-then layout.""",
         """
The keyword ``then`` must appear either on the same line as corresponding ``if``, or on a line on its own, lined up under the ``if``.
"""],
    '-gnatyI': [
         """check mode IN keywords.""",
         """
Mode ``in`` (the default mode) is not allowed to be given explicitly. ``in out`` is fine, but not ``in`` on its own.
"""],
    '-gnatyk': [
         """Check keyword casing.""",
         """
All keywords must be in lower case (with the exception of keywords such as ``digits`` used as attribute names to which this check does not apply).
"""],
    '-gnatyl': [
         """Check layout.""",
         """
Layout of statement and declaration constructs must follow the recommendations in the Ada Reference Manual, as indicated by the form of the syntax rules. For example an ``else`` keyword must be lined up with the corresponding ``if`` keyword. 
There are two respects in which the style rule enforced by this check option are more liberal than those in the Ada Reference Manual. First in the case of record declarations, it is permissible to put the ``record`` keyword on the same line as the ``type`` keyword, and then the ``end`` in ``end record`` must line up under ``type``. This is also permitted when the type declaration is split on two lines. For example, any of the following three layouts is acceptable: 

    type q is record
       a : integer;
       b : integer;
    end record;

    type q is
       record
          a : integer;
          b : integer;
       end record;

    type q is
       record
          a : integer;
          b : integer;
    end record;

  Second, in the case of a block statement, a permitted alternative
  is to put the block label on the same line as the ``declare`` or
  ``begin`` keyword, and then line the ``end`` keyword up under
  the block label. For example both the following are permitted:


    Block : declare
       A : Integer := 3;
    begin
       Proc (A, A);
    end Block;

    Block :
       declare
          A : Integer := 3;
       begin
          Proc (A, A);
       end Block;

  The same alternative format is allowed for loops. For example, both of
  the following are permitted:


    Clear : while J &lt; 10 loop
       A (J) := 0;
    end loop Clear;

    Clear :
       while J &lt; 10 loop
          A (J) := 0;
       end loop Clear;
"""],
    '-gnatyL': [
         """Set maximum nesting level.""",
         """
The maximum level of nesting of constructs (including subprograms, loops, blocks, packages, and conditionals) may not exceed the given value nnn. A value of zero disconnects this style check.
"""],
    '-gnatym': [
         """Check maximum line length.""",
         """
The length of source lines must not exceed 79 characters, including any trailing blanks. The value of 79 allows convenient display on an 80 character wide device or window, allowing for possible special treatment of 80 character lines. Note that this count is of characters in the source text. This means that a tab character counts as one character in this count and a wide character sequence counts as a single character (however many bytes are needed in the encoding).
"""],
    '-gnatyM': [
         """Set maximum line length.""",
         """
The length of lines must not exceed the given value nnn. The maximum value that can be specified is 32767. If neither style option for setting the line length is used, then the default is 255. This also controls the maximum length of lexical elements, where the only restriction is that they must fit on a single line.
"""],
    '-gnatyn': [
         """Check casing of entities in Standard.""",
         """
Any identifier from Standard must be cased to match the presentation in the Ada Reference Manual (for example, ``Integer`` and ``ASCII.NUL``).
"""],
    '-gnatyN': [
         """Turn off all style checks.""",
         """
All style check options are turned off.
"""],
    '-gnatyo': [
         """Check order of subprogram bodies.""",
         """
All subprogram bodies in a given scope (e.g., a package body) must be in alphabetical order. The ordering rule uses normal Ada rules for comparing strings, ignoring casing of letters, except that if there is a trailing numeric suffix, then the value of this suffix is used in the ordering (e.g., Junk2 comes before Junk10).
"""],
    '-gnatyO': [
         """Check that overriding subprograms are explicitly marked as such.""",
         """
This applies to all subprograms of a derived type that override a primitive operation of the type, for both tagged and untagged types. In particular, the declaration of a primitive operation of a type extension that overrides an inherited operation must carry an overriding indicator. Another case is the declaration of a function that overrides a predefined operator (such as an equality operator).
"""],
    '-gnatyp': [
         """Check pragma casing.""",
         """
Pragma names must be written in mixed case, that is, the initial letter and any letter following an underscore must be uppercase. All other letters must be lowercase. An exception is that SPARK_Mode is allowed as an alternative for Spark_Mode.
"""],
    '-gnatyr': [
         """Check references.""",
         """
All identifier references must be cased in the same way as the corresponding declaration. No specific casing style is imposed on identifiers. The only requirement is for consistency of references with declarations.
"""],
    '-gnatys': [
         """Check separate specs.""",
         """
Separate declarations ('specs') are required for subprograms (a body is not allowed to serve as its own declaration). The only exception is that parameterless library level procedures are not required to have a separate declaration. This exception covers the most frequent form of main program procedures.
"""],
    '-gnatyS': [
         """Check no statements after then/else.""",
         """
No statements are allowed on the same line as a ``then`` or ``else`` keyword following the keyword in an ``if`` statement. ``or else`` and ``and then`` are not affected, and a special exception allows a pragma to appear after ``else``.
"""],
    '-gnatyt': [
         """Check token spacing.""",
         """
The following token spacing rules are enforced: 
* The keywords ``abs`` and ``not`` must be followed by a space. 
* The token ``=&gt;`` must be surrounded by spaces. 
* The token ``&lt;&gt;`` must be preceded by a space or a left parenthesis. 
 Binary operators other than ``*`` must be surrounded by spaces. There is no restriction on the layout of the ``**`` binary operator. 
* Colon must be surrounded by spaces. 
* Colon-equal (assignment, initialization) must be surrounded by spaces. 
* Comma must be the first non-blank character on the line, or be immediately preceded by a non-blank character, and must be followed by a space. 
* If the token preceding a left parenthesis ends with a letter or digit, then a space must separate the two tokens. 
* If the token following a right parenthesis starts with a letter or digit, then a space must separate the two tokens. 
* A right parenthesis must either be the first non-blank character on a line, or it must be preceded by a non-blank character. 
* A semicolon must not be preceded by a space, and must not be followed by a non-blank character. 
* A unary plus or minus may not be followed by a space. 
* A vertical bar must be surrounded by spaces. 
Exactly one blank (and no other white space) must appear between a ``not`` token and a following ``in`` token.
"""],
    '-gnatyu': [
         """Check unnecessary blank lines.""",
         """
Unnecessary blank lines are not allowed. A blank line is considered unnecessary if it appears at the end of the file, or if more than one blank line occurs in sequence.
"""],
    '-gnatyx': [
         """Check extra parentheses.""",
         """
Unnecessary extra level of parentheses (C-style) are not allowed around conditions in ``if`` statements, ``while`` statements and ``exit`` statements.
"""],
    '-gnatyy': [
         """Set all standard style check options.""",
         """
This is equivalent to ``gnaty3aAbcefhiklmnprst``, that is all checking options enabled with the exception of -gnatyB, -gnatyd, -gnatyI, -gnatyLnnn, -gnatyo, -gnatyO, -gnatyS, -gnatyu, and -gnatyx.
"""],
}
