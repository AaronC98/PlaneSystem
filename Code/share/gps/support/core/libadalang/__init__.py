##############################################################################
##                                                                          ##
##                                Libadalang                                ##
##                                                                          ##
##                     Copyright (C) 2014-2018, AdaCore                     ##
##                                                                          ##
## Libadalang is free software;  you can redistribute it and/or modify  it  ##
## under terms of the GNU General Public License  as published by the Free  ##
## Software Foundation;  either version 3,  or (at your option)  any later  ##
## version.   This  software  is distributed in the hope that it  will  be  ##
## useful but  WITHOUT ANY WARRANTY;  without even the implied warranty of  ##
## MERCHANTABILITY  or  FITNESS  FOR  A PARTICULAR PURPOSE.                 ##
##                                                                          ##
## As a special  exception  under  Section 7  of  GPL  version 3,  you are  ##
## granted additional  permissions described in the  GCC  Runtime  Library  ##
## Exception, version 3.1, as published by the Free Software Foundation.    ##
##                                                                          ##
## You should have received a copy of the GNU General Public License and a  ##
## copy of the GCC Runtime Library Exception along with this program;  see  ##
## the files COPYING3 and COPYING.RUNTIME respectively.  If not, see        ##
## <http://www.gnu.org/licenses/>.                                          ##
##############################################################################

"""
Python binding of the Libadalang API.

Please consider all exported entities whose names that start with an underscore
("_") as internal implementation details. They are not meant to be used
directly.
"""
from __future__ import (absolute_import, division, print_function,
                        unicode_literals)
import collections
import ctypes
import json
import os
import sys
#
# Low-level binding - First part
#
_so_ext = {
    'win32':  'dll',
    'darwin': 'dylib',
}.get(sys.platform, 'so')
# Loading the shared library here is quite involved as we want to support
# Python packages that embed all the required shared libraries: if we can
# find the shared library in the package directory, import it from there
# directly.
# Directory that contains this __init__.py module
_self_path = os.path.dirname(os.path.abspath(__file__))
# Base and full names for the shared library to load. Full name assumes the
# shared lib is in the package directory.
_c_lib_name = 'libadalang.{}'.format(_so_ext)
_c_lib_path = os.path.join(_self_path, _c_lib_name)
# If we can find the shared lirbray in the package directory, load it from
# here, otherwise let the dynamic loader find it in the environment. On
# Windows, there is no RPATH trick, so we need to temporarily alter the PATH
# environment variable in order to import the whole closure of DLLs.
_old_env_path = None
if os.path.exists(_c_lib_path):
    if sys.platform == 'win32':
        _old_env_path = os.environ['PATH']
        os.environ['PATH'] = '{}{}{}'.format(_self_path, os.path.pathsep,
                                             os.environ['PATH'])
else:
    _c_lib_path = _c_lib_name
# Finally load the library
_c_lib = ctypes.cdll.LoadLibrary(_c_lib_path)
# Restore the PATH environment variable if we altered it
if _old_env_path is not None:
    os.environ['PATH'] = _old_env_path
def _import_func(name, argtypes, restype, exc_wrap=True):
    """
    Import "name" from the C library, set its arguments/return types and return
    the binding.

    :param bool exc_wrap: If True, wrap the returned function to check for
      exceptions.
    """
    func = getattr(_c_lib, name)
    func.argtypes = argtypes
    func.restype = restype
    # Wrapper for "func" that raises a NativeException in case of internal
    # error.
    def wrapper(*args, **kwargs):
        result = func(*args, **kwargs)
        exc = _get_last_exception()
        if exc and exc.contents.is_fatal:
            raise exc.contents._wrap()
        return result
    return wrapper if exc_wrap else func
class _Exception(ctypes.Structure):
    _fields_ = [("is_fatal", ctypes.c_int),
                ("information", ctypes.c_char_p)]
    def _wrap(self):
        return NativeException(self.information)
def _raise_type_error(expected_type_name, actual_value):
    raise TypeError('{} instance expected, got {} instead'.format(
        expected_type_name, type(actual_value)
    ))
_get_last_exception = _import_func(
   'ada_get_last_exception',
   [], ctypes.POINTER(_Exception),
   exc_wrap=False
)
def _hashable_c_pointer(pointed_type=None):
    """
    Create a "pointer to `pointed_type` type and make it hashable.

    :param pointed_type: ctypes type class. If left to `None`, we return a
        subclass of `ctypes.c_void_p`.
    :rtype: ctypes.POINTER
    """
    if pointed_type is None:
        class _c_type(ctypes.c_void_p):
            @property
            def _pointer_value(self):
                return self.value or 0
    else:
        @property
        def _pointer_value(self):
            return ctypes.addressof(self.contents)
        _c_type = ctypes.POINTER(pointed_type)
        _c_type._pointer_value = _pointer_value
    def __hash__(self):
        return self._pointer_value
    def __eq__(self, other):
        return self._pointer_value == other._pointer_value
    def __ne__(self, other):
        return not (self == other)
    _c_type.__hash__ = __hash__
    _c_type.__eq__ = __eq__
    _c_type.__ne__ = __ne__
    return _c_type
class _text(ctypes.Structure):
    """
    C value for unicode strings. This object is the owner of the underlying
    buffer, so the string will be deallocated when ``self`` is destroyed.

    ``_unwrap`` takes a string/unicode object and returns a ``_text`` instance,
    while ``_wrap`` retuns an unicode instance.
    """
    # The chars field really is a uint32_t* but considering it as a char* here
    # is more convenient for conversion in this binding layer. On the other
    # side, we have to be careful about converting the length when retrieving
    # the chars.
    _fields_ = [("chars", ctypes.POINTER(ctypes.c_char)),
                ("length", ctypes.c_size_t),
                ("is_allocated", ctypes.c_int),]
    encoding = 'utf-32le' if sys.byteorder == 'little' else 'utf-32be'
    # Instances can hold buffers that they own. In this case, the buffer must
    # be deallocated when the instance is destroyed. Thus instances will hold
    # a "text_buffer" attribute that will be automatically destroyed.
    text_buffer = None
    @classmethod
    def _unwrap(cls, value):
        value = cls.cast(value)
        text = value.encode(cls.encoding)
        text_buffer = ctypes.create_string_buffer(text)
        text_buffer_ptr = ctypes.cast(
            ctypes.pointer(text_buffer),
            ctypes.POINTER(ctypes.c_char)
        )
        result = _text(text_buffer_ptr, len(value))
        result.text_buffer = text_buffer
        return result
    def _wrap(self):
        if self.length > 0:
            # self.length tells how much UTF-32 chars there are in self.chars
            # but self.chars is a char* so we have to fetch 4 times more bytes
            # than characters.
            return self.chars[:4 * self.length].decode(self.encoding)
        else:
            return None
    @classmethod
    def cast(cls, value):
        """
        Try to cast ``value`` into an unicode object. Raise a TypeError, or
        raise a string decoding error when this is not possible.
        """
        if isinstance(value, str):
            return value.decode('ascii')
        elif not isinstance(value, unicode):
            _raise_type_error('string or unicode', value)
        else:
            return value
    def __del__(self):
        _destroy_text(ctypes.byref(self))
class _symbol_type(ctypes.Structure):
    _fields_ = [('data', ctypes.c_void_p),
                ('bounds', ctypes.c_void_p)]
    @classmethod
    def wrap(cls, c_value):
        # First extract the text associated to this symbol in "text"
        text = _text()
        _symbol_text(ctypes.byref(c_value), ctypes.byref(text))
        # Then wrap this text
        return text._wrap()
    @classmethod
    def unwrap(cls, py_value, context):
        # First turn the given symbol into a low-level text object
        text = _text._unwrap(py_value)
        # Then convert it to a symbol
        result = cls()
        if not _context_symbol(context, ctypes.byref(text),
                               ctypes.byref(result)):
            raise InvalidSymbolError(py_value)
        return result
class _big_integer(object):
    class c_type(ctypes.c_void_p):
        pass
    def __init__(self, c_value):
        self.c_value = c_value
    @classmethod
    def unwrap(cls, value):
        if not isinstance(value, (int, long)):
            _raise_type_error('int or long', value)
        text = _text._unwrap(str(value))
        c_value = cls.create(ctypes.byref(text))
        return cls(c_value)
    @classmethod
    def wrap(cls, c_value):
        helper = cls(c_value)
        text = _text()
        cls.text(helper.c_value, ctypes.byref(text))
        return int(text._wrap())
    def clear(self):
        self.c_value = None
    def __del__(self):
        self.decref(self.c_value)
        self.clear()
    create = staticmethod(_import_func(
        'ada_create_big_integer',
        [ctypes.POINTER(_text)], c_type
    ))
    text = staticmethod(_import_func(
        'ada_big_integer_text',
        [c_type, ctypes.POINTER(_text)], None
    ))
    decref = staticmethod(_import_func(
        'ada_big_integer_decref',
        [c_type], None
    ))
class _Enum(object):
    name = None
    """
    Name for this enumeration type.
    :type: str
    """
    c_to_py = None
    """
    Mapping from C values to user-level Python values.
    :type: list[str]
    """
    py_to_c = None
    """
    Mapping from user-level Python values to C values.
    :type: dict[str, int]
    """
    @classmethod
    def _unwrap(cls, py_value):
        if not isinstance(py_value, basestring):
            raise TypeError('str expected but got {} instead'.format(
                type(py_value)))
        try:
            return cls.py_to_c[py_value]
        except KeyError:
            raise ValueError('Invalid {}: {}'.format(cls.name, py_value))
    @classmethod
    def _wrap(cls, c_value):
        if isinstance(c_value, ctypes.c_int):
            c_value = c_value.value
        return cls.c_to_py[c_value]
class AnalysisUnitKind(_Enum):
    """
    Specify a kind of analysis unit. Specification units provide an interface
    to the outer world while body units provide an implementation for the
    corresponding interface.
    """
    unit_specification = 'unit_specification'
    unit_body = 'unit_body'
    name = 'AnalysisUnitKind'
    c_to_py = [
        unit_specification, unit_body]
    py_to_c = {name: index for index, name in enumerate(c_to_py)}
class LookupKind(_Enum):
    recursive = 'recursive'
    flat = 'flat'
    minimal = 'minimal'
    name = 'LookupKind'
    c_to_py = [
        recursive, flat, minimal]
    py_to_c = {name: index for index, name in enumerate(c_to_py)}
_unit_provider = _hashable_c_pointer()
#
# High-level binding
#
class NativeException(Exception):
    """
    Exception raised when the underlying C API reports an error that occurred
    in the library.

    This kind of exception is raised for internal errors: they should never
    happen in normal situations and if they are raised at some point, it means
    the state is potentially corrupted.

    Nevertheless, the library does its best not to crash the program,
    materializing internal errors as Python exceptions.
    """
    pass
class InvalidUnitNameError(Exception):
    """
    Raised when an invalid unit name is provided.
    """
    pass
class PropertyError(Exception):
    """
    Exception that is raised when an error occurs while evaluating any AST node
    method whose name starts with ``p_``. This is the only exceptions that such
    functions can raise.
    """
    pass
class InvalidSymbolError(Exception):
    """
    Exception raise when an invalid symbol is passed to a subprogram.
    """
    pass
class StaleReferenceError(Exception):
    """
    Exception raised while trying to access data that was deallocated. This
    happens when one tries to use a node whose unit has been reparsed, for
    instance.
    """
    pass
class InvalidProjectError(Exception):
    """
    Raised when an error occurs while loading a project file.
    """
    pass
class AnalysisContext(object):
    """
    This type represents a context for all source analysis. This is the first
    type you need to create to use Libadalang. It will contain the results of
    all analysis, and is the main holder for all the data.

    You can create several analysis contexts if you need to, which enables you,
    for example to:

    - Analyze several different projects at the same time

    - Analyze different parts of the same projects in parallel

    In its current design, Libadalang will keep all the data it analyzes for-
    ever, so if you need to get memory back, the only option at your disposal
    is to destroy your ``Analysis_Context`` instance.
    """
    __slots__ = ('_c_value', '_unit_provider', '_serial_number', '_unit_cache')
    _context_cache = {}
    """
    Cache for analysis context wrappers. Indexed by anlysis context addresses,
    which are known to stay valid forever (and re-used).

    :type: dict[AnalysisContext._c_type, AnalysisContext]
    """
    def __init__(self,
                 charset=None,
                 unit_provider=None,
                 with_trivia=True,
                 tab_stop=8,
                 _c_value=None):
        """
        Create a new analysis context.

        ``Charset`` will be used as a default charset to decode input sources
        in analysis units. Please see ``GNATCOLL.Iconv`` for several supported
        charsets. Be careful: passing an unsupported charset is not guaranteed
        to raise an error here. If no charset is provided, ``"iso-8859-1"`` is
        the default.

        .. todo:: Passing an unsupported charset here is not guaranteed to
        raise an error right here, but this would be really helpful for users.

        When ``With_Trivia`` is true, the parsed analysis units will contain
        trivias.

        If provided, ``Unit_Provider`` will be used to query the file name that
        corresponds to a unit reference during semantic analysis. If it is
        ``None``, the default one is used instead.

        ``Tab_Stop`` is a positive number to describe the effect of tabulation
        characters on the column number in source files.
        """
        # Initialize this field in case we raise an exception during
        # construction, so that the destructor can run later on.
        self._c_value = None
        if _c_value is None:
            if not isinstance(tab_stop, int) or tab_stop < 1:
                raise ValueError(
                    'Invalid tab_stop (positive integer expected)')
            c_unit_provider = unit_provider._c_value if unit_provider else None
            self._c_value = _create_analysis_context(charset, c_unit_provider,
                                                     with_trivia, tab_stop)
        else:
            self._c_value = _context_incref(_c_value)
        assert self._c_value not in self._context_cache
        self._context_cache[self._c_value] = self
        # Keep a reference to the unit provider so that it is live at least as
        # long as the analysis context is live.
        self._unit_provider = unit_provider
        self._serial_number = None
        self._unit_cache = {}
        """
        Cache for AnalysisUnit wrappers, indexed by analysis unit addresses,
        which are known to stay valid as long as the context is alive.

        :type: dict[str, AnalysisUnit]
        """
        self._check_unit_cache()
    def __del__(self):
        if self._c_value:
            _context_decref(self._c_value)
    def __eq__(self, other):
        return self._c_value == other._c_value
    def __hash__(self):
        return hash(self._c_value)
    def get_from_file(self, filename, charset=None, reparse=False):
        """
        Create a new analysis unit for ``Filename`` or return the existing one
        if any. If ``Reparse`` is true and the analysis unit already exists,
        reparse it from ``Filename``.

        Use ``Charset`` in order to decode the source file. If ``Charset`` is
        empty then use the last charset used for this unit, or use the
        context's default if creating this unit.

        If any failure occurs, such as file opening, decoding, lexing or
        parsing failure, return an analysis unit anyway: errors are described
        as diagnostics of the returned analysis unit.
        """
        c_value = _get_analysis_unit_from_file(self._c_value, filename,
                                               charset or '', reparse)
        return AnalysisUnit._wrap(c_value)
    def get_from_buffer(self, filename, buffer, charset=None, reparse=False):
        """
        Create a new analysis unit for ``Filename`` or return the existing one
        if any. Whether the analysis unit already exists or not, (re)parse it
        from the source code in ``Buffer``.

        Use ``Charset`` in order to decode the source. If ``Charset`` is empty
        then use the last charset used for this unit, or use the context's
        default if creating this unit.

        If any failure occurs, such as file opening, decoding, lexing or
        parsing failure, return an analysis unit anyway: errors are described
        as diagnostics of the returned analysis unit.
        """
        c_value = _get_analysis_unit_from_buffer(self._c_value, filename,
                                                 charset or '',
                                                 buffer, len(buffer))
        return AnalysisUnit._wrap(c_value)
    def get_from_provider(self, name, kind, charset=None, reparse=False):
        """
        Create a new analysis unit for ``Name``/``Kind`` or return the existing
        one if any. If ``Reparse`` is true and the analysis unit already
        exists, reparse it from ``Filename``.

        Use ``Charset`` in order to decode the source. If ``Charset`` is empty
        then use the last charset used for this unit, or use the context's
        default if creating this unit.

        If the unit name cannot be tuned into a file name, raise an
        ``InvalidUnitNameError`` exception. If any other failure occurs, such
        as file opening, decoding, lexing or parsing failure, return an
        analysis unit anyway: errors are described as diagnostics of the
        returned analysis unit.
        """
        _name = _text._unwrap(name)
        _kind = AnalysisUnitKind._unwrap(kind)
        c_value = _get_analysis_unit_from_provider(
            self._c_value, ctypes.byref(_name), _kind, charset or '', reparse
        )
        if c_value:
            return AnalysisUnit._wrap(c_value)
        else:
            raise InvalidUnitNameError('Invalid unit name: {} ({})'.format(
                repr(name), kind
            ))
    def discard_errors_in_populate_lexical_env(self, discard):
        """
        Debug helper. Set whether ``Property_Error`` exceptions raised in
        ``Populate_Lexical_Env`` should be discarded. They are by default.
        """
        _discard_errors_in_populate_lexical_env(self._c_value, bool(discard))
    class _c_struct(ctypes.Structure):
        _fields_ = [('serial_number', ctypes.c_uint64)]
    _c_type = _hashable_c_pointer(_c_struct)
    @classmethod
    def _wrap(cls, c_value):
        try:
            return cls._context_cache[c_value]
        except KeyError:
            return cls(_c_value=c_value)
    def _check_unit_cache(self):
        """
        If this context has been re-used, invalidate its unit cache.
        """
        serial_number = self._c_value.contents.serial_number
        if self._serial_number != serial_number:
            self._unit_cache = {}
            self._serial_number = serial_number
class AnalysisUnit(object):
    """
    This type represents the analysis of a single file.
    """
    __slots__ = ('_c_value', '_context_link', '_cache_version_number',
                 '_node_cache')
    class DiagnosticsList(object):
        """List of analysis unit diagnostics."""
        def __init__(self, unit):
            self.unit = unit
        def __repr__(self):
            return 'DiagnosticsList({})'.format(repr(list(self)))
        def __len__(self):
            return _unit_diagnostic_count(self.unit._c_value)
        def __getitem__(self, key):
            if not isinstance(key, int):
                msg = 'list indices must be integers, not {}'.format(
                    type(key))
                raise TypeError(msg)
            diag = Diagnostic._c_type()
            success = _unit_diagnostic(self.unit._c_value, key,
                                       ctypes.byref(diag))
            if not success:
                raise IndexError('diagnostic index out of range')
            else:
                result = diag._wrap()
                return result
    class TokenIterator(object):
        """Iterator over the tokens in an analysis unit."""
        def __init__(self, first):
            self.first = first
        def __iter__(self):
            return self
        def next(self):
            if not self.first:
                raise StopIteration()
            result = self.first
            self.first = self.first.next
            return result
    def __init__(self, context, c_value):
        """
        This constructor is an implementation detail, and is not meant to be
        used directly. Please use AnalysisContext.get_from_* methods to create
        analysis unit instances instead.
        """
        self._c_value = c_value
        # Keep a reference on the owning context so that we keep it alive at
        # least as long as this unit is alive.
        self._context_link = context
        # Store this wrapper in caches for later re-use
        assert c_value not in context._unit_cache
        context._unit_cache[c_value] = self
        self._cache_version_number = None
        """
        Last version number we saw for this analysis unit wrapper. If it's
        different from `self._unit_version`, it means that the unit was
        reparsed: in this case we need to clear the node cache below (see the
        `_check_node_cache` method).

        :type: int
        """
        self._node_cache = {}
        """
        Cache for all node wrappers in this unit. Indexed by couples:
        (c_value, metadata, rebindings).

        :type: dict[T, AdaNode]
        """
        self._check_node_cache()
    def __eq__(self, other):
        return self._c_value == other._c_value
    def __hash__(self):
        return hash(self._c_value)
    @property
    def context(self):
        """
        Return the context that owns this unit.
        """
        return self._context_link
    def reparse(self, buffer=None, charset=None):
        """
        Reparse an analysis unit from a buffer, if provided, or from the
        original file otherwise. If ``Charset`` is empty or ``None``, use the
        last charset successfuly used for this unit, otherwise use it to decode
        the content of the source file.

        If any failure occurs, such as decoding, lexing or parsing failure,
        diagnostic are emitted to explain what happened.
        """
        if buffer is None:
            _unit_reparse_from_file(self._c_value, charset or '')
        else:
            _unit_reparse_from_buffer(self._c_value, charset or '',
                                      buffer, len(buffer))
    def populate_lexical_env(self):
        """
        Create lexical environments for this analysis unit, according to the
        specifications given in the language spec.

        If not done before, it will be automatically called during semantic
        analysis. Calling it before enables one to control where the latency
        occurs.

        Depending on whether errors are discarded (see
        ``Discard_Errors_In_Populate_Lexical_Env``), raise a ``Property_Error``
        on failure.
        """
        if not _unit_populate_lexical_env(self._c_value):
            exc = _get_last_exception()
            if exc:
                raise PropertyError(*exc.contents._wrap().args)
            else:
                raise PropertyError()
    @property
    def root(self):
        """
        Return the root node for this unit, or ``None`` if there is none.

        :rtype: AdaNode
        """
        result = _Entity_c_type()
        _unit_root(self._c_value, ctypes.byref(result))
        return AdaNode._wrap(result)
    @property
    def first_token(self):
        """
        Return a reference to the first token scanned in this unit.
        """
        result = Token()
        _unit_first_token(self._c_value, ctypes.byref(result))
        return result._wrap()
    @property
    def last_token(self):
        """
        Return a reference to the last token scanned in this unit.
        """
        result = Token()
        _unit_last_token(self._c_value, ctypes.byref(result))
        return result._wrap()
    @property
    def token_count(self):
        """
        Return the number of tokens in this unit.
        """
        return _unit_token_count(self._c_value)
    @property
    def trivia_count(self):
        """
        Return the number of trivias in this unit. This is 0 for units that
        were parsed with trivia analysis disabled.
        """
        return _unit_trivia_count(self._c_value)
    def lookup_token(self, sloc):
        """
        Look for a token in this unit that contains the given source location.
        If this falls before the first token, return the first token. If this
        falls between two tokens, return the token that appears before. If this
        falls after the last token, return the last token. If there is no token
        in this unit, return no token.
        """
        unit = AnalysisUnit._unwrap(self)
        _sloc = Sloc._c_type._unwrap(sloc)
        tok = Token()
        _unit_lookup_token(unit, ctypes.byref(_sloc), ctypes.byref(tok))
        return tok._wrap()
    def iter_tokens(self):
        """
        Return an iterator that yields all the tokens in this unit.
        """
        return self.TokenIterator(self.first_token)
    @property
    def filename(self):
        """
        Return the filename this unit is associated to.
        """
        filename = _unit_filename(self._c_value)
        return _unwrap_str(filename)
    @property
    def diagnostics(self):
        """Diagnostics for this unit."""
        return self.DiagnosticsList(self)
    def __repr__(self):
        return '<AnalysisUnit {}>'.format(repr(
            os.path.basename(self.filename)
        ))
    class _c_struct(ctypes.Structure):
        _fields_ = [('unit_version', ctypes.c_uint64)]
    _c_type = _hashable_c_pointer(_c_struct)
    @classmethod
    def _wrap(cls, c_value):
        if not c_value:
            return None
        # Invalidate the unit cache if needed, then look for an existing
        # wrapper for this unit.
        context = cls._context(c_value)
        context._check_unit_cache()
        try:
            return context._unit_cache[c_value]
        except KeyError:
            return cls(context, c_value)
    @classmethod
    def _unwrap(cls, value):
        if value is None:
            return value
        elif not isinstance(value, cls):
            _raise_type_error(cls.__name__, value)
        else:
            return value._c_value
    @classmethod
    def _context(cls, c_value):
        ctx = _unit_context(c_value)
        return AnalysisContext._wrap(ctx)
    @property
    def _unit_version(self):
        return self._c_value.contents.unit_version
    def _check_node_cache(self):
        """
        If this unit has been reparsed, invalidate its node cache.
        """
        if self._cache_version_number != self._unit_version:
            self._node_cache = {}
            self._cache_version_number = self._unit_version
class Sloc(object):
    """
    Location in a source file. Line and column numbers are one-based.
    """
    def __init__(self, line, column):
        assert line >= 0 and column >= 0
        self.line = line
        self.column = column
    def __nonzero__(self):
        return bool(self.line or self.column)
    def __lt__(self, other):
        # First compare line numbers...
        if self.line < other.line:
            return True
        elif self.line > other.line:
            return False
        # Past this point, we know that both are on the same line, so now
        # compare column numbers.
        else:
            return self.column < other.column
    def __eq__(self, other):
        return self.line == other.line and self.column == other.column
    def __hash__(self):
        return hash((self.line, self.column))
    def __str__(self):
        return '{}:{}'.format(self.line, self.column)
    def __repr__(self):
        return '<Sloc {} at {:#x}>'.format(self, id(self))
    class _c_type(ctypes.Structure):
        _fields_ = [("line", ctypes.c_uint32),
                    ("column", ctypes.c_uint16)]
        def _wrap(self):
            return Sloc(self.line, self.column)
        @classmethod
        def _unwrap(cls, sloc):
            return cls(sloc.line, sloc.column)
class SlocRange(object):
    """
    Location of a span of text in a source file.
    """
    def __init__(self, start, end):
        self.start = start
        self.end = end
    def __nonzero__(self):
        return bool(self.start or self.end)
    def __lt__(self, other):
        raise NotImplementedError('SlocRange comparison not supported')
    def __eq__(self, other):
        return self.start == other.start and self.end == other.end
    def __hash__(self):
        return hash((self.start, self.end))
    def __str__(self):
        return '{}-{}'.format(self.start, self.end)
    def __repr__(self):
        return "<SlocRange {}:{}-{}:{}>".format(
            self.start.line, self.start.column,
            self.end.line, self.end.column
        )
    class _c_type(ctypes.Structure):
        _fields_ = [("start", Sloc._c_type),
                    ("end", Sloc._c_type)]
        def _wrap(self):
            return SlocRange(self.start._wrap(), self.end._wrap())
class Diagnostic(object):
    """
    Diagnostic for an analysis unit: cannot open the source file, parsing
    error, ...
    """
    def __init__(self, sloc_range, message):
        self.sloc_range = sloc_range
        self.message = message
    def __str__(self):
        return ('{}: {}'.format(self.sloc_range, self.message)
                if self.sloc_range else
                self.message)
    def __repr__(self):
        return '<Diagnostic {} at {:#x}>'.format(repr(str(self)), id(self))
    class _c_type(ctypes.Structure):
        _fields_ = [("sloc_range", SlocRange._c_type),
                    ("message", _text)]
        def _wrap(self):
            return Diagnostic(self.sloc_range._wrap(), self.message._wrap())
class Token(ctypes.Structure):
    """
    Reference to a token in an analysis unit.
    """
    _tdh_c_type = _hashable_c_pointer()
    _fields_ = [('_token_data',   _tdh_c_type),
                ('_token_index',  ctypes.c_int),
                ('_trivia_index', ctypes.c_int),
                ('_kind',         ctypes.c_int),
                ('_text',         _text),
                ('_sloc_range',   SlocRange._c_type)]
    def _wrap(self):
        return self if self._token_data else None
    @property
    def next(self):
        """
        Return a reference to the next token in the corresponding analysis
        unit.
        """
        t = Token()
        _token_next(ctypes.byref(self), ctypes.byref(t))
        return t._wrap()
    @property
    def previous(self):
        """
        Return a reference to the previous token in the corresponding analysis
        unit.
        """
        t = Token()
        _token_previous(ctypes.byref(self), ctypes.byref(t))
        return t._wrap()
    def range_until(self, other):
        """
        Return an iterator on the list of tokens that spans between `self` and
        `other` (included). This returns an empty list if the first token
        appears after the other one in the source code. Raise a ``ValueError``
        if both tokens come from different analysis units.
        """
        if other is not None and self._token_data != other._token_data:
            raise ValueError('{} and {} come from different analysis'
                             ' units'.format(self, other))
        if other < self:
            return
        yield self
        current = self
        while current < other:
            current = current.next
            yield current
    def is_equivalent(self, other):
        """
        Return whether ``L`` and ``R`` are structurally equivalent tokens. This
        means that their position in the stream won't be taken into account,
        only the kind and text of the token.
        """
        return bool(_token_is_equivalent(
            ctypes.byref(self), ctypes.byref(other))
        )
    @property
    def kind(self):
        """
        Kind for this token.
        """
        name = _token_kind_name(self._kind)
        # The _token_kind_name wrapper is already supposed to handle exceptions
        # so this should always return a non-null value.
        assert name
        return _unwrap_str(name)
    @property
    def is_trivia(self):
        """
        Return whether this token is a trivia. If it's not, it's a regular
        token.
        """
        return self._trivia_index != 0
    @property
    def index(self):
        """
        Zero-based index for this token/trivia. Tokens and trivias get their
        own index space.
        """
        return (self._token_index - 1
                if self._trivia_index == 0 else
                self._trivia_index - 1)
    @property
    def text(self):
        """
        Return the text of the given token.
        """
        return self._text._wrap()
    @classmethod
    def text_range(cls, first, last):
        """
        Compute the source buffer slice corresponding to the text that spans
        between the ``First`` and ``Last`` tokens (both included). This yields
        an empty slice if ``Last`` actually appears before ``First``.

        This raises a ``ValueError`` if ``First`` and ``Last`` don't belong to
        the same analysis unit.
        """
        result = _text()
        if not _token_range_text(
            ctypes.byref(first), ctypes.byref(last),
            ctypes.byref(result)
        ):
            raise ValueError(
               "{} and {} don't belong to the same analysis unit".format(
                  first, last
               )
            )
        return result._wrap() or u''
    @property
    def sloc_range(self):
        """
        Return the source location range of the given token.
        """
        return self._sloc_range._wrap()
    def __eq__(self, other):
        """
        Return whether the two tokens refer to the same token in the same unit.

        Note that this does not actually compares the token data.
        """
        return (other is not None
                and self._identity_tuple == other._identity_tuple)
    def __hash__(self):
        return hash(self._identity_tuple)
    def __repr__(self):
        return '<Token {}{} at {}>'.format(
            self.kind,
            ' {}'.format(repr(self.text)) if self.text else '',
            self.sloc_range
        )
    def __lt__(self, other):
        """
        Consider that None comes before all tokens. Then, sort by unit, token
        index, and trivia index.
        """
        if other is None:
            return False
        if self._token_data != other._token_data:
            raise ValueError('{} and {} come from different units'.format(
                self, other
            ))
        return (other is not None
                and self._identity_tuple < other._identity_tuple)
    def to_data(self):
        """
        Return a dict representation of this Token.
        """
        return {"kind": "Token", "token_kind": self.kind, "text": self.text}
    @property
    def _identity_tuple(self):
        """
        Return a tuple that return a tuple that contains "identity" information
        for this token. Think of it as a database primary key.

        This property is for internal use only.
        """
        return (self._token_data, self._token_index, self._trivia_index)
class UnitProvider(object):
    """
    Interface to fetch analysis units from a name and a unit kind.

    This is used to make the semantic analysis able to switch from one analysis
    units to another.
    """
    def __init__(self, c_value):
        """
        This constructor is an implementation detail, and is not meant to be
        used directly.
        """
        self._c_value = c_value
    def __del__(self):
        _destroy_unit_provider(self._c_value)
    @classmethod
    def for_project(cls, project_file, scenario_vars=None, target=None,
                    runtime=None):
        """
        Load the project file at ``Project_File`` and return a unit provider
        that uses it.

        If provided, ``Scenario_Vars`` must be a dict with key strings and key
        values to describe the set of scenario variables for this project.

        In order to load the given project with non-default target and
        runtimes, pass these as strings to the ``target`` and ``runtime``
        arguments.

        If the requested project is invalid (error while opening the file,
        error while analysing its syntax, ...), this raises an
        ``InvalidProjectError`` exception.
        """
        # Here and below, acccept 'unicode' instances as well as 'str' ones:
        # ctypes will automatically take care of converting unicode instances
        # for C functions accepting c_char_p arguments. The behavior will be
        # the same as when using str-based API in standard Python modules
        # (encoding error if transcoding is not possible with default
        # encoding).
        if not isinstance(project_file, basestring):
            raise TypeError('`project_file` argument must be a string')
        for name, value in [('target', target), ('runtime', runtime)]:
            if value is not None and not isinstance(value, basestring):
                raise TypeError('`{}` argument must be a string'.format(name))
        if scenario_vars:
            items = scenario_vars.items()
            scn_vars_array_type = _project_scenario_variable * (len(items) + 1)
            scn_vars_array = scn_vars_array_type()
            for i, (name, value) in enumerate(items):
                if (not isinstance(name, basestring) or
                        not isinstance(value, basestring)):
                    raise TypeError('`scenario_vars` must be a dict mapping'
                                    ' strings to strings')
                scn_vars_array[i] = _project_scenario_variable(name, value)
            scn_vars_array[-1] = _project_scenario_variable(None, None)
        else:
            scn_vars_array = None
        c_value = _create_project_unit_provider(project_file, scn_vars_array,
                                                target, runtime)
        if c_value:
            return cls(c_value)
        else:
            raise InvalidProjectError(
                'Cannot open project {}'.format(project_file)
            )
    @classmethod
    def auto(cls, input_files, charset=None):
        """
        Return a unit provider that knows which compilation units are to be
        found in the given list of source files.

        This knowledge is built trying to parse all given input files as Ada
        source files and listing the compilation units found there. Files that
        cannot be parsed properly are discarded. If two compilation units are
        found for the same unit, the first that is found in the given input
        files is taken and the other ones are discarded.

        Source files are decoded using the given charset. If it is ``None``,
        the default charset (ISO-8859-1) is used.

        .. todo:: Find a way to report discarded source files/compilation
        units.
        """
        # Create a NULL-terminated array of strings
        c_strings = [ctypes.c_char_p(f) for f in input_files]
        c_array_type = ctypes.c_char_p * (len(input_files) + 1)
        c_array = c_array_type()
        for i, c_str in enumerate(c_strings):
            c_array[i] = c_str
        c_array[-1] = None
        c_array_ptr = ctypes.pointer(c_array)
        input_files_arg = ctypes.cast(c_array_ptr,
                                      ctypes.POINTER(ctypes.c_char_p))
        c_value = _create_auto_provider(input_files_arg, charset)
        return cls(c_value)
class AdaNode(object):
    """
    Root node class for the Ada syntax tree.
    """
    is_list_type = False
    __slots__ = ('_unprotected_c_value', '_node_c_value', '_metadata',
                 '_rebindings', '_unprotected_getitem_cache', '_unit',
                 '_unit_version')
    @property
    def parent(self):
        """
        Return the lexical parent for this node. Return null for the root AST
        node or for AST nodes for which no one has a reference to the parent.

        :rtype: AdaNode
        """
        c_result = self._eval_field(_Entity_c_type(), _ada_node_parent)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def parents(self):
        """
        Return an array that contains the lexical parents (this node included).
        Nearer parents are first in the list.

        :rtype: list[AdaNode]
        """
        c_result = self._eval_field(_AdaNodeArrayConverter.c_type(), _ada_node_parents)
        result = _AdaNodeArrayConverter.wrap(c_result)
        return result
    @property
    def children(self):
        """
        Return an array that contains the direct lexical children.

        :rtype: list[AdaNode]
        """
        c_result = self._eval_field(_AdaNodeArrayConverter.c_type(), _ada_node_children)
        result = _AdaNodeArrayConverter.wrap(c_result)
        return result
    @property
    def token_start(self):
        """
        Return the first token used to parse this node.

        :rtype: Token
        """
        c_result = self._eval_field(Token(), _ada_node_token_start)
        result = c_result
        return result
    @property
    def token_end(self):
        """
        Return the last token used to parse this node.

        :rtype: Token
        """
        c_result = self._eval_field(Token(), _ada_node_token_end)
        result = c_result
        return result
    @property
    def child_index(self):
        """
        Return the 0-based index for Node in its parent's children.

        :rtype: int
        """
        c_result = self._eval_field(ctypes.c_int(), _ada_node_child_index)
        result = c_result.value
        return result
    @property
    def previous_sibling(self):
        """
        Return the node's previous sibling, if there is one.

        :rtype: AdaNode
        """
        c_result = self._eval_field(_Entity_c_type(), _ada_node_previous_sibling)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def next_sibling(self):
        """
        Return the node's next sibling, if there is one.

        :rtype: AdaNode
        """
        c_result = self._eval_field(_Entity_c_type(), _ada_node_next_sibling)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def unit(self):
        """
        Return the analysis unit owning this node.

        :rtype: AnalysisUnit
        """
        c_result = self._eval_field(AnalysisUnit._c_type(), _ada_node_unit)
        result = AnalysisUnit._wrap(c_result)
        return result
    @property
    def is_ghost(self):
        """
        Return whether the node is a ghost node. In other words, return False
        if it corresponds to a real chain of tokens in the source, True
        otherwise.

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _ada_node_is_ghost)
        result = bool(c_result.value)
        return result
    @property
    def p_expression_type(self):
        """
        Return the declaration corresponding to the type of this expression
        after name resolution.

        :rtype: BaseTypeDecl
        """
        c_result = self._eval_field(_Entity_c_type(), _ada_node_p_expression_type)
        result = AdaNode._wrap(c_result)
        return result
    def p_referenced_decl(self, imprecise_fallback=False):
        """
        Return the declaration this node references after name resolution. If
        imprecise_fallback is True, errors raised during resolution of the xref
        equation are catched and a fallback mechanism is triggered, which tries
        to find the referenced declaration in an ad-hoc way.

        :rtype: BasicDecl
        """
        unwrapped_imprecise_fallback = bool(imprecise_fallback)
        c_result = self._eval_field(_Entity_c_type(), _ada_node_p_referenced_decl, unwrapped_imprecise_fallback)
        result = AdaNode._wrap(c_result)
        return result
    def p_xref(self, imprecise_fallback=False):
        """
        Return a cross reference from this node to a defining identifier.

        :rtype: DefiningName
        """
        unwrapped_imprecise_fallback = bool(imprecise_fallback)
        c_result = self._eval_field(_Entity_c_type(), _ada_node_p_xref, unwrapped_imprecise_fallback)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_complete(self):
        """
        Return possible completions at this point in the file.

        :rtype: list[BasicDecl]
        """
        c_result = self._eval_field(_AdaNodeArrayConverter.c_type(), _ada_node_p_complete)
        result = _AdaNodeArrayConverter.wrap(c_result)
        return result
    def p_referenced_decl_internal(self, try_immediate, imprecise_fallback=False):
        """
        Return the declaration this node references. Try not to run name res if
        already resolved. INTERNAL USE ONLY.

        :rtype: BasicDecl
        """
        unwrapped_try_immediate = bool(try_immediate)
        unwrapped_imprecise_fallback = bool(imprecise_fallback)
        c_result = self._eval_field(_Entity_c_type(), _ada_node_p_referenced_decl_internal, unwrapped_try_immediate, unwrapped_imprecise_fallback)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_generic_instantiations(self):
        """
        Return the potentially empty list of generic package/subprogram
        instantiations that led to the creation of this entity. Outer-most
        instantiations appear last.

        :rtype: list[GenericInstantiation]
        """
        c_result = self._eval_field(_AdaNodeArrayConverter.c_type(), _ada_node_p_generic_instantiations)
        result = _AdaNodeArrayConverter.wrap(c_result)
        return result
    @property
    def p_semantic_parent(self):
        """
        Return the semantic parent for this node, if applicable, null
        otherwise.

        :rtype: AdaNode
        """
        c_result = self._eval_field(_Entity_c_type(), _ada_node_p_semantic_parent)
        result = AdaNode._wrap(c_result)
        return result
    def p_filter_is_imported_by(self, units, transitive):
        """
        Filters out among the list of given units those that cannot refer to
        the unit in which this node lies. If transitive is True, the whole
        transitive closure of imports will be used to find a reference to the
        unit of this node.

        :rtype: list[AnalysisUnit]
        """
        unwrapped_units = _AnalysisUnitArrayConverter.unwrap(units)
        unwrapped_transitive = bool(transitive)
        c_result = self._eval_field(_AnalysisUnitArrayConverter.c_type(), _ada_node_p_filter_is_imported_by, unwrapped_units.c_value, unwrapped_transitive)
        result = _AnalysisUnitArrayConverter.wrap(c_result)
        return result
    @property
    def p_xref_entry_point(self):
        """
        Designates entities that are entry point for the xref solving
        infrastructure. If this returns true, then resolve_names can be called
        on it.

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _ada_node_p_xref_entry_point)
        result = bool(c_result.value)
        return result
    @property
    def p_resolve_names(self):
        """
        This will resolve names for this node. If the operation is successful,
        then type_var and ref_var will be bound on appropriate subnodes of the
        statement.

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _ada_node_p_resolve_names)
        result = bool(c_result.value)
        return result
    @property
    def p_body_unit(self):
        """
        If this unit has a body, fetch and return it.

        :rtype: AnalysisUnit
        """
        c_result = self._eval_field(AnalysisUnit._c_type(), _ada_node_p_body_unit)
        result = AnalysisUnit._wrap(c_result)
        return result
    @property
    def p_spec_unit(self):
        """
        If this unit has a spec, fetch and return it. Return the null analysis
        unit otherwise. Note that this returns null for specs, as they don't
        have another spec themselves.

        :rtype: AnalysisUnit
        """
        c_result = self._eval_field(AnalysisUnit._c_type(), _ada_node_p_spec_unit)
        result = AnalysisUnit._wrap(c_result)
        return result
    @property
    def p_standard_unit(self):
        """
        Static method. Return the analysis unit corresponding to the Standard
        package.

        :rtype: AnalysisUnit
        """
        c_result = self._eval_field(AnalysisUnit._c_type(), _ada_node_p_standard_unit)
        result = AnalysisUnit._wrap(c_result)
        return result
    def p_std_entity(self, sym):
        """
        Static property. Return an entity from the standard package with name
        `sym`.

        :rtype: AdaNode
        """
        _context = self.unit.context._c_value
        unwrapped_sym = _symbol_type.unwrap(sym, _context)
        c_result = self._eval_field(_Entity_c_type(), _ada_node_p_std_entity, unwrapped_sym)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_bool_type(self):
        """
        Static method. Return the standard Boolean type.

        :rtype: AdaNode
        """
        c_result = self._eval_field(_Entity_c_type(), _ada_node_p_bool_type)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_int_type(self):
        """
        Static method. Return the standard Integer type.

        :rtype: AdaNode
        """
        c_result = self._eval_field(_Entity_c_type(), _ada_node_p_int_type)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_universal_int_type(self):
        """
        Static method. Return the standard Universal Integer type.

        :rtype: AdaNode
        """
        c_result = self._eval_field(_Entity_c_type(), _ada_node_p_universal_int_type)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_universal_real_type(self):
        """
        Static method. Return the standard Universal Real type.

        :rtype: AdaNode
        """
        c_result = self._eval_field(_Entity_c_type(), _ada_node_p_universal_real_type)
        result = AdaNode._wrap(c_result)
        return result
    def p_top_level_decl(self, unit):
        """
        Static method. Get the top-level decl in "unit". This is the body of a
        Subunit, or the item of a LibraryItem.

        :rtype: BasicDecl
        """
        unwrapped_unit = AnalysisUnit._unwrap(unit)
        c_result = self._eval_field(_Entity_c_type(), _ada_node_p_top_level_decl, unwrapped_unit)
        result = AdaNode._wrap(c_result)
        return result
    def p_gnat_xref(self, imprecise_fallback=False):
        """
        Return a cross reference from this name to a defining identifier,
        trying to mimic GNAT's xrefs as much as possible.

        :rtype: DefiningName
        """
        unwrapped_imprecise_fallback = bool(imprecise_fallback)
        c_result = self._eval_field(_Entity_c_type(), _ada_node_p_gnat_xref, unwrapped_imprecise_fallback)
        result = AdaNode._wrap(c_result)
        return result
    _field_names = () + (
    )
    def __init__(self, c_value, node_c_value, metadata, rebindings):
        """
        This constructor is an implementation detail, and is not meant to be
        used directly. For now, the creation of AST nodes can happen only as
        part of the parsing of an analysis unit.
        """
        self._unprotected_c_value = c_value
        # Access to these fields is unprotected from stale references, but it
        # is supposed to be used only in _id_tuple, which itself should not be
        # used outside of hashing/equality use cases.
        self._node_c_value = node_c_value
        self._rebindings = rebindings
        self._metadata = metadata
        self._unprotected_getitem_cache = {}
        """
        Cache for the __getitem__ override.

        :type: dict[int, AdaNode]
        """
        # Information to check before accessing node data that it is still
        # valid.
        self._unit = self._fetch_unit(c_value)
        self._unit_version = self._unit._unit_version
    def _check_stale_reference(self):
        # We have a reference to the owning unit, so there is no need to
        # check that the unit and the context are still valid. Just check that
        # the unit has not been reparsed.
        if self._unit._unit_version != self._unit_version:
            raise StaleReferenceError()
    @property
    def _c_value(self):
        self._check_stale_reference()
        return self._unprotected_c_value
    @property
    def _getitem_cache(self):
        self._check_stale_reference()
        return self._unprotected_getitem_cache
    @property
    def _id_tuple(self):
        return (self._node_c_value, self._rebindings)
    def __eq__(self, other):
        return (isinstance(other, AdaNode) and
                self._id_tuple == other._id_tuple)
    def __ne__(self, other):
        return not (self == other)
    def __hash__(self):
        return hash(self._id_tuple)
    @property
    def kind_name(self):
        """
        Return the kind of this node.
        """
        return self._kind_name
    @property
    def unit(self):
        """
        Return the analysis unit that owns this node.
        """
        return self._unit
    @property
    def is_token_node(self):
        """
        Return whether this node is a node that contains only a single token.
        """
        node = self._unwrap(self)
        return bool(_node_is_token_node(ctypes.byref(node)))
    @property
    def sloc_range(self):
        """
        Return the spanning source location range for this node.
        """
        node = self._unwrap(self)
        result = SlocRange._c_type()
        _node_sloc_range(ctypes.byref(node), ctypes.byref(result))
        return result._wrap()
    @property
    def text(self):
        """
        Return the source buffer slice corresponding to the text that spans
        between the first and the last tokens of `self`.
        """
        return ('' if self.is_ghost else
                Token.text_range(self.token_start, self.token_end))
    @property
    def short_image(self):
        """
        Return a representation of this node as a string.
        """
        node = self._unwrap(self)
        text = _node_short_image(ctypes.byref(node))
        return text._wrap()
    def lookup(self, sloc):
        """
        Return the bottom-most node from in ``Node`` and its children which
        contains ``Sloc``, or ``None`` if there is none.
        """
        node = self._unwrap(self)
        c_sloc = Sloc._c_type._unwrap(sloc)
        result = _Entity_c_type()
        _lookup_in_node(ctypes.byref(node), ctypes.byref(c_sloc),
                        ctypes.byref(result))
        return AdaNode._wrap(result)
    def __nonzero__(self):
        """
        Return always True so that checking a node against None can be done as
        simply as::

            if node:
                ...
        """
        return True
    def __len__(self):
        """Return the number of AdaNode children this node has."""
        node = self._unwrap(self)
        return _node_children_count(ctypes.byref(node))
    def __getitem__(self, key):
        """
        Return the Nth AdaNode child this node has.

        This handles negative indexes the same way Python lists do. Raise an
        IndexError if "key" is out of range.
        """
        if not isinstance(key, int):
            msg = ('AdaNode children are integer-indexed'
                   ' (got {})').format(type(key))
            raise TypeError(msg)
        if key < 0:
            key += len(self)
        if key in self._getitem_cache:
            return self._getitem_cache[key]
        node = self._unwrap(self)
        result = _Entity_c_type()
        success = _node_child(ctypes.byref(node), key, ctypes.byref(result))
        if not success:
            raise IndexError('child index out of range')
        else:
            result = AdaNode._wrap(result)
            self._getitem_cache[key] = result
            return result
    def iter_fields(self):
        """
        Iterate through all the fields this node contains.

        Return an iterator that yields (name, value) couples for all abstract
        fields in this node. If "self" is a list, field names will be
        "item_{n}" with "n" being the index.
        """
        if self.is_list_type:
            for i, value in enumerate(self):
                yield ('item_{}'.format(i), value)
        else:
            for field_name in self._field_names:
                yield (field_name, getattr(self, '{}'.format(field_name)))
    def dump_str(self):
        """
        Dump the sub-tree to a string in a human-readable format.
        """
        import StringIO
        output = StringIO.StringIO()
        self.dump(file=output)
        ret = output.getvalue()
        output.close()
        return ret
    def dump(self, indent='', file=sys.stdout):
        """
        Dump the sub-tree in a human-readable format on the given file.

        :param str indent: Prefix printed on each line during the dump.
        :param file file: File in which the dump must occur.
        """
        def print_node(name, value):
            if isinstance(value, AdaNode):
                print('{}{}:'.format(indent, name), file=file)
                value.dump(indent + '  ', file)
            else:
                print('{}{}: {}'.format(indent, name, value), file=file)
        erepr = self.entity_repr[1:-1]
        print('{}{}{}'.format(
            indent, erepr,
            ': {}'.format(self.text) if self.is_token_node else ''
        ), file=file)
        indent = indent + '|'
        if self.is_list_type:
            for i, value in enumerate(self):
                print_node("item_{}".format(i), value)
        else:
            for name, value in self.iter_fields():
                # Remove the f_ prefix to have the same behavior as the Ada
                # dumper.
                print_node(name[2:], value)
    def findall(self, ast_type_or_pred, **kwargs):
        """
        Helper for finditer that will return all results as a list. See
        finditer's documentation for more details.
        """
        return list(self.finditer(ast_type_or_pred, **kwargs))
    def find(self, ast_type_or_pred, **kwargs):
        """
        Helper for finditer that will return only the first result. See
        finditer's documentation for more details.
        """
        try:
            return next(self.finditer(ast_type_or_pred, **kwargs))
        except Exception:
            return None
    @property
    def parent_chain(self):
        """
        Return the parent chain of self. Self will be the first element,
        followed by the first parent, then this parent's parent, etc.
        """
        def _parent_chain(node):
            yield node
            if node.parent is not None:
                for p in _parent_chain(node.parent):
                    yield p
        return list(_parent_chain(self))
    def finditer(self, ast_type_or_pred, **kwargs):
        """
        Find every node corresponding to the passed predicates.

        :param ast_type_or_pred: If supplied with a subclass of
            AdaNode, will constrain the resulting collection to
            only the instances of this type or any subclass. If supplied with a
            predicate, it will apply the predicate on every node and keep only
            the ones for which it returns True. If supplied with a list of
            subclasses of AdaNode, it will match all instances of
            any of them.
        :type ast_type_or_pred:
            type|((AdaNode) -> bool)|list[type]

        :param kwargs: Allows the user to filter on attributes of the node. For
            every key value association, if the node has an attribute of name
            key that has the specified value, then the child is kept.
        :type kwargs: dict[str, Any]
        """
        # Create a "pred" function to use as the node filter during the
        # traversal.
        if isinstance(ast_type_or_pred, type):
            sought_type = ast_type_or_pred
            pred = lambda node: isinstance(node, sought_type)
        elif isinstance(ast_type_or_pred, collections.Sequence):
            sought_types = ast_type_or_pred
            pred = lambda node: isinstance(node, tuple(sought_types))
        else:
            pred = ast_type_or_pred
        def match(left, right):
            """
            :param left: Node child to match.
            :param right: Matcher, coming from ``kwargs``.
            """
            if left is None:
                return
            if hasattr(left, "match"):
                return left.match(right)
            else:
                return left == right
        def helper(node):
            for child in node:
                if child is not None:
                    if pred(child):
                        if not kwargs:
                            yield child
                        elif all([match(getattr(child, key, None), val)
                                  for key, val in kwargs.items()]):
                            yield child
                    for c in helper(child):
                        if c is not None:
                            yield c
        return helper(self)
    def __repr__(self):
        return self.short_image
    @property
    def entity_repr(self):
        c_value = self._unwrap(self)
        return _entity_image(ctypes.byref(c_value))._wrap()
    @property
    def tokens(self):
        """
        Return an iterator on the range of tokens that self encompasses.
        """
        start = self.token_start
        end = self.token_end
        while not start == end:
            yield start
            start = start.next
        yield end
    def to_data(self):
        """
        Return a nested python data-structure, constituted only of standard
        data types (dicts, lists, strings, ints, etc), and representing the
        portion of the AST corresponding to this node.
        """
        if self.is_list_type:
            return [i.to_data() for i in self if i is not None]
        else:
            return {n: v.to_data()
                    for n, v in self.iter_fields()
                    if v is not None}
    def to_json(self):
        """
        Return a JSON representation of this node.
        """
        return json.dumps(self.to_data())
    def is_a(self, *types):
        """
        Shortcut for isinstance(self, types).
        :rtype: bool
        """
        return isinstance(self, tuple(types))
    def cast(self, typ):
        """
        Fluent interface style method. Return ``self``, raise an error if self
        is not of type ``typ``.

        :type typ: () -> T
        :rtype: T
        """
        assert isinstance(self, typ)
        return self
    _node_c_type = _hashable_c_pointer()
    @classmethod
    def _wrap(cls, c_value):
        """
        Internal helper to wrap a low-level entity value into an instance of
        the the appropriate high-level Python wrapper subclass.
        """
        node_c_value = c_value.node
        if not node_c_value:
            return None
        rebindings = c_value.info.rebindings
        metadata = c_value.info.md
        # Look for an already existing wrapper for this node
        cache_key = (node_c_value, metadata, rebindings)
        unit = cls._fetch_unit(c_value)
        unit._check_node_cache()
        try:
            return unit._node_cache[cache_key]
        except KeyError:
            pass
        # Pick the right subclass to materialize this node in Python
        kind = _node_kind(ctypes.byref(c_value))
        result = _kind_to_astnode_cls[kind](c_value, node_c_value, metadata,
                                            rebindings)
        unit._node_cache[cache_key] = result
        return result
    @classmethod
    def _wrap_bare_node(cls, c_value):
        return cls._wrap(_Entity_c_type.from_bare_node(c_value))
    @classmethod
    def _unwrap(cls, py_value):
        """
        Internal helper to unwrap a high-level ASTNode instance into a
        low-level value. Raise a TypeError if the input value has unexpected
        type.
        """
        if py_value is None:
            return _Entity_c_type._null_value
        elif not isinstance(py_value, AdaNode):
            _raise_type_error('AdaNode', py_value)
        else:
            return py_value._c_value
    @property
    def _unwrap_einfo(self):
        return self._c_value.info
    @classmethod
    def _fetch_unit(cls, c_value):
        return AnalysisUnit._wrap(_node_unit(ctypes.byref(c_value)))
    def _eval_field(self, c_result, c_accessor, *c_args):
        """
        Internal helper to evaluate low-level field accessors/properties.

        This calls "c_accessor" on this node with the input arguments and puts
        the result in "c_result". This raises a PropertyError if the evaluation
        failed. Return "c_result" for convenience.
        """
        args = (self._unwrap(self), ) + c_args + (ctypes.byref(c_result), )
        if not c_accessor(*args):
            exc = _get_last_exception()
            if exc:
                raise PropertyError(*exc.contents._wrap().args)
            else:
                raise PropertyError()
        return c_result
    def _eval_astnode_field(self, c_accessor):
        """
        Internal helper. Wrapper around _eval_field for fields that return an
        AST node and that accept no explicit argument. This is useful as it's
        the most common case of field, so using this wrapper reduces generated
        code length.
        """
        return AdaNode._wrap(
            self._eval_field(_Entity_c_type(), c_accessor)
        )
class AbortNode(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def p_as_bool(self):
        """
        Return whether this is an instance of AbortPresent

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _abort_node_p_as_bool)
        result = bool(c_result.value)
        return result
    _field_names = AdaNode._field_names + (
    )
class AbortAbsent(AbortNode):
    __slots__ = AdaNode.__slots__
    _field_names = AbortNode._field_names + (
    )
    _kind_name = 'AbortAbsent'
class AbortPresent(AbortNode):
    __slots__ = AdaNode.__slots__
    _field_names = AbortNode._field_names + (
    )
    _kind_name = 'AbortPresent'
class AbstractNode(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def p_as_bool(self):
        """
        Return whether this is an instance of AbstractPresent

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _abstract_node_p_as_bool)
        result = bool(c_result.value)
        return result
    _field_names = AdaNode._field_names + (
    )
class AbstractAbsent(AbstractNode):
    __slots__ = AdaNode.__slots__
    _field_names = AbstractNode._field_names + (
    )
    _kind_name = 'AbstractAbsent'
class AbstractPresent(AbstractNode):
    __slots__ = AdaNode.__slots__
    _field_names = AbstractNode._field_names + (
    )
    _kind_name = 'AbstractPresent'
class AdaList(AdaNode):
    __slots__ = AdaNode.__slots__
    _field_names = AdaNode._field_names + (
    )
class AdaNodeList(AdaList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaList._field_names + (
    )
    _kind_name = 'AdaNodeList'
    is_list_type = True
class AlternativesList(AdaNodeList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaNodeList._field_names + (
    )
    _kind_name = 'AlternativesList'
    is_list_type = True
class ConstraintList(AdaNodeList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaNodeList._field_names + (
    )
    _kind_name = 'ConstraintList'
    is_list_type = True
class DeclList(AdaNodeList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaNodeList._field_names + (
    )
    _kind_name = 'DeclList'
    is_list_type = True
class StmtList(AdaNodeList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaNodeList._field_names + (
    )
    _kind_name = 'StmtList'
    is_list_type = True
class AspectAssocList(AdaList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaList._field_names + (
    )
    _kind_name = 'AspectAssocList'
    is_list_type = True
class BaseAssocList(AdaList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaList._field_names + (
    )
    _kind_name = 'BaseAssocList'
    is_list_type = True
class BasicAssocList(AdaList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaList._field_names + (
    )
    is_list_type = True
class AssocList(BasicAssocList):
    __slots__ = AdaNode.__slots__
    _field_names = BasicAssocList._field_names + (
    )
    _kind_name = 'AssocList'
    is_list_type = True
class CaseExprAlternativeList(AdaList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaList._field_names + (
    )
    _kind_name = 'CaseExprAlternativeList'
    is_list_type = True
class CaseStmtAlternativeList(AdaList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaList._field_names + (
    )
    _kind_name = 'CaseStmtAlternativeList'
    is_list_type = True
class CompilationUnitList(AdaList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaList._field_names + (
    )
    _kind_name = 'CompilationUnitList'
    is_list_type = True
class ContractCaseAssocList(AdaList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaList._field_names + (
    )
    _kind_name = 'ContractCaseAssocList'
    is_list_type = True
class DefiningNameList(AdaList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaList._field_names + (
    )
    _kind_name = 'DefiningNameList'
    is_list_type = True
class DiscriminantSpecList(AdaList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaList._field_names + (
    )
    _kind_name = 'DiscriminantSpecList'
    is_list_type = True
class ElsifExprPartList(AdaList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaList._field_names + (
    )
    _kind_name = 'ElsifExprPartList'
    is_list_type = True
class ElsifStmtPartList(AdaList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaList._field_names + (
    )
    _kind_name = 'ElsifStmtPartList'
    is_list_type = True
class EnumLiteralDeclList(AdaList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaList._field_names + (
    )
    _kind_name = 'EnumLiteralDeclList'
    is_list_type = True
class ExprList(AdaList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaList._field_names + (
    )
    is_list_type = True
class ExprAlternativesList(ExprList):
    __slots__ = AdaNode.__slots__
    _field_names = ExprList._field_names + (
    )
    _kind_name = 'ExprAlternativesList'
    is_list_type = True
class IdentifierList(AdaList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaList._field_names + (
    )
    is_list_type = True
class DiscriminantChoiceList(IdentifierList):
    __slots__ = AdaNode.__slots__
    _field_names = IdentifierList._field_names + (
    )
    _kind_name = 'DiscriminantChoiceList'
    is_list_type = True
class NameList(AdaList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaList._field_names + (
    )
    _kind_name = 'NameList'
    is_list_type = True
class ParentList(NameList):
    __slots__ = AdaNode.__slots__
    _field_names = NameList._field_names + (
    )
    _kind_name = 'ParentList'
    is_list_type = True
class ParamSpecList(AdaList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaList._field_names + (
    )
    _kind_name = 'ParamSpecList'
    is_list_type = True
class PragmaNodeList(AdaList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaList._field_names + (
    )
    _kind_name = 'PragmaNodeList'
    is_list_type = True
class SelectWhenPartList(AdaList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaList._field_names + (
    )
    _kind_name = 'SelectWhenPartList'
    is_list_type = True
class UnconstrainedArrayIndexList(AdaList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaList._field_names + (
    )
    _kind_name = 'UnconstrainedArrayIndexList'
    is_list_type = True
class VariantList(AdaList):
    __slots__ = AdaNode.__slots__
    _field_names = AdaList._field_names + (
    )
    _kind_name = 'VariantList'
    is_list_type = True
class AliasedNode(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def p_as_bool(self):
        """
        Return whether this is an instance of AliasedPresent

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _aliased_node_p_as_bool)
        result = bool(c_result.value)
        return result
    _field_names = AdaNode._field_names + (
    )
class AliasedAbsent(AliasedNode):
    __slots__ = AdaNode.__slots__
    _field_names = AliasedNode._field_names + (
    )
    _kind_name = 'AliasedAbsent'
class AliasedPresent(AliasedNode):
    __slots__ = AdaNode.__slots__
    _field_names = AliasedNode._field_names + (
    )
    _kind_name = 'AliasedPresent'
class AllNode(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def p_as_bool(self):
        """
        Return whether this is an instance of AllPresent

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _all_node_p_as_bool)
        result = bool(c_result.value)
        return result
    _field_names = AdaNode._field_names + (
    )
class AllAbsent(AllNode):
    __slots__ = AdaNode.__slots__
    _field_names = AllNode._field_names + (
    )
    _kind_name = 'AllAbsent'
class AllPresent(AllNode):
    __slots__ = AdaNode.__slots__
    _field_names = AllNode._field_names + (
    )
    _kind_name = 'AllPresent'
class ArrayIndices(AdaNode):
    __slots__ = AdaNode.__slots__
    _field_names = AdaNode._field_names + (
    )
class ConstrainedArrayIndices(ArrayIndices):
    __slots__ = AdaNode.__slots__
    @property
    def f_list(self):
        """
        :rtype: ConstraintList
        """
        result = self._eval_astnode_field(_constrained_array_indices_f_list)
        return result
    _field_names = ArrayIndices._field_names + (
        "f_list",
    )
    _kind_name = 'ConstrainedArrayIndices'
class UnconstrainedArrayIndices(ArrayIndices):
    __slots__ = AdaNode.__slots__
    @property
    def f_types(self):
        """
        :rtype: UnconstrainedArrayIndexList
        """
        result = self._eval_astnode_field(_unconstrained_array_indices_f_types)
        return result
    _field_names = ArrayIndices._field_names + (
        "f_types",
    )
    _kind_name = 'UnconstrainedArrayIndices'
class AspectAssoc(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_id(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_aspect_assoc_f_id)
        return result
    @property
    def f_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_aspect_assoc_f_expr)
        return result
    _field_names = AdaNode._field_names + (
        "f_id",
        "f_expr",
    )
    _kind_name = 'AspectAssoc'
class AspectClause(AdaNode):
    __slots__ = AdaNode.__slots__
    _field_names = AdaNode._field_names + (
    )
class AtClause(AspectClause):
    __slots__ = AdaNode.__slots__
    @property
    def f_name(self):
        """
        :rtype: BaseId
        """
        result = self._eval_astnode_field(_at_clause_f_name)
        return result
    @property
    def f_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_at_clause_f_expr)
        return result
    _field_names = AspectClause._field_names + (
        "f_name",
        "f_expr",
    )
    _kind_name = 'AtClause'
class AttributeDefClause(AspectClause):
    __slots__ = AdaNode.__slots__
    @property
    def f_attribute_expr(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_attribute_def_clause_f_attribute_expr)
        return result
    @property
    def f_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_attribute_def_clause_f_expr)
        return result
    _field_names = AspectClause._field_names + (
        "f_attribute_expr",
        "f_expr",
    )
    _kind_name = 'AttributeDefClause'
class EnumRepClause(AspectClause):
    __slots__ = AdaNode.__slots__
    @property
    def f_type_name(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_enum_rep_clause_f_type_name)
        return result
    @property
    def f_aggregate(self):
        """
        :rtype: BaseAggregate
        """
        result = self._eval_astnode_field(_enum_rep_clause_f_aggregate)
        return result
    _field_names = AspectClause._field_names + (
        "f_type_name",
        "f_aggregate",
    )
    _kind_name = 'EnumRepClause'
class RecordRepClause(AspectClause):
    __slots__ = AdaNode.__slots__
    @property
    def f_name(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_record_rep_clause_f_name)
        return result
    @property
    def f_at_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_record_rep_clause_f_at_expr)
        return result
    @property
    def f_components(self):
        """
        :rtype: AdaNodeList
        """
        result = self._eval_astnode_field(_record_rep_clause_f_components)
        return result
    _field_names = AspectClause._field_names + (
        "f_name",
        "f_at_expr",
        "f_components",
    )
    _kind_name = 'RecordRepClause'
class AspectSpec(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_aspect_assocs(self):
        """
        :rtype: AspectAssocList
        """
        result = self._eval_astnode_field(_aspect_spec_f_aspect_assocs)
        return result
    _field_names = AdaNode._field_names + (
        "f_aspect_assocs",
    )
    _kind_name = 'AspectSpec'
class BaseAssoc(AdaNode):
    """
    Abstract class for a key -> value association, where the value is an
    expression.
    """
    __slots__ = AdaNode.__slots__
    @property
    def p_assoc_expr(self):
        """
        Returns the expression side of this assoc node.

        :rtype: Expr
        """
        c_result = self._eval_field(_Entity_c_type(), _base_assoc_p_assoc_expr)
        result = AdaNode._wrap(c_result)
        return result
    _field_names = AdaNode._field_names + (
    )
class ContractCaseAssoc(BaseAssoc):
    __slots__ = AdaNode.__slots__
    @property
    def f_guard(self):
        """
        :rtype: AdaNode
        """
        result = self._eval_astnode_field(_contract_case_assoc_f_guard)
        return result
    @property
    def f_consequence(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_contract_case_assoc_f_consequence)
        return result
    _field_names = BaseAssoc._field_names + (
        "f_guard",
        "f_consequence",
    )
    _kind_name = 'ContractCaseAssoc'
class PragmaArgumentAssoc(BaseAssoc):
    __slots__ = AdaNode.__slots__
    @property
    def f_id(self):
        """
        :rtype: Identifier
        """
        result = self._eval_astnode_field(_pragma_argument_assoc_f_id)
        return result
    @property
    def f_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_pragma_argument_assoc_f_expr)
        return result
    _field_names = BaseAssoc._field_names + (
        "f_id",
        "f_expr",
    )
    _kind_name = 'PragmaArgumentAssoc'
class BaseFormalParamHolder(AdaNode):
    """
    Base class for lists of formal parameters. This is used both for subprogram
    specifications and for records, so that we can share the matching and
    unpacking logic.
    """
    __slots__ = AdaNode.__slots__
    @property
    def p_abstract_formal_params(self):
        """
        Return the list of abstract formal parameters for this holder.

        :rtype: list[BaseFormalParamDecl]
        """
        c_result = self._eval_field(_AdaNodeArrayConverter.c_type(), _base_formal_param_holder_p_abstract_formal_params)
        result = _AdaNodeArrayConverter.wrap(c_result)
        return result
    @property
    def p_nb_min_params(self):
        """
        Return the minimum number of parameters this subprogram can be called
        while still being a legal call.

        :rtype: int
        """
        c_result = self._eval_field(ctypes.c_int(), _base_formal_param_holder_p_nb_min_params)
        result = c_result.value
        return result
    @property
    def p_nb_max_params(self):
        """
        Return the maximum number of parameters this subprogram can be called
        while still being a legal call.

        :rtype: int
        """
        c_result = self._eval_field(ctypes.c_int(), _base_formal_param_holder_p_nb_max_params)
        result = c_result.value
        return result
    def p_return_type(self, origin=None):
        """
        Returns the return type of Self, if applicable (eg. if Self is a
        subprogram). Else, returns null.

        :rtype: BaseTypeDecl
        """
        unwrapped_origin = AdaNode._unwrap(origin)
        c_result = self._eval_field(_Entity_c_type(), _base_formal_param_holder_p_return_type, unwrapped_origin)
        result = AdaNode._wrap(c_result)
        return result
    _field_names = AdaNode._field_names + (
    )
class BaseSubpSpec(BaseFormalParamHolder):
    __slots__ = AdaNode.__slots__
    @property
    def p_returns(self):
        """
        Syntax property. Return the type expression node corresponding to the
        return of this subprogram spec.

        :rtype: TypeExpr
        """
        c_result = self._eval_field(_Entity_c_type(), _base_subp_spec_p_returns)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_params(self):
        """
        Returns the array of parameters specification for this subprogram spec.

        :rtype: list[ParamSpec]
        """
        c_result = self._eval_field(_AdaNodeArrayConverter.c_type(), _base_subp_spec_p_params)
        result = _AdaNodeArrayConverter.wrap(c_result)
        return result
    @property
    def p_primitive_subp_of(self):
        """
        Return the type of which this subprogram is a primitive of.

        :rtype: BaseTypeDecl
        """
        c_result = self._eval_field(_Entity_c_type(), _base_subp_spec_p_primitive_subp_of)
        result = AdaNode._wrap(c_result)
        return result
    _field_names = BaseFormalParamHolder._field_names + (
    )
class EntrySpec(BaseSubpSpec):
    __slots__ = AdaNode.__slots__
    @property
    def f_entry_name(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_entry_spec_f_entry_name)
        return result
    @property
    def f_family_type(self):
        """
        :rtype: AdaNode
        """
        result = self._eval_astnode_field(_entry_spec_f_family_type)
        return result
    @property
    def f_entry_params(self):
        """
        :rtype: Params
        """
        result = self._eval_astnode_field(_entry_spec_f_entry_params)
        return result
    _field_names = BaseSubpSpec._field_names + (
        "f_entry_name",
        "f_family_type",
        "f_entry_params",
    )
    _kind_name = 'EntrySpec'
class SubpSpec(BaseSubpSpec):
    __slots__ = AdaNode.__slots__
    @property
    def f_subp_kind(self):
        """
        :rtype: SubpKind
        """
        result = self._eval_astnode_field(_subp_spec_f_subp_kind)
        return result
    @property
    def f_subp_name(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_subp_spec_f_subp_name)
        return result
    @property
    def f_subp_params(self):
        """
        :rtype: Params
        """
        result = self._eval_astnode_field(_subp_spec_f_subp_params)
        return result
    @property
    def f_subp_returns(self):
        """
        :rtype: TypeExpr
        """
        result = self._eval_astnode_field(_subp_spec_f_subp_returns)
        return result
    _field_names = BaseSubpSpec._field_names + (
        "f_subp_kind",
        "f_subp_name",
        "f_subp_params",
        "f_subp_returns",
    )
    _kind_name = 'SubpSpec'
class ComponentList(BaseFormalParamHolder):
    __slots__ = AdaNode.__slots__
    @property
    def f_components(self):
        """
        :rtype: AdaNodeList
        """
        result = self._eval_astnode_field(_component_list_f_components)
        return result
    @property
    def f_variant_part(self):
        """
        :rtype: VariantPart
        """
        result = self._eval_astnode_field(_component_list_f_variant_part)
        return result
    _field_names = BaseFormalParamHolder._field_names + (
        "f_components",
        "f_variant_part",
    )
    _kind_name = 'ComponentList'
class DiscriminantPart(BaseFormalParamHolder):
    __slots__ = AdaNode.__slots__
    _field_names = BaseFormalParamHolder._field_names + (
    )
class KnownDiscriminantPart(DiscriminantPart):
    __slots__ = AdaNode.__slots__
    @property
    def f_discr_specs(self):
        """
        :rtype: DiscriminantSpecList
        """
        result = self._eval_astnode_field(_known_discriminant_part_f_discr_specs)
        return result
    _field_names = DiscriminantPart._field_names + (
        "f_discr_specs",
    )
    _kind_name = 'KnownDiscriminantPart'
class UnknownDiscriminantPart(DiscriminantPart):
    __slots__ = AdaNode.__slots__
    _field_names = DiscriminantPart._field_names + (
    )
    _kind_name = 'UnknownDiscriminantPart'
class GenericFormalPart(BaseFormalParamHolder):
    __slots__ = AdaNode.__slots__
    @property
    def f_decls(self):
        """
        :rtype: AdaNodeList
        """
        result = self._eval_astnode_field(_generic_formal_part_f_decls)
        return result
    _field_names = BaseFormalParamHolder._field_names + (
        "f_decls",
    )
    _kind_name = 'GenericFormalPart'
class BaseRecordDef(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_components(self):
        """
        :rtype: ComponentList
        """
        result = self._eval_astnode_field(_base_record_def_f_components)
        return result
    _field_names = AdaNode._field_names + (
        "f_components",
    )
class NullRecordDef(BaseRecordDef):
    __slots__ = AdaNode.__slots__
    _field_names = BaseRecordDef._field_names + (
    )
    _kind_name = 'NullRecordDef'
class RecordDef(BaseRecordDef):
    __slots__ = AdaNode.__slots__
    _field_names = BaseRecordDef._field_names + (
    )
    _kind_name = 'RecordDef'
class BasicAssoc(AdaNode):
    __slots__ = AdaNode.__slots__
    _field_names = AdaNode._field_names + (
    )
class AggregateAssoc(BasicAssoc):
    """
    Assocation (X => Y) used for aggregates and parameter associations.
    """
    __slots__ = AdaNode.__slots__
    @property
    def f_designators(self):
        """
        :rtype: AlternativesList
        """
        result = self._eval_astnode_field(_aggregate_assoc_f_designators)
        return result
    @property
    def f_r_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_aggregate_assoc_f_r_expr)
        return result
    _field_names = BasicAssoc._field_names + (
        "f_designators",
        "f_r_expr",
    )
    _kind_name = 'AggregateAssoc'
class MultiDimArrayAssoc(AggregateAssoc):
    __slots__ = AdaNode.__slots__
    _field_names = AggregateAssoc._field_names + (
    )
    _kind_name = 'MultiDimArrayAssoc'
class DiscriminantAssoc(BasicAssoc):
    __slots__ = AdaNode.__slots__
    @property
    def f_ids(self):
        """
        :rtype: DiscriminantChoiceList
        """
        result = self._eval_astnode_field(_discriminant_assoc_f_ids)
        return result
    @property
    def f_discr_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_discriminant_assoc_f_discr_expr)
        return result
    _field_names = BasicAssoc._field_names + (
        "f_ids",
        "f_discr_expr",
    )
    _kind_name = 'DiscriminantAssoc'
class ParamAssoc(BasicAssoc):
    """
    Assocation (X => Y) used for aggregates and parameter associations.
    """
    __slots__ = AdaNode.__slots__
    @property
    def f_designator(self):
        """
        :rtype: AdaNode
        """
        result = self._eval_astnode_field(_param_assoc_f_designator)
        return result
    @property
    def f_r_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_param_assoc_f_r_expr)
        return result
    _field_names = BasicAssoc._field_names + (
        "f_designator",
        "f_r_expr",
    )
    _kind_name = 'ParamAssoc'
class BasicDecl(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def p_previous_part_for_decl(self):
        """
        Return the previous part for this decl, if applicable.

        .. note:: It is not named previous_part, because BaseTypeDecl has a
        more precise version of previous_part that returns a BaseTypeDecl.
        Probably, we want to rename the specific versions, and have the root
        property be named previous_part. (TODO R925-008)

        :rtype: BasicDecl
        """
        c_result = self._eval_field(_Entity_c_type(), _basic_decl_p_previous_part_for_decl)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_canonical_part(self):
        """
        Return the canonical part for this decl. In the case of decls composed
        of several parts, the canonical part will be the first part.

        :rtype: BasicDecl
        """
        c_result = self._eval_field(_Entity_c_type(), _basic_decl_p_canonical_part)
        result = AdaNode._wrap(c_result)
        return result
    def p_is_static_decl(self, imprecise_fallback=False):
        """
        Return whether this declaration is static.

        :rtype: bool
        """
        unwrapped_imprecise_fallback = bool(imprecise_fallback)
        c_result = self._eval_field(ctypes.c_uint8(), _basic_decl_p_is_static_decl, unwrapped_imprecise_fallback)
        result = bool(c_result.value)
        return result
    @property
    def p_is_imported(self):
        """
        Whether this declaration is imported from another language.

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _basic_decl_p_is_imported)
        result = bool(c_result.value)
        return result
    @property
    def f_aspects(self):
        """
        Return the list of aspects that are attached to this node.

        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_basic_decl_f_aspects)
        return result
    def p_get_aspect(self, name):
        """
        Return the aspect with name ``name`` for this entity.

        :rtype: AspectAssoc
        """
        _context = self.unit.context._c_value
        unwrapped_name = _symbol_type.unwrap(name, _context)
        c_result = self._eval_field(_Entity_c_type(), _basic_decl_p_get_aspect, unwrapped_name)
        result = AdaNode._wrap(c_result)
        return result
    def p_get_aspect_expr(self, name):
        """
        Return the expression associated to the aspect with name ``name`` for
        this entity.

        :rtype: Expr
        """
        _context = self.unit.context._c_value
        unwrapped_name = _symbol_type.unwrap(name, _context)
        c_result = self._eval_field(_Entity_c_type(), _basic_decl_p_get_aspect_expr, unwrapped_name)
        result = AdaNode._wrap(c_result)
        return result
    def p_get_attribute(self, name):
        """
        Return the attribute with name ``name`` associated to this entity.

        Attribute is the term chosen to unify data that can be set by the user
        on an Ada entity via three different mechanisms, sometimes
        interchangeably: Pragmas, aspects and representation clauses.

        This will return the syntactic node corresponding to attribute
        directly.

        :rtype: AdaNode
        """
        _context = self.unit.context._c_value
        unwrapped_name = _symbol_type.unwrap(name, _context)
        c_result = self._eval_field(_Entity_c_type(), _basic_decl_p_get_attribute, unwrapped_name)
        result = AdaNode._wrap(c_result)
        return result
    def p_get_pragma(self, name):
        """
        Return the pragma with name ``name`` associated to this entity.

        :rtype: PragmaNode
        """
        _context = self.unit.context._c_value
        unwrapped_name = _symbol_type.unwrap(name, _context)
        c_result = self._eval_field(_Entity_c_type(), _basic_decl_p_get_pragma, unwrapped_name)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_is_unit_root(self):
        """
        Whether a BasicDecl is the root decl for its unit.

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _basic_decl_p_is_unit_root)
        result = bool(c_result.value)
        return result
    @property
    def p_defining_names(self):
        """
        Get all the names of this basic declaration.

        :rtype: list[DefiningName]
        """
        c_result = self._eval_field(_AdaNodeArrayConverter.c_type(), _basic_decl_p_defining_names)
        result = _AdaNodeArrayConverter.wrap(c_result)
        return result
    @property
    def p_defining_name(self):
        """
        Get the name of this declaration. If this declaration has several
        names, it will return the first one.

        :rtype: DefiningName
        """
        c_result = self._eval_field(_Entity_c_type(), _basic_decl_p_defining_name)
        result = AdaNode._wrap(c_result)
        return result
    def p_subp_spec_or_null(self, follow_generic=False):
        """
        If Self is a Subp, returns the specification of this subprogram.

        If ``follow_generic`` is True, will also work for instances of
        ``GenericSubpDecl``.

        :rtype: BaseSubpSpec
        """
        unwrapped_follow_generic = bool(follow_generic)
        c_result = self._eval_field(_Entity_c_type(), _basic_decl_p_subp_spec_or_null, unwrapped_follow_generic)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_is_subprogram(self):
        """
        Return True if self is a subprogram node in the general sense (which
        is, an entity that can be called). This includes separates and entries.

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _basic_decl_p_is_subprogram)
        result = bool(c_result.value)
        return result
    @property
    def p_declarative_scope(self):
        """
        Return the scope of definition of this basic declaration.

        :rtype: DeclarativePart
        """
        result = self._eval_astnode_field(_basic_decl_p_declarative_scope)
        return result
    @property
    def p_relative_name(self):
        """
        Return the relative name for Self. If Self's defining name is
        ``A.B.C``, return C as a node.

        :rtype: SingleTokNode
        """
        c_result = self._eval_field(_Entity_c_type(), _basic_decl_p_relative_name)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_relative_name_text(self):
        """
        Return the relative name for Self, as text.

        :rtype: unicode
        """
        c_result = self._eval_field(_symbol_type(), _basic_decl_p_relative_name_text)
        result = _symbol_type.wrap(c_result)
        return result
    @property
    def p_next_part_for_decl(self):
        """
        Return the next part of this declaration, if applicable.

        .. note:: It is not named next_part, because BaseTypeDecl has a more
        precise version of next_part that returns a BaseTypeDecl. Probably, we
        want to rename the specific versions, and have the root property be
        named previous_part. (TODO R925-008)

        :rtype: BasicDecl
        """
        c_result = self._eval_field(_Entity_c_type(), _basic_decl_p_next_part_for_decl)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_body_part_for_decl(self):
        """
        Return the body corresponding to this declaration, if applicable.

        .. note:: It is not named body_part, subclasses have more precise
        versions named body_part and returning a more precise result. Probably,
        we want to rename the specific versions, and have the root property be
        named previous_part. (TODO R925-008)

        :rtype: BodyNode
        """
        c_result = self._eval_field(_Entity_c_type(), _basic_decl_p_body_part_for_decl)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_fully_qualified_name(self):
        """
        Return the fully qualified name corresponding to this declaration.

        :rtype: list[unicode]
        """
        c_result = self._eval_field(_UnboundedTextTypeArrayConverter.c_type(), _basic_decl_p_fully_qualified_name)
        result = _UnboundedTextTypeArrayConverter.wrap(c_result)
        return result
    _field_names = AdaNode._field_names + (
    )
class BaseFormalParamDecl(BasicDecl):
    """
    Base class for formal parameter declarations. This is used both for records
    components and for subprogram parameters.
    """
    __slots__ = AdaNode.__slots__
    @property
    def p_formal_type(self):
        """
        Return the type for this formal.

        :rtype: BaseTypeDecl
        """
        c_result = self._eval_field(_Entity_c_type(), _base_formal_param_decl_p_formal_type)
        result = AdaNode._wrap(c_result)
        return result
    _field_names = BasicDecl._field_names + (
    )
class ComponentDecl(BaseFormalParamDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_ids(self):
        """
        :rtype: DefiningNameList
        """
        result = self._eval_astnode_field(_component_decl_f_ids)
        return result
    @property
    def f_component_def(self):
        """
        :rtype: ComponentDef
        """
        result = self._eval_astnode_field(_component_decl_f_component_def)
        return result
    @property
    def f_default_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_component_decl_f_default_expr)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_component_decl_f_aspects)
        return result
    _field_names = BaseFormalParamDecl._field_names + (
        "f_ids",
        "f_component_def",
        "f_default_expr",
        "f_aspects",
    )
    _kind_name = 'ComponentDecl'
class DiscriminantSpec(BaseFormalParamDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_ids(self):
        """
        :rtype: DefiningNameList
        """
        result = self._eval_astnode_field(_discriminant_spec_f_ids)
        return result
    @property
    def f_type_expr(self):
        """
        :rtype: TypeExpr
        """
        result = self._eval_astnode_field(_discriminant_spec_f_type_expr)
        return result
    @property
    def f_default_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_discriminant_spec_f_default_expr)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_discriminant_spec_f_aspects)
        return result
    _field_names = BaseFormalParamDecl._field_names + (
        "f_ids",
        "f_type_expr",
        "f_default_expr",
    )
    _kind_name = 'DiscriminantSpec'
class GenericFormal(BaseFormalParamDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_decl(self):
        """
        :rtype: BasicDecl
        """
        result = self._eval_astnode_field(_generic_formal_f_decl)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_generic_formal_f_aspects)
        return result
    _field_names = BaseFormalParamDecl._field_names + (
        "f_decl",
    )
class GenericFormalObjDecl(GenericFormal):
    __slots__ = AdaNode.__slots__
    _field_names = GenericFormal._field_names + (
    )
    _kind_name = 'GenericFormalObjDecl'
class GenericFormalPackage(GenericFormal):
    __slots__ = AdaNode.__slots__
    _field_names = GenericFormal._field_names + (
    )
    _kind_name = 'GenericFormalPackage'
class GenericFormalSubpDecl(GenericFormal):
    __slots__ = AdaNode.__slots__
    _field_names = GenericFormal._field_names + (
    )
    _kind_name = 'GenericFormalSubpDecl'
class GenericFormalTypeDecl(GenericFormal):
    __slots__ = AdaNode.__slots__
    _field_names = GenericFormal._field_names + (
    )
    _kind_name = 'GenericFormalTypeDecl'
class ParamSpec(BaseFormalParamDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_ids(self):
        """
        :rtype: DefiningNameList
        """
        result = self._eval_astnode_field(_param_spec_f_ids)
        return result
    @property
    def f_has_aliased(self):
        """
        :rtype: AliasedNode
        """
        result = self._eval_astnode_field(_param_spec_f_has_aliased)
        return result
    @property
    def f_mode(self):
        """
        :rtype: Mode
        """
        result = self._eval_astnode_field(_param_spec_f_mode)
        return result
    @property
    def f_type_expr(self):
        """
        :rtype: TypeExpr
        """
        result = self._eval_astnode_field(_param_spec_f_type_expr)
        return result
    @property
    def f_default_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_param_spec_f_default_expr)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_param_spec_f_aspects)
        return result
    _field_names = BaseFormalParamDecl._field_names + (
        "f_ids",
        "f_has_aliased",
        "f_mode",
        "f_type_expr",
        "f_default_expr",
    )
    _kind_name = 'ParamSpec'
class BasePackageDecl(BasicDecl):
    """
    Package declarations. Concrete instances of this class will be created in
    generic package declarations. Other non-generic package declarations will
    be instances of PackageDecl.

    The behavior is the same, the only difference is that BasePackageDecl and
    PackageDecl have different behavior regarding lexical environments. In the
    case of generic package declarations, we use BasePackageDecl which has no
    env_spec, and the environment behavior is handled by the GenericPackageDecl
    instance.
    """
    __slots__ = AdaNode.__slots__
    @property
    def f_package_name(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_base_package_decl_f_package_name)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_base_package_decl_f_aspects)
        return result
    @property
    def f_public_part(self):
        """
        :rtype: PublicPart
        """
        result = self._eval_astnode_field(_base_package_decl_f_public_part)
        return result
    @property
    def f_private_part(self):
        """
        :rtype: PrivatePart
        """
        result = self._eval_astnode_field(_base_package_decl_f_private_part)
        return result
    @property
    def f_end_name(self):
        """
        :rtype: EndName
        """
        result = self._eval_astnode_field(_base_package_decl_f_end_name)
        return result
    @property
    def p_body_part(self):
        """
        Return the PackageBody corresponding to this node.

        :rtype: PackageBody
        """
        c_result = self._eval_field(_Entity_c_type(), _base_package_decl_p_body_part)
        result = AdaNode._wrap(c_result)
        return result
    _field_names = BasicDecl._field_names + (
        "f_package_name",
        "f_aspects",
        "f_public_part",
        "f_private_part",
        "f_end_name",
    )
class GenericPackageInternal(BasePackageDecl):
    """
    This class denotes the internal package contained by a GenericPackageDecl.
    """
    __slots__ = AdaNode.__slots__
    _field_names = BasePackageDecl._field_names + (
    )
    _kind_name = 'GenericPackageInternal'
class PackageDecl(BasePackageDecl):
    """
    Non-generic package declarations.
    """
    __slots__ = AdaNode.__slots__
    _field_names = BasePackageDecl._field_names + (
    )
    _kind_name = 'PackageDecl'
class BaseTypeDecl(BasicDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_name(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_base_type_decl_f_name)
        return result
    @property
    def p_private_completion(self):
        """
        Return the private completion for this type, if there is one.

        :rtype: BaseTypeDecl
        """
        c_result = self._eval_field(_Entity_c_type(), _base_type_decl_p_private_completion)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_is_real_type(self):
        """
        Whether type is a real type or not.

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _base_type_decl_p_is_real_type)
        result = bool(c_result.value)
        return result
    @property
    def p_is_float_type(self):
        """
        Whether type is a float type or not.

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _base_type_decl_p_is_float_type)
        result = bool(c_result.value)
        return result
    @property
    def p_is_fixed_point(self):
        """
        Whether type is a fixed point type or not.

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _base_type_decl_p_is_fixed_point)
        result = bool(c_result.value)
        return result
    def p_is_access_type(self, origin=None):
        """
        Whether Self is an access type or not

        :rtype: bool
        """
        unwrapped_origin = AdaNode._unwrap(origin)
        c_result = self._eval_field(ctypes.c_uint8(), _base_type_decl_p_is_access_type, unwrapped_origin)
        result = bool(c_result.value)
        return result
    @property
    def p_base_type(self):
        """
        Return the base type entity for this derived type declaration.

        :rtype: BaseTypeDecl
        """
        c_result = self._eval_field(_Entity_c_type(), _base_type_decl_p_base_type)
        result = AdaNode._wrap(c_result)
        return result
    def p_comp_type(self, is_subscript=False, origin=None):
        """
        Return the component type of `Self`, if applicable. The component type
        is the type you'll get if you call a value whose type is `Self`.  So it
        can either be:

        1. The component type for an array. 2. The return type for an access to
        function.

        :rtype: BaseTypeDecl
        """
        unwrapped_is_subscript = bool(is_subscript)
        unwrapped_origin = AdaNode._unwrap(origin)
        c_result = self._eval_field(_Entity_c_type(), _base_type_decl_p_comp_type, unwrapped_is_subscript, unwrapped_origin)
        result = AdaNode._wrap(c_result)
        return result
    def p_index_type(self, dim, origin=None):
        """
        Return the index type for dimension ``dim`` for this type, if
        applicable.

        :rtype: BaseTypeDecl
        """
        unwrapped_dim = int(dim)
        unwrapped_origin = AdaNode._unwrap(origin)
        c_result = self._eval_field(_Entity_c_type(), _base_type_decl_p_index_type, unwrapped_dim, unwrapped_origin)
        result = AdaNode._wrap(c_result)
        return result
    def p_is_derived_type(self, other_type, origin=None):
        """
        Whether Self is derived from other_type.

        :rtype: bool
        """
        unwrapped_other_type = AdaNode._unwrap(other_type)
        unwrapped_origin = AdaNode._unwrap(origin)
        c_result = self._eval_field(ctypes.c_uint8(), _base_type_decl_p_is_derived_type, unwrapped_other_type, unwrapped_origin)
        result = bool(c_result.value)
        return result
    def p_matching_type(self, expected_type, origin=None):
        """
        Return whether ``self`` matches ``expected_type``.

        :rtype: bool
        """
        unwrapped_expected_type = AdaNode._unwrap(expected_type)
        unwrapped_origin = AdaNode._unwrap(origin)
        c_result = self._eval_field(ctypes.c_uint8(), _base_type_decl_p_matching_type, unwrapped_expected_type, unwrapped_origin)
        result = bool(c_result.value)
        return result
    def p_canonical_type(self, origin=None):
        """
        Return the canonical type declaration for this type declaration. For
        subtypes, it will return the base type declaration.

        :rtype: BaseTypeDecl
        """
        unwrapped_origin = AdaNode._unwrap(origin)
        c_result = self._eval_field(_Entity_c_type(), _base_type_decl_p_canonical_type, unwrapped_origin)
        result = AdaNode._wrap(c_result)
        return result
    def p_previous_part(self, go_to_incomplete=True):
        """
        Returns the previous part for this type decl.

        :rtype: BaseTypeDecl
        """
        unwrapped_go_to_incomplete = bool(go_to_incomplete)
        c_result = self._eval_field(_Entity_c_type(), _base_type_decl_p_previous_part, unwrapped_go_to_incomplete)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_next_part(self):
        """
        Returns the next part for this type decl.

        :rtype: BaseTypeDecl
        """
        c_result = self._eval_field(_Entity_c_type(), _base_type_decl_p_next_part)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_is_private(self):
        """
        Whether node is a private view of corresponding type.

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _base_type_decl_p_is_private)
        result = bool(c_result.value)
        return result
    _field_names = BasicDecl._field_names + (
        "f_name",
    )
class BaseSubtypeDecl(BaseTypeDecl):
    __slots__ = AdaNode.__slots__
    _field_names = BaseTypeDecl._field_names + (
    )
class DiscreteBaseSubtypeDecl(BaseSubtypeDecl):
    """
    Specific ``SubtypeDecl`` synthetic subclass for the base type of scalar
    types.
    """
    __slots__ = AdaNode.__slots__
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_discrete_base_subtype_decl_f_aspects)
        return result
    _field_names = BaseSubtypeDecl._field_names + (
    )
    _kind_name = 'DiscreteBaseSubtypeDecl'
class SubtypeDecl(BaseSubtypeDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_subtype(self):
        """
        :rtype: SubtypeIndication
        """
        result = self._eval_astnode_field(_subtype_decl_f_subtype)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_subtype_decl_f_aspects)
        return result
    _field_names = BaseSubtypeDecl._field_names + (
        "f_subtype",
        "f_aspects",
    )
    _kind_name = 'SubtypeDecl'
class ClasswideTypeDecl(BaseTypeDecl):
    """
    Synthetic node (not parsed, generated from a property call). Refers to the
    classwide type for a given tagged type. The aim is that those be mostly
    equivalent to their non-classwide type, except for some resolution rules.
    """
    __slots__ = AdaNode.__slots__
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_classwide_type_decl_f_aspects)
        return result
    _field_names = BaseTypeDecl._field_names + (
    )
    _kind_name = 'ClasswideTypeDecl'
class IncompleteTypeDecl(BaseTypeDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_discriminants(self):
        """
        :rtype: DiscriminantPart
        """
        result = self._eval_astnode_field(_incomplete_type_decl_f_discriminants)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_incomplete_type_decl_f_aspects)
        return result
    _field_names = BaseTypeDecl._field_names + (
        "f_discriminants",
    )
    _kind_name = 'IncompleteTypeDecl'
class IncompleteTaggedTypeDecl(IncompleteTypeDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_has_abstract(self):
        """
        :rtype: AbstractNode
        """
        result = self._eval_astnode_field(_incomplete_tagged_type_decl_f_has_abstract)
        return result
    _field_names = IncompleteTypeDecl._field_names + (
        "f_has_abstract",
    )
    _kind_name = 'IncompleteTaggedTypeDecl'
class ProtectedTypeDecl(BaseTypeDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_discriminants(self):
        """
        :rtype: DiscriminantPart
        """
        result = self._eval_astnode_field(_protected_type_decl_f_discriminants)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_protected_type_decl_f_aspects)
        return result
    @property
    def f_interfaces(self):
        """
        :rtype: ParentList
        """
        result = self._eval_astnode_field(_protected_type_decl_f_interfaces)
        return result
    @property
    def f_definition(self):
        """
        :rtype: ProtectedDef
        """
        result = self._eval_astnode_field(_protected_type_decl_f_definition)
        return result
    _field_names = BaseTypeDecl._field_names + (
        "f_discriminants",
        "f_aspects",
        "f_interfaces",
        "f_definition",
    )
    _kind_name = 'ProtectedTypeDecl'
class TaskTypeDecl(BaseTypeDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_discriminants(self):
        """
        :rtype: DiscriminantPart
        """
        result = self._eval_astnode_field(_task_type_decl_f_discriminants)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_task_type_decl_f_aspects)
        return result
    @property
    def f_definition(self):
        """
        :rtype: TaskDef
        """
        result = self._eval_astnode_field(_task_type_decl_f_definition)
        return result
    _field_names = BaseTypeDecl._field_names + (
        "f_discriminants",
        "f_aspects",
        "f_definition",
    )
    _kind_name = 'TaskTypeDecl'
class SingleTaskTypeDecl(TaskTypeDecl):
    __slots__ = AdaNode.__slots__
    _field_names = TaskTypeDecl._field_names + (
    )
    _kind_name = 'SingleTaskTypeDecl'
class TypeDecl(BaseTypeDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_discriminants(self):
        """
        :rtype: DiscriminantPart
        """
        result = self._eval_astnode_field(_type_decl_f_discriminants)
        return result
    @property
    def f_type_def(self):
        """
        :rtype: TypeDef
        """
        result = self._eval_astnode_field(_type_decl_f_type_def)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_type_decl_f_aspects)
        return result
    _field_names = BaseTypeDecl._field_names + (
        "f_discriminants",
        "f_type_def",
        "f_aspects",
    )
    _kind_name = 'TypeDecl'
class AnonymousTypeDecl(TypeDecl):
    __slots__ = AdaNode.__slots__
    _field_names = TypeDecl._field_names + (
    )
    _kind_name = 'AnonymousTypeDecl'
class SynthAnonymousTypeDecl(AnonymousTypeDecl):
    """
    Synthetic anonymous type decl. Used to generate anonymous access types.
    """
    __slots__ = AdaNode.__slots__
    _field_names = AnonymousTypeDecl._field_names + (
    )
    _kind_name = 'SynthAnonymousTypeDecl'
class BasicSubpDecl(BasicDecl):
    __slots__ = AdaNode.__slots__
    @property
    def p_subp_decl_spec(self):
        """
        Return the specification for this subprogram

        :rtype: SubpSpec
        """
        c_result = self._eval_field(_Entity_c_type(), _basic_subp_decl_p_subp_decl_spec)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_body_part(self):
        """
        Return the BaseSubpBody corresponding to this node.

        :rtype: BaseSubpBody
        """
        c_result = self._eval_field(_Entity_c_type(), _basic_subp_decl_p_body_part)
        result = AdaNode._wrap(c_result)
        return result
    _field_names = BasicDecl._field_names + (
    )
class ClassicSubpDecl(BasicSubpDecl):
    """
    This is an intermediate abstract class for subprogram declarations with a
    common structure: overriding indicator, subp_spec, aspects, <other fields>.
    """
    __slots__ = AdaNode.__slots__
    @property
    def f_overriding(self):
        """
        :rtype: OverridingNode
        """
        result = self._eval_astnode_field(_classic_subp_decl_f_overriding)
        return result
    @property
    def f_subp_spec(self):
        """
        :rtype: SubpSpec
        """
        result = self._eval_astnode_field(_classic_subp_decl_f_subp_spec)
        return result
    _field_names = BasicSubpDecl._field_names + (
        "f_overriding",
        "f_subp_spec",
    )
class AbstractSubpDecl(ClassicSubpDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_abstract_subp_decl_f_aspects)
        return result
    _field_names = ClassicSubpDecl._field_names + (
        "f_aspects",
    )
    _kind_name = 'AbstractSubpDecl'
class FormalSubpDecl(ClassicSubpDecl):
    """
    Formal subprogram declarations, in generic declarations formal parts.
    """
    __slots__ = AdaNode.__slots__
    @property
    def f_default_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_formal_subp_decl_f_default_expr)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_formal_subp_decl_f_aspects)
        return result
    _field_names = ClassicSubpDecl._field_names + (
        "f_default_expr",
        "f_aspects",
    )
class AbstractFormalSubpDecl(FormalSubpDecl):
    __slots__ = AdaNode.__slots__
    _field_names = FormalSubpDecl._field_names + (
    )
    _kind_name = 'AbstractFormalSubpDecl'
class ConcreteFormalSubpDecl(FormalSubpDecl):
    __slots__ = AdaNode.__slots__
    _field_names = FormalSubpDecl._field_names + (
    )
    _kind_name = 'ConcreteFormalSubpDecl'
class NullSubpDecl(ClassicSubpDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_null_subp_decl_f_aspects)
        return result
    _field_names = ClassicSubpDecl._field_names + (
        "f_aspects",
    )
    _kind_name = 'NullSubpDecl'
class SubpDecl(ClassicSubpDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_subp_decl_f_aspects)
        return result
    _field_names = ClassicSubpDecl._field_names + (
        "f_aspects",
    )
    _kind_name = 'SubpDecl'
class SubpRenamingDecl(ClassicSubpDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_renames(self):
        """
        :rtype: RenamingClause
        """
        result = self._eval_astnode_field(_subp_renaming_decl_f_renames)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_subp_renaming_decl_f_aspects)
        return result
    _field_names = ClassicSubpDecl._field_names + (
        "f_renames",
        "f_aspects",
    )
    _kind_name = 'SubpRenamingDecl'
class GenericSubpInternal(BasicSubpDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_subp_spec(self):
        """
        :rtype: SubpSpec
        """
        result = self._eval_astnode_field(_generic_subp_internal_f_subp_spec)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_generic_subp_internal_f_aspects)
        return result
    _field_names = BasicSubpDecl._field_names + (
        "f_subp_spec",
        "f_aspects",
    )
    _kind_name = 'GenericSubpInternal'
class BodyNode(BasicDecl):
    __slots__ = AdaNode.__slots__
    @property
    def p_previous_part(self):
        """
        Return the previous part for this body. Might be a declaration or a
        body stub.

        :rtype: BasicDecl
        """
        c_result = self._eval_field(_Entity_c_type(), _body_node_p_previous_part)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_decl_part(self):
        """
        Return the decl corresponding to this node if applicable.

        :rtype: BasicDecl
        """
        c_result = self._eval_field(_Entity_c_type(), _body_node_p_decl_part)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_subunit_root(self):
        """
        If self is a subunit, return the body in which it is rooted.

        :rtype: BasicDecl
        """
        result = self._eval_astnode_field(_body_node_p_subunit_root)
        return result
    _field_names = BasicDecl._field_names + (
    )
class BaseSubpBody(BodyNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_overriding(self):
        """
        :rtype: OverridingNode
        """
        result = self._eval_astnode_field(_base_subp_body_f_overriding)
        return result
    @property
    def f_subp_spec(self):
        """
        :rtype: SubpSpec
        """
        result = self._eval_astnode_field(_base_subp_body_f_subp_spec)
        return result
    _field_names = BodyNode._field_names + (
        "f_overriding",
        "f_subp_spec",
    )
class ExprFunction(BaseSubpBody):
    __slots__ = AdaNode.__slots__
    @property
    def f_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_expr_function_f_expr)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_expr_function_f_aspects)
        return result
    _field_names = BaseSubpBody._field_names + (
        "f_expr",
        "f_aspects",
    )
    _kind_name = 'ExprFunction'
class SubpBody(BaseSubpBody):
    __slots__ = AdaNode.__slots__
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_subp_body_f_aspects)
        return result
    @property
    def f_decls(self):
        """
        :rtype: DeclarativePart
        """
        result = self._eval_astnode_field(_subp_body_f_decls)
        return result
    @property
    def f_stmts(self):
        """
        :rtype: HandledStmts
        """
        result = self._eval_astnode_field(_subp_body_f_stmts)
        return result
    @property
    def f_end_name(self):
        """
        :rtype: EndName
        """
        result = self._eval_astnode_field(_subp_body_f_end_name)
        return result
    _field_names = BaseSubpBody._field_names + (
        "f_aspects",
        "f_decls",
        "f_stmts",
        "f_end_name",
    )
    _kind_name = 'SubpBody'
class BodyStub(BodyNode):
    __slots__ = AdaNode.__slots__
    _field_names = BodyNode._field_names + (
    )
class PackageBodyStub(BodyStub):
    __slots__ = AdaNode.__slots__
    @property
    def f_name(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_package_body_stub_f_name)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_package_body_stub_f_aspects)
        return result
    _field_names = BodyStub._field_names + (
        "f_name",
        "f_aspects",
    )
    _kind_name = 'PackageBodyStub'
class ProtectedBodyStub(BodyStub):
    __slots__ = AdaNode.__slots__
    @property
    def f_name(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_protected_body_stub_f_name)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_protected_body_stub_f_aspects)
        return result
    _field_names = BodyStub._field_names + (
        "f_name",
        "f_aspects",
    )
    _kind_name = 'ProtectedBodyStub'
class SubpBodyStub(BodyStub):
    __slots__ = AdaNode.__slots__
    @property
    def f_overriding(self):
        """
        :rtype: OverridingNode
        """
        result = self._eval_astnode_field(_subp_body_stub_f_overriding)
        return result
    @property
    def f_subp_spec(self):
        """
        :rtype: SubpSpec
        """
        result = self._eval_astnode_field(_subp_body_stub_f_subp_spec)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_subp_body_stub_f_aspects)
        return result
    _field_names = BodyStub._field_names + (
        "f_overriding",
        "f_subp_spec",
        "f_aspects",
    )
    _kind_name = 'SubpBodyStub'
class TaskBodyStub(BodyStub):
    __slots__ = AdaNode.__slots__
    @property
    def f_name(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_task_body_stub_f_name)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_task_body_stub_f_aspects)
        return result
    _field_names = BodyStub._field_names + (
        "f_name",
        "f_aspects",
    )
    _kind_name = 'TaskBodyStub'
class EntryBody(BodyNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_entry_name(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_entry_body_f_entry_name)
        return result
    @property
    def f_index_spec(self):
        """
        :rtype: EntryIndexSpec
        """
        result = self._eval_astnode_field(_entry_body_f_index_spec)
        return result
    @property
    def f_params(self):
        """
        :rtype: Params
        """
        result = self._eval_astnode_field(_entry_body_f_params)
        return result
    @property
    def f_barrier(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_entry_body_f_barrier)
        return result
    @property
    def f_decls(self):
        """
        :rtype: DeclarativePart
        """
        result = self._eval_astnode_field(_entry_body_f_decls)
        return result
    @property
    def f_stmts(self):
        """
        :rtype: HandledStmts
        """
        result = self._eval_astnode_field(_entry_body_f_stmts)
        return result
    @property
    def f_end_name(self):
        """
        :rtype: EndName
        """
        result = self._eval_astnode_field(_entry_body_f_end_name)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_entry_body_f_aspects)
        return result
    _field_names = BodyNode._field_names + (
        "f_entry_name",
        "f_index_spec",
        "f_params",
        "f_barrier",
        "f_decls",
        "f_stmts",
        "f_end_name",
    )
    _kind_name = 'EntryBody'
class PackageBody(BodyNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_package_name(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_package_body_f_package_name)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_package_body_f_aspects)
        return result
    @property
    def f_decls(self):
        """
        :rtype: DeclarativePart
        """
        result = self._eval_astnode_field(_package_body_f_decls)
        return result
    @property
    def f_stmts(self):
        """
        :rtype: HandledStmts
        """
        result = self._eval_astnode_field(_package_body_f_stmts)
        return result
    @property
    def f_end_name(self):
        """
        :rtype: EndName
        """
        result = self._eval_astnode_field(_package_body_f_end_name)
        return result
    _field_names = BodyNode._field_names + (
        "f_package_name",
        "f_aspects",
        "f_decls",
        "f_stmts",
        "f_end_name",
    )
    _kind_name = 'PackageBody'
class ProtectedBody(BodyNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_name(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_protected_body_f_name)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_protected_body_f_aspects)
        return result
    @property
    def f_decls(self):
        """
        :rtype: DeclarativePart
        """
        result = self._eval_astnode_field(_protected_body_f_decls)
        return result
    @property
    def f_end_name(self):
        """
        :rtype: EndName
        """
        result = self._eval_astnode_field(_protected_body_f_end_name)
        return result
    _field_names = BodyNode._field_names + (
        "f_name",
        "f_aspects",
        "f_decls",
        "f_end_name",
    )
    _kind_name = 'ProtectedBody'
class TaskBody(BodyNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_name(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_task_body_f_name)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_task_body_f_aspects)
        return result
    @property
    def f_decls(self):
        """
        :rtype: DeclarativePart
        """
        result = self._eval_astnode_field(_task_body_f_decls)
        return result
    @property
    def f_stmts(self):
        """
        :rtype: HandledStmts
        """
        result = self._eval_astnode_field(_task_body_f_stmts)
        return result
    @property
    def f_end_name(self):
        """
        :rtype: EndName
        """
        result = self._eval_astnode_field(_task_body_f_end_name)
        return result
    _field_names = BodyNode._field_names + (
        "f_name",
        "f_aspects",
        "f_decls",
        "f_stmts",
        "f_end_name",
    )
    _kind_name = 'TaskBody'
class EntryDecl(BasicDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_overriding(self):
        """
        :rtype: OverridingNode
        """
        result = self._eval_astnode_field(_entry_decl_f_overriding)
        return result
    @property
    def f_spec(self):
        """
        :rtype: EntrySpec
        """
        result = self._eval_astnode_field(_entry_decl_f_spec)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_entry_decl_f_aspects)
        return result
    _field_names = BasicDecl._field_names + (
        "f_overriding",
        "f_spec",
        "f_aspects",
    )
    _kind_name = 'EntryDecl'
class EntryIndexSpec(BasicDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_id(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_entry_index_spec_f_id)
        return result
    @property
    def f_subtype(self):
        """
        :rtype: AdaNode
        """
        result = self._eval_astnode_field(_entry_index_spec_f_subtype)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_entry_index_spec_f_aspects)
        return result
    _field_names = BasicDecl._field_names + (
        "f_id",
        "f_subtype",
    )
    _kind_name = 'EntryIndexSpec'
class EnumLiteralDecl(BasicDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_name(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_enum_literal_decl_f_name)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_enum_literal_decl_f_aspects)
        return result
    @property
    def p_enum_type(self):
        """
        Return the enum type corresponding to this enum literal.

        :rtype: TypeDecl
        """
        c_result = self._eval_field(_Entity_c_type(), _enum_literal_decl_p_enum_type)
        result = AdaNode._wrap(c_result)
        return result
    _field_names = BasicDecl._field_names + (
        "f_name",
    )
    _kind_name = 'EnumLiteralDecl'
class ErrorDecl(BasicDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_error_decl_f_aspects)
        return result
    _field_names = BasicDecl._field_names + (
    )
    _kind_name = 'ErrorDecl'
class ExceptionDecl(BasicDecl):
    """
    Exception declarations.
    """
    __slots__ = AdaNode.__slots__
    @property
    def f_ids(self):
        """
        :rtype: DefiningNameList
        """
        result = self._eval_astnode_field(_exception_decl_f_ids)
        return result
    @property
    def f_renames(self):
        """
        :rtype: RenamingClause
        """
        result = self._eval_astnode_field(_exception_decl_f_renames)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_exception_decl_f_aspects)
        return result
    _field_names = BasicDecl._field_names + (
        "f_ids",
        "f_renames",
        "f_aspects",
    )
    _kind_name = 'ExceptionDecl'
class ExceptionHandler(BasicDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_exception_name(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_exception_handler_f_exception_name)
        return result
    @property
    def f_handled_exceptions(self):
        """
        :rtype: AlternativesList
        """
        result = self._eval_astnode_field(_exception_handler_f_handled_exceptions)
        return result
    @property
    def f_stmts(self):
        """
        :rtype: StmtList
        """
        result = self._eval_astnode_field(_exception_handler_f_stmts)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_exception_handler_f_aspects)
        return result
    _field_names = BasicDecl._field_names + (
        "f_exception_name",
        "f_handled_exceptions",
        "f_stmts",
    )
    _kind_name = 'ExceptionHandler'
class ForLoopVarDecl(BasicDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_id(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_for_loop_var_decl_f_id)
        return result
    @property
    def f_id_type(self):
        """
        :rtype: SubtypeIndication
        """
        result = self._eval_astnode_field(_for_loop_var_decl_f_id_type)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_for_loop_var_decl_f_aspects)
        return result
    _field_names = BasicDecl._field_names + (
        "f_id",
        "f_id_type",
    )
    _kind_name = 'ForLoopVarDecl'
class GenericDecl(BasicDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_formal_part(self):
        """
        :rtype: GenericFormalPart
        """
        result = self._eval_astnode_field(_generic_decl_f_formal_part)
        return result
    _field_names = BasicDecl._field_names + (
        "f_formal_part",
    )
class GenericPackageDecl(GenericDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_package_decl(self):
        """
        :rtype: GenericPackageInternal
        """
        result = self._eval_astnode_field(_generic_package_decl_f_package_decl)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_generic_package_decl_f_aspects)
        return result
    @property
    def p_body_part(self):
        """
        Return the PackageBody corresponding to this node, or null if there is
        none.

        :rtype: PackageBody
        """
        c_result = self._eval_field(_Entity_c_type(), _generic_package_decl_p_body_part)
        result = AdaNode._wrap(c_result)
        return result
    _field_names = GenericDecl._field_names + (
        "f_package_decl",
    )
    _kind_name = 'GenericPackageDecl'
class GenericSubpDecl(GenericDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_subp_decl(self):
        """
        :rtype: GenericSubpInternal
        """
        result = self._eval_astnode_field(_generic_subp_decl_f_subp_decl)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_generic_subp_decl_f_aspects)
        return result
    @property
    def p_body_part(self):
        """
        Return the BaseSubpBody corresponding to this node.

        :rtype: BaseSubpBody
        """
        c_result = self._eval_field(_Entity_c_type(), _generic_subp_decl_p_body_part)
        result = AdaNode._wrap(c_result)
        return result
    _field_names = GenericDecl._field_names + (
        "f_subp_decl",
    )
    _kind_name = 'GenericSubpDecl'
class GenericInstantiation(BasicDecl):
    """
    Instantiations of generics.
    """
    __slots__ = AdaNode.__slots__
    @property
    def p_designated_generic_decl(self):
        """
        Return the generic decl entity designated by this instantiation,
        containing the generic context. This is equivalent to the expanded
        generic unit in GNAT.

        :rtype: BasicDecl
        """
        c_result = self._eval_field(_Entity_c_type(), _generic_instantiation_p_designated_generic_decl)
        result = AdaNode._wrap(c_result)
        return result
    _field_names = BasicDecl._field_names + (
    )
class GenericPackageInstantiation(GenericInstantiation):
    __slots__ = AdaNode.__slots__
    @property
    def f_name(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_generic_package_instantiation_f_name)
        return result
    @property
    def f_generic_pkg_name(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_generic_package_instantiation_f_generic_pkg_name)
        return result
    @property
    def f_params(self):
        """
        :rtype: AssocList
        """
        result = self._eval_astnode_field(_generic_package_instantiation_f_params)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_generic_package_instantiation_f_aspects)
        return result
    _field_names = GenericInstantiation._field_names + (
        "f_name",
        "f_generic_pkg_name",
        "f_params",
        "f_aspects",
    )
    _kind_name = 'GenericPackageInstantiation'
class GenericSubpInstantiation(GenericInstantiation):
    __slots__ = AdaNode.__slots__
    @property
    def f_overriding(self):
        """
        :rtype: OverridingNode
        """
        result = self._eval_astnode_field(_generic_subp_instantiation_f_overriding)
        return result
    @property
    def f_kind(self):
        """
        :rtype: SubpKind
        """
        result = self._eval_astnode_field(_generic_subp_instantiation_f_kind)
        return result
    @property
    def f_subp_name(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_generic_subp_instantiation_f_subp_name)
        return result
    @property
    def f_generic_subp_name(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_generic_subp_instantiation_f_generic_subp_name)
        return result
    @property
    def f_params(self):
        """
        :rtype: AssocList
        """
        result = self._eval_astnode_field(_generic_subp_instantiation_f_params)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_generic_subp_instantiation_f_aspects)
        return result
    _field_names = GenericInstantiation._field_names + (
        "f_overriding",
        "f_kind",
        "f_subp_name",
        "f_generic_subp_name",
        "f_params",
        "f_aspects",
    )
    _kind_name = 'GenericSubpInstantiation'
class GenericRenamingDecl(BasicDecl):
    """
    Base node for all generic renaming declarations.
    """
    __slots__ = AdaNode.__slots__
    _field_names = BasicDecl._field_names + (
    )
class GenericPackageRenamingDecl(GenericRenamingDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_name(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_generic_package_renaming_decl_f_name)
        return result
    @property
    def f_renames(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_generic_package_renaming_decl_f_renames)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_generic_package_renaming_decl_f_aspects)
        return result
    _field_names = GenericRenamingDecl._field_names + (
        "f_name",
        "f_renames",
        "f_aspects",
    )
    _kind_name = 'GenericPackageRenamingDecl'
class GenericSubpRenamingDecl(GenericRenamingDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_kind(self):
        """
        :rtype: SubpKind
        """
        result = self._eval_astnode_field(_generic_subp_renaming_decl_f_kind)
        return result
    @property
    def f_name(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_generic_subp_renaming_decl_f_name)
        return result
    @property
    def f_renames(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_generic_subp_renaming_decl_f_renames)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_generic_subp_renaming_decl_f_aspects)
        return result
    _field_names = GenericRenamingDecl._field_names + (
        "f_kind",
        "f_name",
        "f_renames",
        "f_aspects",
    )
    _kind_name = 'GenericSubpRenamingDecl'
class LabelDecl(BasicDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_name(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_label_decl_f_name)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_label_decl_f_aspects)
        return result
    _field_names = BasicDecl._field_names + (
        "f_name",
    )
    _kind_name = 'LabelDecl'
class NamedStmtDecl(BasicDecl):
    """
    BasicDecl that is always the declaration inside a named statement.
    """
    __slots__ = AdaNode.__slots__
    @property
    def f_name(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_named_stmt_decl_f_name)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_named_stmt_decl_f_aspects)
        return result
    _field_names = BasicDecl._field_names + (
        "f_name",
    )
    _kind_name = 'NamedStmtDecl'
class NumberDecl(BasicDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_ids(self):
        """
        :rtype: DefiningNameList
        """
        result = self._eval_astnode_field(_number_decl_f_ids)
        return result
    @property
    def f_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_number_decl_f_expr)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_number_decl_f_aspects)
        return result
    _field_names = BasicDecl._field_names + (
        "f_ids",
        "f_expr",
    )
    _kind_name = 'NumberDecl'
class ObjectDecl(BasicDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_ids(self):
        """
        :rtype: DefiningNameList
        """
        result = self._eval_astnode_field(_object_decl_f_ids)
        return result
    @property
    def f_has_aliased(self):
        """
        :rtype: AliasedNode
        """
        result = self._eval_astnode_field(_object_decl_f_has_aliased)
        return result
    @property
    def f_has_constant(self):
        """
        :rtype: ConstantNode
        """
        result = self._eval_astnode_field(_object_decl_f_has_constant)
        return result
    @property
    def f_mode(self):
        """
        :rtype: Mode
        """
        result = self._eval_astnode_field(_object_decl_f_mode)
        return result
    @property
    def f_type_expr(self):
        """
        :rtype: TypeExpr
        """
        result = self._eval_astnode_field(_object_decl_f_type_expr)
        return result
    @property
    def f_default_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_object_decl_f_default_expr)
        return result
    @property
    def f_renaming_clause(self):
        """
        :rtype: RenamingClause
        """
        result = self._eval_astnode_field(_object_decl_f_renaming_clause)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_object_decl_f_aspects)
        return result
    @property
    def p_public_part_decl(self):
        """
        If this object decl is the constant completion of an object decl in the
        public part, return the object decl from the public part.

        :rtype: BasicDecl
        """
        c_result = self._eval_field(_Entity_c_type(), _object_decl_p_public_part_decl)
        result = AdaNode._wrap(c_result)
        return result
    _field_names = BasicDecl._field_names + (
        "f_ids",
        "f_has_aliased",
        "f_has_constant",
        "f_mode",
        "f_type_expr",
        "f_default_expr",
        "f_renaming_clause",
        "f_aspects",
    )
    _kind_name = 'ObjectDecl'
class ExtendedReturnStmtObjectDecl(ObjectDecl):
    __slots__ = AdaNode.__slots__
    _field_names = ObjectDecl._field_names + (
    )
    _kind_name = 'ExtendedReturnStmtObjectDecl'
class PackageRenamingDecl(BasicDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_name(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_package_renaming_decl_f_name)
        return result
    @property
    def f_renames(self):
        """
        :rtype: RenamingClause
        """
        result = self._eval_astnode_field(_package_renaming_decl_f_renames)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_package_renaming_decl_f_aspects)
        return result
    _field_names = BasicDecl._field_names + (
        "f_name",
        "f_renames",
        "f_aspects",
    )
    _kind_name = 'PackageRenamingDecl'
class SingleProtectedDecl(BasicDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_name(self):
        """
        :rtype: DefiningName
        """
        result = self._eval_astnode_field(_single_protected_decl_f_name)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_single_protected_decl_f_aspects)
        return result
    @property
    def f_interfaces(self):
        """
        :rtype: ParentList
        """
        result = self._eval_astnode_field(_single_protected_decl_f_interfaces)
        return result
    @property
    def f_definition(self):
        """
        :rtype: ProtectedDef
        """
        result = self._eval_astnode_field(_single_protected_decl_f_definition)
        return result
    _field_names = BasicDecl._field_names + (
        "f_name",
        "f_aspects",
        "f_interfaces",
        "f_definition",
    )
    _kind_name = 'SingleProtectedDecl'
class SingleTaskDecl(BasicDecl):
    __slots__ = AdaNode.__slots__
    @property
    def f_task_type(self):
        """
        :rtype: SingleTaskTypeDecl
        """
        result = self._eval_astnode_field(_single_task_decl_f_task_type)
        return result
    @property
    def f_aspects(self):
        """
        :rtype: AspectSpec
        """
        result = self._eval_astnode_field(_single_task_decl_f_aspects)
        return result
    _field_names = BasicDecl._field_names + (
        "f_task_type",
    )
    _kind_name = 'SingleTaskDecl'
class CaseStmtAlternative(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_choices(self):
        """
        :rtype: AlternativesList
        """
        result = self._eval_astnode_field(_case_stmt_alternative_f_choices)
        return result
    @property
    def f_stmts(self):
        """
        :rtype: StmtList
        """
        result = self._eval_astnode_field(_case_stmt_alternative_f_stmts)
        return result
    _field_names = AdaNode._field_names + (
        "f_choices",
        "f_stmts",
    )
    _kind_name = 'CaseStmtAlternative'
class CompilationUnit(AdaNode):
    """
    Root node for all Ada analysis units.
    """
    __slots__ = AdaNode.__slots__
    @property
    def f_prelude(self):
        """
        ``with``, ``use`` or ``pragma`` statements.

        :rtype: AdaNodeList
        """
        result = self._eval_astnode_field(_compilation_unit_f_prelude)
        return result
    @property
    def f_body(self):
        """
        :rtype: AdaNode
        """
        result = self._eval_astnode_field(_compilation_unit_f_body)
        return result
    @property
    def f_pragmas(self):
        """
        :rtype: PragmaNodeList
        """
        result = self._eval_astnode_field(_compilation_unit_f_pragmas)
        return result
    @property
    def p_syntactic_fully_qualified_name(self):
        """
        Return the syntactic fully qualified name of this compilation unit.

        :rtype: list[unicode]
        """
        c_result = self._eval_field(_UnboundedTextTypeArrayConverter.c_type(), _compilation_unit_p_syntactic_fully_qualified_name)
        result = _UnboundedTextTypeArrayConverter.wrap(c_result)
        return result
    @property
    def p_unit_kind(self):
        """
        Return the kind corresponding to this analysis unit.

        :rtype: str
        """
        c_result = self._eval_field(ctypes.c_int(), _compilation_unit_p_unit_kind)
        result = AnalysisUnitKind._wrap(c_result)
        return result
    _field_names = AdaNode._field_names + (
        "f_prelude",
        "f_body",
        "f_pragmas",
    )
    _kind_name = 'CompilationUnit'
class ComponentClause(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_id(self):
        """
        :rtype: Identifier
        """
        result = self._eval_astnode_field(_component_clause_f_id)
        return result
    @property
    def f_position(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_component_clause_f_position)
        return result
    @property
    def f_range(self):
        """
        :rtype: RangeSpec
        """
        result = self._eval_astnode_field(_component_clause_f_range)
        return result
    _field_names = AdaNode._field_names + (
        "f_id",
        "f_position",
        "f_range",
    )
    _kind_name = 'ComponentClause'
class ComponentDef(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_has_aliased(self):
        """
        :rtype: AliasedNode
        """
        result = self._eval_astnode_field(_component_def_f_has_aliased)
        return result
    @property
    def f_has_constant(self):
        """
        :rtype: ConstantNode
        """
        result = self._eval_astnode_field(_component_def_f_has_constant)
        return result
    @property
    def f_type_expr(self):
        """
        :rtype: TypeExpr
        """
        result = self._eval_astnode_field(_component_def_f_type_expr)
        return result
    _field_names = AdaNode._field_names + (
        "f_has_aliased",
        "f_has_constant",
        "f_type_expr",
    )
    _kind_name = 'ComponentDef'
class ConstantNode(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def p_as_bool(self):
        """
        Return whether this is an instance of ConstantPresent

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _constant_node_p_as_bool)
        result = bool(c_result.value)
        return result
    _field_names = AdaNode._field_names + (
    )
class ConstantAbsent(ConstantNode):
    __slots__ = AdaNode.__slots__
    _field_names = ConstantNode._field_names + (
    )
    _kind_name = 'ConstantAbsent'
class ConstantPresent(ConstantNode):
    __slots__ = AdaNode.__slots__
    _field_names = ConstantNode._field_names + (
    )
    _kind_name = 'ConstantPresent'
class Constraint(AdaNode):
    __slots__ = AdaNode.__slots__
    _field_names = AdaNode._field_names + (
    )
class DeltaConstraint(Constraint):
    __slots__ = AdaNode.__slots__
    @property
    def f_digits(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_delta_constraint_f_digits)
        return result
    @property
    def f_range(self):
        """
        :rtype: RangeSpec
        """
        result = self._eval_astnode_field(_delta_constraint_f_range)
        return result
    _field_names = Constraint._field_names + (
        "f_digits",
        "f_range",
    )
    _kind_name = 'DeltaConstraint'
class DigitsConstraint(Constraint):
    __slots__ = AdaNode.__slots__
    @property
    def f_digits(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_digits_constraint_f_digits)
        return result
    @property
    def f_range(self):
        """
        :rtype: RangeSpec
        """
        result = self._eval_astnode_field(_digits_constraint_f_range)
        return result
    _field_names = Constraint._field_names + (
        "f_digits",
        "f_range",
    )
    _kind_name = 'DigitsConstraint'
class DiscriminantConstraint(Constraint):
    __slots__ = AdaNode.__slots__
    @property
    def f_constraints(self):
        """
        :rtype: AssocList
        """
        result = self._eval_astnode_field(_discriminant_constraint_f_constraints)
        return result
    _field_names = Constraint._field_names + (
        "f_constraints",
    )
    _kind_name = 'DiscriminantConstraint'
class IndexConstraint(Constraint):
    __slots__ = AdaNode.__slots__
    @property
    def f_constraints(self):
        """
        :rtype: ConstraintList
        """
        result = self._eval_astnode_field(_index_constraint_f_constraints)
        return result
    _field_names = Constraint._field_names + (
        "f_constraints",
    )
    _kind_name = 'IndexConstraint'
class RangeConstraint(Constraint):
    __slots__ = AdaNode.__slots__
    @property
    def f_range(self):
        """
        :rtype: RangeSpec
        """
        result = self._eval_astnode_field(_range_constraint_f_range)
        return result
    _field_names = Constraint._field_names + (
        "f_range",
    )
    _kind_name = 'RangeConstraint'
class DeclarativePart(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_decls(self):
        """
        :rtype: AdaNodeList
        """
        result = self._eval_astnode_field(_declarative_part_f_decls)
        return result
    _field_names = AdaNode._field_names + (
        "f_decls",
    )
    _kind_name = 'DeclarativePart'
class PrivatePart(DeclarativePart):
    __slots__ = AdaNode.__slots__
    _field_names = DeclarativePart._field_names + (
    )
    _kind_name = 'PrivatePart'
class PublicPart(DeclarativePart):
    __slots__ = AdaNode.__slots__
    _field_names = DeclarativePart._field_names + (
    )
    _kind_name = 'PublicPart'
class ElsifExprPart(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_cond_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_elsif_expr_part_f_cond_expr)
        return result
    @property
    def f_then_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_elsif_expr_part_f_then_expr)
        return result
    _field_names = AdaNode._field_names + (
        "f_cond_expr",
        "f_then_expr",
    )
    _kind_name = 'ElsifExprPart'
class ElsifStmtPart(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_cond_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_elsif_stmt_part_f_cond_expr)
        return result
    @property
    def f_stmts(self):
        """
        :rtype: StmtList
        """
        result = self._eval_astnode_field(_elsif_stmt_part_f_stmts)
        return result
    _field_names = AdaNode._field_names + (
        "f_cond_expr",
        "f_stmts",
    )
    _kind_name = 'ElsifStmtPart'
class Expr(AdaNode):
    __slots__ = AdaNode.__slots__
    def p_is_static_expr(self, imprecise_fallback=False):
        """
        Return whether this expression is static according to the ARM
        definition of static. See RM 4.9.

        :rtype: bool
        """
        unwrapped_imprecise_fallback = bool(imprecise_fallback)
        c_result = self._eval_field(ctypes.c_uint8(), _expr_p_is_static_expr, unwrapped_imprecise_fallback)
        result = bool(c_result.value)
        return result
    @property
    def p_first_corresponding_decl(self):
        """
        Return the first decl that is lexically named like self in self's
        scope.

        :rtype: BasicDecl
        """
        c_result = self._eval_field(_Entity_c_type(), _expr_p_first_corresponding_decl)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_eval_as_int(self):
        """
        Statically evaluates self, and returns the value of the evaluation as
        an integer.

        :rtype: int
        """
        c_result = self._eval_field(_big_integer.c_type(), _expr_p_eval_as_int)
        result = _big_integer.wrap(c_result)
        return result
    @property
    def p_matching_nodes(self):
        """
        Return the list of AST nodes that can be a match for this expression
        before overloading analysis.

        :rtype: list[AdaNode]
        """
        c_result = self._eval_field(_AdaNodeArrayConverter.c_type(), _expr_p_matching_nodes)
        result = _AdaNodeArrayConverter.wrap(c_result)
        return result
    _field_names = AdaNode._field_names + (
    )
class Allocator(Expr):
    __slots__ = AdaNode.__slots__
    @property
    def f_subpool(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_allocator_f_subpool)
        return result
    @property
    def f_type_or_expr(self):
        """
        :rtype: AdaNode
        """
        result = self._eval_astnode_field(_allocator_f_type_or_expr)
        return result
    @property
    def p_get_allocated_type(self):
        """
        Return the allocated type for this allocator.

        :rtype: BaseTypeDecl
        """
        c_result = self._eval_field(_Entity_c_type(), _allocator_p_get_allocated_type)
        result = AdaNode._wrap(c_result)
        return result
    _field_names = Expr._field_names + (
        "f_subpool",
        "f_type_or_expr",
    )
    _kind_name = 'Allocator'
class BaseAggregate(Expr):
    __slots__ = AdaNode.__slots__
    @property
    def f_ancestor_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_base_aggregate_f_ancestor_expr)
        return result
    @property
    def f_assocs(self):
        """
        :rtype: AssocList
        """
        result = self._eval_astnode_field(_base_aggregate_f_assocs)
        return result
    _field_names = Expr._field_names + (
        "f_ancestor_expr",
        "f_assocs",
    )
class Aggregate(BaseAggregate):
    __slots__ = AdaNode.__slots__
    _field_names = BaseAggregate._field_names + (
    )
    _kind_name = 'Aggregate'
class NullRecordAggregate(BaseAggregate):
    __slots__ = AdaNode.__slots__
    _field_names = BaseAggregate._field_names + (
    )
    _kind_name = 'NullRecordAggregate'
class BinOp(Expr):
    __slots__ = AdaNode.__slots__
    @property
    def f_left(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_bin_op_f_left)
        return result
    @property
    def f_op(self):
        """
        :rtype: Op
        """
        result = self._eval_astnode_field(_bin_op_f_op)
        return result
    @property
    def f_right(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_bin_op_f_right)
        return result
    _field_names = Expr._field_names + (
        "f_left",
        "f_op",
        "f_right",
    )
    _kind_name = 'BinOp'
class RelationOp(BinOp):
    __slots__ = AdaNode.__slots__
    _field_names = BinOp._field_names + (
    )
    _kind_name = 'RelationOp'
class BoxExpr(Expr):
    __slots__ = AdaNode.__slots__
    _field_names = Expr._field_names + (
    )
    _kind_name = 'BoxExpr'
class CaseExpr(Expr):
    __slots__ = AdaNode.__slots__
    @property
    def f_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_case_expr_f_expr)
        return result
    @property
    def f_cases(self):
        """
        :rtype: CaseExprAlternativeList
        """
        result = self._eval_astnode_field(_case_expr_f_cases)
        return result
    _field_names = Expr._field_names + (
        "f_expr",
        "f_cases",
    )
    _kind_name = 'CaseExpr'
class CaseExprAlternative(Expr):
    __slots__ = AdaNode.__slots__
    @property
    def f_choices(self):
        """
        :rtype: AlternativesList
        """
        result = self._eval_astnode_field(_case_expr_alternative_f_choices)
        return result
    @property
    def f_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_case_expr_alternative_f_expr)
        return result
    _field_names = Expr._field_names + (
        "f_choices",
        "f_expr",
    )
    _kind_name = 'CaseExprAlternative'
class ContractCases(Expr):
    __slots__ = AdaNode.__slots__
    @property
    def f_contract_cases(self):
        """
        :rtype: ContractCaseAssocList
        """
        result = self._eval_astnode_field(_contract_cases_f_contract_cases)
        return result
    _field_names = Expr._field_names + (
        "f_contract_cases",
    )
    _kind_name = 'ContractCases'
class IfExpr(Expr):
    __slots__ = AdaNode.__slots__
    @property
    def f_cond_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_if_expr_f_cond_expr)
        return result
    @property
    def f_then_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_if_expr_f_then_expr)
        return result
    @property
    def f_alternatives(self):
        """
        :rtype: ElsifExprPartList
        """
        result = self._eval_astnode_field(_if_expr_f_alternatives)
        return result
    @property
    def f_else_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_if_expr_f_else_expr)
        return result
    _field_names = Expr._field_names + (
        "f_cond_expr",
        "f_then_expr",
        "f_alternatives",
        "f_else_expr",
    )
    _kind_name = 'IfExpr'
class MembershipExpr(Expr):
    """
    Represent a membership test (in/not in operators).

    Note that we don't consider them as binary operators since multiple
    expressions on the right hand side are allowed.
    """
    __slots__ = AdaNode.__slots__
    @property
    def f_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_membership_expr_f_expr)
        return result
    @property
    def f_op(self):
        """
        :rtype: Op
        """
        result = self._eval_astnode_field(_membership_expr_f_op)
        return result
    @property
    def f_membership_exprs(self):
        """
        :rtype: ExprAlternativesList
        """
        result = self._eval_astnode_field(_membership_expr_f_membership_exprs)
        return result
    _field_names = Expr._field_names + (
        "f_expr",
        "f_op",
        "f_membership_exprs",
    )
    _kind_name = 'MembershipExpr'
class Name(Expr):
    """
    Base class for names.
    """
    __slots__ = AdaNode.__slots__
    @property
    def p_enclosing_defining_name(self):
        """
        If this name is part of a defining name, return the enclosing defining
        name node.

        :rtype: DefiningName
        """
        c_result = self._eval_field(_Entity_c_type(), _name_p_enclosing_defining_name)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_is_defining(self):
        """
        Return True if this name is part of a defining name.

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _name_p_is_defining)
        result = bool(c_result.value)
        return result
    def p_name_is(self, sym):
        """
        Helper. Check that this name matches ``sym``.

        :rtype: bool
        """
        _context = self.unit.context._c_value
        unwrapped_sym = _symbol_type.unwrap(sym, _context)
        c_result = self._eval_field(ctypes.c_uint8(), _name_p_name_is, unwrapped_sym)
        result = bool(c_result.value)
        return result
    @property
    def p_is_call(self):
        """
        Returns True if this Name corresponds to a call.

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _name_p_is_call)
        result = bool(c_result.value)
        return result
    def p_is_dot_call(self, imprecise_fallback=False):
        """
        Returns True if this Name corresponds to a dot notation call.

        :rtype: bool
        """
        unwrapped_imprecise_fallback = bool(imprecise_fallback)
        c_result = self._eval_field(ctypes.c_uint8(), _name_p_is_dot_call, unwrapped_imprecise_fallback)
        result = bool(c_result.value)
        return result
    def p_referenced_id(self, ref_decl):
        """
        Like ``referenced_decl``, but will return the defining identifier for
        the decl, rather than the basic declaration node itself.

        :rtype: DefiningName
        """
        unwrapped_ref_decl = AdaNode._unwrap(ref_decl)
        c_result = self._eval_field(_Entity_c_type(), _name_p_referenced_id, unwrapped_ref_decl)
        result = AdaNode._wrap(c_result)
        return result
    def p_all_env_elements(self, seq=True, seq_from=None):
        """
        Return all elements in self's scope that are lexically named like Self.

        :rtype: list[AdaNode]
        """
        unwrapped_seq = bool(seq)
        unwrapped_seq_from = AdaNode._unwrap(seq_from)
        c_result = self._eval_field(_AdaNodeArrayConverter.c_type(), _name_p_all_env_elements, unwrapped_seq, unwrapped_seq_from)
        result = _AdaNodeArrayConverter.wrap(c_result)
        return result
    @property
    def p_name_designated_type(self):
        """
        Like SubtypeIndication.designated_type, but on names, since because of
        Ada's ambiguous grammar, some subtype indications will be parsed as
        names.

        :rtype: BaseTypeDecl
        """
        c_result = self._eval_field(_Entity_c_type(), _name_p_name_designated_type)
        result = AdaNode._wrap(c_result)
        return result
    def p_name_matches(self, n):
        """
        Return whether two names match each other.

        This compares the symbol for Identifier and StringLiteral nodes. We
        consider that there is no match for all other node kinds.

        :rtype: bool
        """
        unwrapped_n = AdaNode._unwrap(n)
        c_result = self._eval_field(ctypes.c_uint8(), _name_p_name_matches, unwrapped_n)
        result = bool(c_result.value)
        return result
    @property
    def p_relative_name(self):
        """
        Returns the relative name of this instance. For example, for a prefix
        A.B.C, this will return C.

        :rtype: SingleTokNode
        """
        c_result = self._eval_field(_Entity_c_type(), _name_p_relative_name)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_as_symbol_array(self):
        """
        Turn this name into an array of symbols.

        For instance, a node with name ``A.B.C`` is turned into ``['A', 'B',
        'C']``.

        :rtype: list[unicode]
        """
        c_result = self._eval_field(_UnboundedTextTypeArrayConverter.c_type(), _name_p_as_symbol_array)
        result = _UnboundedTextTypeArrayConverter.wrap(c_result)
        return result
    _field_names = Expr._field_names + (
    )
class AttributeRef(Name):
    __slots__ = AdaNode.__slots__
    @property
    def f_prefix(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_attribute_ref_f_prefix)
        return result
    @property
    def f_attribute(self):
        """
        :rtype: Identifier
        """
        result = self._eval_astnode_field(_attribute_ref_f_attribute)
        return result
    @property
    def f_args(self):
        """
        :rtype: AdaNode
        """
        result = self._eval_astnode_field(_attribute_ref_f_args)
        return result
    _field_names = Name._field_names + (
        "f_prefix",
        "f_attribute",
        "f_args",
    )
    _kind_name = 'AttributeRef'
class UpdateAttributeRef(AttributeRef):
    __slots__ = AdaNode.__slots__
    _field_names = AttributeRef._field_names + (
    )
    _kind_name = 'UpdateAttributeRef'
class CallExpr(Name):
    """
    Represent a syntactic call expression.

    At the semantic level, this can be either a subprogram call, an array
    subcomponent access expression, an array slice or a type conversion.
    """
    __slots__ = AdaNode.__slots__
    @property
    def f_name(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_call_expr_f_name)
        return result
    @property
    def f_suffix(self):
        """
        :rtype: AdaNode
        """
        result = self._eval_astnode_field(_call_expr_f_suffix)
        return result
    _field_names = Name._field_names + (
        "f_name",
        "f_suffix",
    )
    _kind_name = 'CallExpr'
class DefiningName(Name):
    __slots__ = AdaNode.__slots__
    @property
    def f_name(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_defining_name_f_name)
        return result
    @property
    def p_basic_decl(self):
        """
        Returns this DefiningName's basic declaration

        :rtype: BasicDecl
        """
        c_result = self._eval_field(_Entity_c_type(), _defining_name_p_basic_decl)
        result = AdaNode._wrap(c_result)
        return result
    def p_find_all_references(self, units, imprecise_fallback=False):
        """
        Searches all references to this defining name in the given list of
        units.

        :rtype: list[AdaNode]
        """
        unwrapped_units = _AnalysisUnitArrayConverter.unwrap(units)
        unwrapped_imprecise_fallback = bool(imprecise_fallback)
        c_result = self._eval_field(_AdaNodeArrayConverter.c_type(), _defining_name_p_find_all_references, unwrapped_units.c_value, unwrapped_imprecise_fallback)
        result = _AdaNodeArrayConverter.wrap(c_result)
        return result
    @property
    def p_next_part(self):
        """
        Like ``BasicDecl.next_part_for_decl`` on a defining name

        :rtype: DefiningName
        """
        c_result = self._eval_field(_Entity_c_type(), _defining_name_p_next_part)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_previous_part(self):
        """
        Like ``BasicDecl.previous_part_for_decl`` on a defining name

        :rtype: DefiningName
        """
        c_result = self._eval_field(_Entity_c_type(), _defining_name_p_previous_part)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_canonical_part(self):
        """
        Like ``BasicDecl.canonical_part`` on a defining name

        :rtype: DefiningName
        """
        c_result = self._eval_field(_Entity_c_type(), _defining_name_p_canonical_part)
        result = AdaNode._wrap(c_result)
        return result
    _field_names = Name._field_names + (
        "f_name",
    )
    _kind_name = 'DefiningName'
class DiscreteSubtypeName(Name):
    __slots__ = AdaNode.__slots__
    @property
    def f_subtype(self):
        """
        :rtype: DiscreteSubtypeIndication
        """
        result = self._eval_astnode_field(_discrete_subtype_name_f_subtype)
        return result
    _field_names = Name._field_names + (
        "f_subtype",
    )
    _kind_name = 'DiscreteSubtypeName'
class DottedName(Name):
    __slots__ = AdaNode.__slots__
    @property
    def f_prefix(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_dotted_name_f_prefix)
        return result
    @property
    def f_suffix(self):
        """
        :rtype: BaseId
        """
        result = self._eval_astnode_field(_dotted_name_f_suffix)
        return result
    _field_names = Name._field_names + (
        "f_prefix",
        "f_suffix",
    )
    _kind_name = 'DottedName'
class EndName(Name):
    __slots__ = AdaNode.__slots__
    @property
    def f_name(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_end_name_f_name)
        return result
    @property
    def p_basic_decl(self):
        """
        Returns this EndName's basic declaration

        :rtype: BasicDecl
        """
        c_result = self._eval_field(_Entity_c_type(), _end_name_p_basic_decl)
        result = AdaNode._wrap(c_result)
        return result
    _field_names = Name._field_names + (
        "f_name",
    )
    _kind_name = 'EndName'
class ExplicitDeref(Name):
    __slots__ = AdaNode.__slots__
    @property
    def f_prefix(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_explicit_deref_f_prefix)
        return result
    _field_names = Name._field_names + (
        "f_prefix",
    )
    _kind_name = 'ExplicitDeref'
class QualExpr(Name):
    __slots__ = AdaNode.__slots__
    @property
    def f_prefix(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_qual_expr_f_prefix)
        return result
    @property
    def f_suffix(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_qual_expr_f_suffix)
        return result
    _field_names = Name._field_names + (
        "f_prefix",
        "f_suffix",
    )
    _kind_name = 'QualExpr'
class SingleTokNode(Name):
    __slots__ = AdaNode.__slots__
    _field_names = Name._field_names + (
    )
class BaseId(SingleTokNode):
    __slots__ = AdaNode.__slots__
    _field_names = SingleTokNode._field_names + (
    )
class CharLiteral(BaseId):
    __slots__ = AdaNode.__slots__
    @property
    def p_denoted_value(self):
        """
        Return the value that this literal denotes.

        :rtype: unicode
        """
        c_result = self._eval_field(ctypes.c_uint32(), _char_literal_p_denoted_value)
        result = unichr(c_result.value)
        return result
    _field_names = BaseId._field_names + (
    )
    _kind_name = 'CharLiteral'
class Identifier(BaseId):
    __slots__ = AdaNode.__slots__
    _field_names = BaseId._field_names + (
    )
    _kind_name = 'Identifier'
class StringLiteral(BaseId):
    __slots__ = AdaNode.__slots__
    @property
    def p_denoted_value(self):
        """
        Return the value that this literal denotes.

        :rtype: list[unicode]
        """
        c_result = self._eval_field(_TextTypeConverter.c_type(), _string_literal_p_denoted_value)
        result = _TextTypeConverter.wrap(c_result)
        return result
    _field_names = BaseId._field_names + (
    )
    _kind_name = 'StringLiteral'
class NullLiteral(SingleTokNode):
    __slots__ = AdaNode.__slots__
    _field_names = SingleTokNode._field_names + (
    )
    _kind_name = 'NullLiteral'
class NumLiteral(SingleTokNode):
    __slots__ = AdaNode.__slots__
    _field_names = SingleTokNode._field_names + (
    )
class IntLiteral(NumLiteral):
    __slots__ = AdaNode.__slots__
    @property
    def p_denoted_value(self):
        """
        Return the value that this literal denotes.

        :rtype: int
        """
        c_result = self._eval_field(_big_integer.c_type(), _int_literal_p_denoted_value)
        result = _big_integer.wrap(c_result)
        return result
    _field_names = NumLiteral._field_names + (
    )
    _kind_name = 'IntLiteral'
class RealLiteral(NumLiteral):
    __slots__ = AdaNode.__slots__
    _field_names = NumLiteral._field_names + (
    )
    _kind_name = 'RealLiteral'
class TargetName(Name):
    __slots__ = AdaNode.__slots__
    _field_names = Name._field_names + (
    )
    _kind_name = 'TargetName'
class ParenExpr(Expr):
    __slots__ = AdaNode.__slots__
    @property
    def f_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_paren_expr_f_expr)
        return result
    _field_names = Expr._field_names + (
        "f_expr",
    )
    _kind_name = 'ParenExpr'
class QuantifiedExpr(Expr):
    __slots__ = AdaNode.__slots__
    @property
    def f_quantifier(self):
        """
        :rtype: Quantifier
        """
        result = self._eval_astnode_field(_quantified_expr_f_quantifier)
        return result
    @property
    def f_loop_spec(self):
        """
        :rtype: ForLoopSpec
        """
        result = self._eval_astnode_field(_quantified_expr_f_loop_spec)
        return result
    @property
    def f_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_quantified_expr_f_expr)
        return result
    _field_names = Expr._field_names + (
        "f_quantifier",
        "f_loop_spec",
        "f_expr",
    )
    _kind_name = 'QuantifiedExpr'
class RaiseExpr(Expr):
    __slots__ = AdaNode.__slots__
    @property
    def f_exception_name(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_raise_expr_f_exception_name)
        return result
    @property
    def f_error_message(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_raise_expr_f_error_message)
        return result
    _field_names = Expr._field_names + (
        "f_exception_name",
        "f_error_message",
    )
    _kind_name = 'RaiseExpr'
class UnOp(Expr):
    __slots__ = AdaNode.__slots__
    @property
    def f_op(self):
        """
        :rtype: Op
        """
        result = self._eval_astnode_field(_un_op_f_op)
        return result
    @property
    def f_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_un_op_f_expr)
        return result
    _field_names = Expr._field_names + (
        "f_op",
        "f_expr",
    )
    _kind_name = 'UnOp'
class HandledStmts(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_stmts(self):
        """
        :rtype: StmtList
        """
        result = self._eval_astnode_field(_handled_stmts_f_stmts)
        return result
    @property
    def f_exceptions(self):
        """
        :rtype: AdaNodeList
        """
        result = self._eval_astnode_field(_handled_stmts_f_exceptions)
        return result
    _field_names = AdaNode._field_names + (
        "f_stmts",
        "f_exceptions",
    )
    _kind_name = 'HandledStmts'
class InterfaceKind(AdaNode):
    __slots__ = AdaNode.__slots__
    _field_names = AdaNode._field_names + (
    )
class InterfaceKindLimited(InterfaceKind):
    __slots__ = AdaNode.__slots__
    _field_names = InterfaceKind._field_names + (
    )
    _kind_name = 'InterfaceKindLimited'
class InterfaceKindProtected(InterfaceKind):
    __slots__ = AdaNode.__slots__
    _field_names = InterfaceKind._field_names + (
    )
    _kind_name = 'InterfaceKindProtected'
class InterfaceKindSynchronized(InterfaceKind):
    __slots__ = AdaNode.__slots__
    _field_names = InterfaceKind._field_names + (
    )
    _kind_name = 'InterfaceKindSynchronized'
class InterfaceKindTask(InterfaceKind):
    __slots__ = AdaNode.__slots__
    _field_names = InterfaceKind._field_names + (
    )
    _kind_name = 'InterfaceKindTask'
class IterType(AdaNode):
    __slots__ = AdaNode.__slots__
    _field_names = AdaNode._field_names + (
    )
class IterTypeIn(IterType):
    __slots__ = AdaNode.__slots__
    _field_names = IterType._field_names + (
    )
    _kind_name = 'IterTypeIn'
class IterTypeOf(IterType):
    __slots__ = AdaNode.__slots__
    _field_names = IterType._field_names + (
    )
    _kind_name = 'IterTypeOf'
class LibraryItem(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_has_private(self):
        """
        :rtype: PrivateNode
        """
        result = self._eval_astnode_field(_library_item_f_has_private)
        return result
    @property
    def f_item(self):
        """
        :rtype: BasicDecl
        """
        result = self._eval_astnode_field(_library_item_f_item)
        return result
    _field_names = AdaNode._field_names + (
        "f_has_private",
        "f_item",
    )
    _kind_name = 'LibraryItem'
class LimitedNode(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def p_as_bool(self):
        """
        Return whether this is an instance of LimitedPresent

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _limited_node_p_as_bool)
        result = bool(c_result.value)
        return result
    _field_names = AdaNode._field_names + (
    )
class LimitedAbsent(LimitedNode):
    __slots__ = AdaNode.__slots__
    _field_names = LimitedNode._field_names + (
    )
    _kind_name = 'LimitedAbsent'
class LimitedPresent(LimitedNode):
    __slots__ = AdaNode.__slots__
    _field_names = LimitedNode._field_names + (
    )
    _kind_name = 'LimitedPresent'
class LoopSpec(AdaNode):
    __slots__ = AdaNode.__slots__
    _field_names = AdaNode._field_names + (
    )
class ForLoopSpec(LoopSpec):
    __slots__ = AdaNode.__slots__
    @property
    def f_var_decl(self):
        """
        :rtype: ForLoopVarDecl
        """
        result = self._eval_astnode_field(_for_loop_spec_f_var_decl)
        return result
    @property
    def f_loop_type(self):
        """
        :rtype: IterType
        """
        result = self._eval_astnode_field(_for_loop_spec_f_loop_type)
        return result
    @property
    def f_has_reverse(self):
        """
        :rtype: ReverseNode
        """
        result = self._eval_astnode_field(_for_loop_spec_f_has_reverse)
        return result
    @property
    def f_iter_expr(self):
        """
        :rtype: AdaNode
        """
        result = self._eval_astnode_field(_for_loop_spec_f_iter_expr)
        return result
    _field_names = LoopSpec._field_names + (
        "f_var_decl",
        "f_loop_type",
        "f_has_reverse",
        "f_iter_expr",
    )
    _kind_name = 'ForLoopSpec'
class WhileLoopSpec(LoopSpec):
    __slots__ = AdaNode.__slots__
    @property
    def f_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_while_loop_spec_f_expr)
        return result
    _field_names = LoopSpec._field_names + (
        "f_expr",
    )
    _kind_name = 'WhileLoopSpec'
class Mode(AdaNode):
    __slots__ = AdaNode.__slots__
    _field_names = AdaNode._field_names + (
    )
class ModeDefault(Mode):
    __slots__ = AdaNode.__slots__
    _field_names = Mode._field_names + (
    )
    _kind_name = 'ModeDefault'
class ModeIn(Mode):
    __slots__ = AdaNode.__slots__
    _field_names = Mode._field_names + (
    )
    _kind_name = 'ModeIn'
class ModeInOut(Mode):
    __slots__ = AdaNode.__slots__
    _field_names = Mode._field_names + (
    )
    _kind_name = 'ModeInOut'
class ModeOut(Mode):
    __slots__ = AdaNode.__slots__
    _field_names = Mode._field_names + (
    )
    _kind_name = 'ModeOut'
class NotNull(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def p_as_bool(self):
        """
        Return whether this is an instance of NotNullPresent

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _not_null_p_as_bool)
        result = bool(c_result.value)
        return result
    _field_names = AdaNode._field_names + (
    )
class NotNullAbsent(NotNull):
    __slots__ = AdaNode.__slots__
    _field_names = NotNull._field_names + (
    )
    _kind_name = 'NotNullAbsent'
class NotNullPresent(NotNull):
    __slots__ = AdaNode.__slots__
    _field_names = NotNull._field_names + (
    )
    _kind_name = 'NotNullPresent'
class NullComponentDecl(AdaNode):
    __slots__ = AdaNode.__slots__
    _field_names = AdaNode._field_names + (
    )
    _kind_name = 'NullComponentDecl'
class Op(AdaNode):
    """
    Operation in a binary expression.

    Note that the ARM does not consider "double_dot" ("..") as a binary
    operator, but we process it this way here anyway to keep things simple.
    """
    __slots__ = AdaNode.__slots__
    _field_names = AdaNode._field_names + (
    )
class OpAbs(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpAbs'
class OpAnd(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpAnd'
class OpAndThen(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpAndThen'
class OpConcat(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpConcat'
class OpDiv(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpDiv'
class OpDoubleDot(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpDoubleDot'
class OpEq(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpEq'
class OpGt(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpGt'
class OpGte(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpGte'
class OpIn(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpIn'
class OpLt(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpLt'
class OpLte(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpLte'
class OpMinus(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpMinus'
class OpMod(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpMod'
class OpMult(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpMult'
class OpNeq(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpNeq'
class OpNot(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpNot'
class OpNotIn(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpNotIn'
class OpOr(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpOr'
class OpOrElse(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpOrElse'
class OpPlus(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpPlus'
class OpPow(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpPow'
class OpRem(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpRem'
class OpXor(Op):
    __slots__ = AdaNode.__slots__
    _field_names = Op._field_names + (
    )
    _kind_name = 'OpXor'
class OthersDesignator(AdaNode):
    __slots__ = AdaNode.__slots__
    _field_names = AdaNode._field_names + (
    )
    _kind_name = 'OthersDesignator'
class OverridingNode(AdaNode):
    __slots__ = AdaNode.__slots__
    _field_names = AdaNode._field_names + (
    )
class OverridingNotOverriding(OverridingNode):
    __slots__ = AdaNode.__slots__
    _field_names = OverridingNode._field_names + (
    )
    _kind_name = 'OverridingNotOverriding'
class OverridingOverriding(OverridingNode):
    __slots__ = AdaNode.__slots__
    _field_names = OverridingNode._field_names + (
    )
    _kind_name = 'OverridingOverriding'
class OverridingUnspecified(OverridingNode):
    __slots__ = AdaNode.__slots__
    _field_names = OverridingNode._field_names + (
    )
    _kind_name = 'OverridingUnspecified'
class Params(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_params(self):
        """
        :rtype: ParamSpecList
        """
        result = self._eval_astnode_field(_params_f_params)
        return result
    _field_names = AdaNode._field_names + (
        "f_params",
    )
    _kind_name = 'Params'
class PragmaNode(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_id(self):
        """
        :rtype: Identifier
        """
        result = self._eval_astnode_field(_pragma_node_f_id)
        return result
    @property
    def f_args(self):
        """
        :rtype: BaseAssocList
        """
        result = self._eval_astnode_field(_pragma_node_f_args)
        return result
    @property
    def p_associated_decls(self):
        """
        Return an array of ``BasicDecl`` instances associated with this pragma,
        or an empty array if non applicable.

        :rtype: list[BasicDecl]
        """
        c_result = self._eval_field(_AdaNodeArrayConverter.c_type(), _pragma_node_p_associated_decls)
        result = _AdaNodeArrayConverter.wrap(c_result)
        return result
    _field_names = AdaNode._field_names + (
        "f_id",
        "f_args",
    )
    _kind_name = 'PragmaNode'
class PrivateNode(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def p_as_bool(self):
        """
        Return whether this is an instance of PrivatePresent

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _private_node_p_as_bool)
        result = bool(c_result.value)
        return result
    _field_names = AdaNode._field_names + (
    )
class PrivateAbsent(PrivateNode):
    __slots__ = AdaNode.__slots__
    _field_names = PrivateNode._field_names + (
    )
    _kind_name = 'PrivateAbsent'
class PrivatePresent(PrivateNode):
    __slots__ = AdaNode.__slots__
    _field_names = PrivateNode._field_names + (
    )
    _kind_name = 'PrivatePresent'
class ProtectedDef(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_public_part(self):
        """
        :rtype: PublicPart
        """
        result = self._eval_astnode_field(_protected_def_f_public_part)
        return result
    @property
    def f_private_part(self):
        """
        :rtype: PrivatePart
        """
        result = self._eval_astnode_field(_protected_def_f_private_part)
        return result
    @property
    def f_end_name(self):
        """
        :rtype: EndName
        """
        result = self._eval_astnode_field(_protected_def_f_end_name)
        return result
    _field_names = AdaNode._field_names + (
        "f_public_part",
        "f_private_part",
        "f_end_name",
    )
    _kind_name = 'ProtectedDef'
class ProtectedNode(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def p_as_bool(self):
        """
        Return whether this is an instance of ProtectedPresent

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _protected_node_p_as_bool)
        result = bool(c_result.value)
        return result
    _field_names = AdaNode._field_names + (
    )
class ProtectedAbsent(ProtectedNode):
    __slots__ = AdaNode.__slots__
    _field_names = ProtectedNode._field_names + (
    )
    _kind_name = 'ProtectedAbsent'
class ProtectedPresent(ProtectedNode):
    __slots__ = AdaNode.__slots__
    _field_names = ProtectedNode._field_names + (
    )
    _kind_name = 'ProtectedPresent'
class Quantifier(AdaNode):
    __slots__ = AdaNode.__slots__
    _field_names = AdaNode._field_names + (
    )
class QuantifierAll(Quantifier):
    __slots__ = AdaNode.__slots__
    _field_names = Quantifier._field_names + (
    )
    _kind_name = 'QuantifierAll'
class QuantifierSome(Quantifier):
    __slots__ = AdaNode.__slots__
    _field_names = Quantifier._field_names + (
    )
    _kind_name = 'QuantifierSome'
class RangeSpec(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_range(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_range_spec_f_range)
        return result
    _field_names = AdaNode._field_names + (
        "f_range",
    )
    _kind_name = 'RangeSpec'
class RenamingClause(AdaNode):
    """
    Renaming clause, used everywhere renamings are valid.
    """
    __slots__ = AdaNode.__slots__
    @property
    def f_renamed_object(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_renaming_clause_f_renamed_object)
        return result
    _field_names = AdaNode._field_names + (
        "f_renamed_object",
    )
    _kind_name = 'RenamingClause'
class ReverseNode(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def p_as_bool(self):
        """
        Return whether this is an instance of ReversePresent

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _reverse_node_p_as_bool)
        result = bool(c_result.value)
        return result
    _field_names = AdaNode._field_names + (
    )
class ReverseAbsent(ReverseNode):
    __slots__ = AdaNode.__slots__
    _field_names = ReverseNode._field_names + (
    )
    _kind_name = 'ReverseAbsent'
class ReversePresent(ReverseNode):
    __slots__ = AdaNode.__slots__
    _field_names = ReverseNode._field_names + (
    )
    _kind_name = 'ReversePresent'
class SelectWhenPart(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_cond_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_select_when_part_f_cond_expr)
        return result
    @property
    def f_stmts(self):
        """
        :rtype: StmtList
        """
        result = self._eval_astnode_field(_select_when_part_f_stmts)
        return result
    _field_names = AdaNode._field_names + (
        "f_cond_expr",
        "f_stmts",
    )
    _kind_name = 'SelectWhenPart'
class Stmt(AdaNode):
    __slots__ = AdaNode.__slots__
    _field_names = AdaNode._field_names + (
    )
class CompositeStmt(Stmt):
    __slots__ = AdaNode.__slots__
    _field_names = Stmt._field_names + (
    )
class AcceptStmt(CompositeStmt):
    __slots__ = AdaNode.__slots__
    @property
    def f_name(self):
        """
        :rtype: Identifier
        """
        result = self._eval_astnode_field(_accept_stmt_f_name)
        return result
    @property
    def f_entry_index_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_accept_stmt_f_entry_index_expr)
        return result
    @property
    def f_params(self):
        """
        :rtype: Params
        """
        result = self._eval_astnode_field(_accept_stmt_f_params)
        return result
    _field_names = CompositeStmt._field_names + (
        "f_name",
        "f_entry_index_expr",
        "f_params",
    )
    _kind_name = 'AcceptStmt'
class AcceptStmtWithStmts(AcceptStmt):
    __slots__ = AdaNode.__slots__
    @property
    def f_stmts(self):
        """
        :rtype: HandledStmts
        """
        result = self._eval_astnode_field(_accept_stmt_with_stmts_f_stmts)
        return result
    @property
    def f_end_name(self):
        """
        :rtype: EndName
        """
        result = self._eval_astnode_field(_accept_stmt_with_stmts_f_end_name)
        return result
    _field_names = AcceptStmt._field_names + (
        "f_stmts",
        "f_end_name",
    )
    _kind_name = 'AcceptStmtWithStmts'
class BaseLoopStmt(CompositeStmt):
    __slots__ = AdaNode.__slots__
    @property
    def f_spec(self):
        """
        :rtype: LoopSpec
        """
        result = self._eval_astnode_field(_base_loop_stmt_f_spec)
        return result
    @property
    def f_stmts(self):
        """
        :rtype: StmtList
        """
        result = self._eval_astnode_field(_base_loop_stmt_f_stmts)
        return result
    @property
    def f_end_name(self):
        """
        :rtype: EndName
        """
        result = self._eval_astnode_field(_base_loop_stmt_f_end_name)
        return result
    _field_names = CompositeStmt._field_names + (
        "f_spec",
        "f_stmts",
        "f_end_name",
    )
class ForLoopStmt(BaseLoopStmt):
    __slots__ = AdaNode.__slots__
    _field_names = BaseLoopStmt._field_names + (
    )
    _kind_name = 'ForLoopStmt'
class LoopStmt(BaseLoopStmt):
    __slots__ = AdaNode.__slots__
    _field_names = BaseLoopStmt._field_names + (
    )
    _kind_name = 'LoopStmt'
class WhileLoopStmt(BaseLoopStmt):
    __slots__ = AdaNode.__slots__
    _field_names = BaseLoopStmt._field_names + (
    )
    _kind_name = 'WhileLoopStmt'
class BlockStmt(CompositeStmt):
    __slots__ = AdaNode.__slots__
    _field_names = CompositeStmt._field_names + (
    )
class BeginBlock(BlockStmt):
    __slots__ = AdaNode.__slots__
    @property
    def f_stmts(self):
        """
        :rtype: HandledStmts
        """
        result = self._eval_astnode_field(_begin_block_f_stmts)
        return result
    @property
    def f_end_name(self):
        """
        :rtype: EndName
        """
        result = self._eval_astnode_field(_begin_block_f_end_name)
        return result
    _field_names = BlockStmt._field_names + (
        "f_stmts",
        "f_end_name",
    )
    _kind_name = 'BeginBlock'
class DeclBlock(BlockStmt):
    __slots__ = AdaNode.__slots__
    @property
    def f_decls(self):
        """
        :rtype: DeclarativePart
        """
        result = self._eval_astnode_field(_decl_block_f_decls)
        return result
    @property
    def f_stmts(self):
        """
        :rtype: HandledStmts
        """
        result = self._eval_astnode_field(_decl_block_f_stmts)
        return result
    @property
    def f_end_name(self):
        """
        :rtype: EndName
        """
        result = self._eval_astnode_field(_decl_block_f_end_name)
        return result
    _field_names = BlockStmt._field_names + (
        "f_decls",
        "f_stmts",
        "f_end_name",
    )
    _kind_name = 'DeclBlock'
class CaseStmt(CompositeStmt):
    __slots__ = AdaNode.__slots__
    @property
    def f_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_case_stmt_f_expr)
        return result
    @property
    def f_alternatives(self):
        """
        :rtype: CaseStmtAlternativeList
        """
        result = self._eval_astnode_field(_case_stmt_f_alternatives)
        return result
    _field_names = CompositeStmt._field_names + (
        "f_expr",
        "f_alternatives",
    )
    _kind_name = 'CaseStmt'
class ExtendedReturnStmt(CompositeStmt):
    __slots__ = AdaNode.__slots__
    @property
    def f_decl(self):
        """
        :rtype: ExtendedReturnStmtObjectDecl
        """
        result = self._eval_astnode_field(_extended_return_stmt_f_decl)
        return result
    @property
    def f_stmts(self):
        """
        :rtype: HandledStmts
        """
        result = self._eval_astnode_field(_extended_return_stmt_f_stmts)
        return result
    _field_names = CompositeStmt._field_names + (
        "f_decl",
        "f_stmts",
    )
    _kind_name = 'ExtendedReturnStmt'
class IfStmt(CompositeStmt):
    __slots__ = AdaNode.__slots__
    @property
    def f_cond_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_if_stmt_f_cond_expr)
        return result
    @property
    def f_then_stmts(self):
        """
        :rtype: StmtList
        """
        result = self._eval_astnode_field(_if_stmt_f_then_stmts)
        return result
    @property
    def f_alternatives(self):
        """
        :rtype: ElsifStmtPartList
        """
        result = self._eval_astnode_field(_if_stmt_f_alternatives)
        return result
    @property
    def f_else_stmts(self):
        """
        :rtype: StmtList
        """
        result = self._eval_astnode_field(_if_stmt_f_else_stmts)
        return result
    _field_names = CompositeStmt._field_names + (
        "f_cond_expr",
        "f_then_stmts",
        "f_alternatives",
        "f_else_stmts",
    )
    _kind_name = 'IfStmt'
class NamedStmt(CompositeStmt):
    """
    Wrapper class, used for composite statements that can be named (declare
    blocks, loops). This allows to both have a BasicDecl for the named entity
    declared, and a CompositeStmt for the statement hierarchy.
    """
    __slots__ = AdaNode.__slots__
    @property
    def f_decl(self):
        """
        :rtype: NamedStmtDecl
        """
        result = self._eval_astnode_field(_named_stmt_f_decl)
        return result
    @property
    def f_stmt(self):
        """
        :rtype: CompositeStmt
        """
        result = self._eval_astnode_field(_named_stmt_f_stmt)
        return result
    _field_names = CompositeStmt._field_names + (
        "f_decl",
        "f_stmt",
    )
    _kind_name = 'NamedStmt'
class SelectStmt(CompositeStmt):
    __slots__ = AdaNode.__slots__
    @property
    def f_guards(self):
        """
        :rtype: SelectWhenPartList
        """
        result = self._eval_astnode_field(_select_stmt_f_guards)
        return result
    @property
    def f_else_stmts(self):
        """
        :rtype: StmtList
        """
        result = self._eval_astnode_field(_select_stmt_f_else_stmts)
        return result
    @property
    def f_abort_stmts(self):
        """
        :rtype: StmtList
        """
        result = self._eval_astnode_field(_select_stmt_f_abort_stmts)
        return result
    _field_names = CompositeStmt._field_names + (
        "f_guards",
        "f_else_stmts",
        "f_abort_stmts",
    )
    _kind_name = 'SelectStmt'
class ErrorStmt(Stmt):
    __slots__ = AdaNode.__slots__
    _field_names = Stmt._field_names + (
    )
    _kind_name = 'ErrorStmt'
class SimpleStmt(Stmt):
    __slots__ = AdaNode.__slots__
    _field_names = Stmt._field_names + (
    )
class AbortStmt(SimpleStmt):
    __slots__ = AdaNode.__slots__
    @property
    def f_names(self):
        """
        :rtype: NameList
        """
        result = self._eval_astnode_field(_abort_stmt_f_names)
        return result
    _field_names = SimpleStmt._field_names + (
        "f_names",
    )
    _kind_name = 'AbortStmt'
class AssignStmt(SimpleStmt):
    __slots__ = AdaNode.__slots__
    @property
    def f_dest(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_assign_stmt_f_dest)
        return result
    @property
    def f_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_assign_stmt_f_expr)
        return result
    _field_names = SimpleStmt._field_names + (
        "f_dest",
        "f_expr",
    )
    _kind_name = 'AssignStmt'
class CallStmt(SimpleStmt):
    """
    Statement for entry or procedure calls.
    """
    __slots__ = AdaNode.__slots__
    @property
    def f_call(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_call_stmt_f_call)
        return result
    _field_names = SimpleStmt._field_names + (
        "f_call",
    )
    _kind_name = 'CallStmt'
class DelayStmt(SimpleStmt):
    __slots__ = AdaNode.__slots__
    @property
    def f_has_until(self):
        """
        :rtype: UntilNode
        """
        result = self._eval_astnode_field(_delay_stmt_f_has_until)
        return result
    @property
    def f_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_delay_stmt_f_expr)
        return result
    _field_names = SimpleStmt._field_names + (
        "f_has_until",
        "f_expr",
    )
    _kind_name = 'DelayStmt'
class ExitStmt(SimpleStmt):
    __slots__ = AdaNode.__slots__
    @property
    def f_loop_name(self):
        """
        :rtype: Identifier
        """
        result = self._eval_astnode_field(_exit_stmt_f_loop_name)
        return result
    @property
    def f_cond_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_exit_stmt_f_cond_expr)
        return result
    _field_names = SimpleStmt._field_names + (
        "f_loop_name",
        "f_cond_expr",
    )
    _kind_name = 'ExitStmt'
class GotoStmt(SimpleStmt):
    __slots__ = AdaNode.__slots__
    @property
    def f_label_name(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_goto_stmt_f_label_name)
        return result
    _field_names = SimpleStmt._field_names + (
        "f_label_name",
    )
    _kind_name = 'GotoStmt'
class Label(SimpleStmt):
    __slots__ = AdaNode.__slots__
    @property
    def f_decl(self):
        """
        :rtype: LabelDecl
        """
        result = self._eval_astnode_field(_label_f_decl)
        return result
    _field_names = SimpleStmt._field_names + (
        "f_decl",
    )
    _kind_name = 'Label'
class NullStmt(SimpleStmt):
    __slots__ = AdaNode.__slots__
    _field_names = SimpleStmt._field_names + (
    )
    _kind_name = 'NullStmt'
class RaiseStmt(SimpleStmt):
    __slots__ = AdaNode.__slots__
    @property
    def f_exception_name(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_raise_stmt_f_exception_name)
        return result
    @property
    def f_error_message(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_raise_stmt_f_error_message)
        return result
    _field_names = SimpleStmt._field_names + (
        "f_exception_name",
        "f_error_message",
    )
    _kind_name = 'RaiseStmt'
class RequeueStmt(SimpleStmt):
    __slots__ = AdaNode.__slots__
    @property
    def f_call_name(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_requeue_stmt_f_call_name)
        return result
    @property
    def f_has_abort(self):
        """
        :rtype: AbortNode
        """
        result = self._eval_astnode_field(_requeue_stmt_f_has_abort)
        return result
    _field_names = SimpleStmt._field_names + (
        "f_call_name",
        "f_has_abort",
    )
    _kind_name = 'RequeueStmt'
class ReturnStmt(SimpleStmt):
    __slots__ = AdaNode.__slots__
    @property
    def f_return_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_return_stmt_f_return_expr)
        return result
    _field_names = SimpleStmt._field_names + (
        "f_return_expr",
    )
    _kind_name = 'ReturnStmt'
class TerminateAlternative(SimpleStmt):
    __slots__ = AdaNode.__slots__
    _field_names = SimpleStmt._field_names + (
    )
    _kind_name = 'TerminateAlternative'
class SubpKind(AdaNode):
    __slots__ = AdaNode.__slots__
    _field_names = AdaNode._field_names + (
    )
class SubpKindFunction(SubpKind):
    __slots__ = AdaNode.__slots__
    _field_names = SubpKind._field_names + (
    )
    _kind_name = 'SubpKindFunction'
class SubpKindProcedure(SubpKind):
    __slots__ = AdaNode.__slots__
    _field_names = SubpKind._field_names + (
    )
    _kind_name = 'SubpKindProcedure'
class Subunit(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_name(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_subunit_f_name)
        return result
    @property
    def f_body(self):
        """
        :rtype: BodyNode
        """
        result = self._eval_astnode_field(_subunit_f_body)
        return result
    _field_names = AdaNode._field_names + (
        "f_name",
        "f_body",
    )
    _kind_name = 'Subunit'
class SynchronizedNode(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def p_as_bool(self):
        """
        Return whether this is an instance of SynchronizedPresent

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _synchronized_node_p_as_bool)
        result = bool(c_result.value)
        return result
    _field_names = AdaNode._field_names + (
    )
class SynchronizedAbsent(SynchronizedNode):
    __slots__ = AdaNode.__slots__
    _field_names = SynchronizedNode._field_names + (
    )
    _kind_name = 'SynchronizedAbsent'
class SynchronizedPresent(SynchronizedNode):
    __slots__ = AdaNode.__slots__
    _field_names = SynchronizedNode._field_names + (
    )
    _kind_name = 'SynchronizedPresent'
class TaggedNode(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def p_as_bool(self):
        """
        Return whether this is an instance of TaggedPresent

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _tagged_node_p_as_bool)
        result = bool(c_result.value)
        return result
    _field_names = AdaNode._field_names + (
    )
class TaggedAbsent(TaggedNode):
    __slots__ = AdaNode.__slots__
    _field_names = TaggedNode._field_names + (
    )
    _kind_name = 'TaggedAbsent'
class TaggedPresent(TaggedNode):
    __slots__ = AdaNode.__slots__
    _field_names = TaggedNode._field_names + (
    )
    _kind_name = 'TaggedPresent'
class TaskDef(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_interfaces(self):
        """
        :rtype: ParentList
        """
        result = self._eval_astnode_field(_task_def_f_interfaces)
        return result
    @property
    def f_public_part(self):
        """
        :rtype: PublicPart
        """
        result = self._eval_astnode_field(_task_def_f_public_part)
        return result
    @property
    def f_private_part(self):
        """
        :rtype: PrivatePart
        """
        result = self._eval_astnode_field(_task_def_f_private_part)
        return result
    @property
    def f_end_name(self):
        """
        :rtype: EndName
        """
        result = self._eval_astnode_field(_task_def_f_end_name)
        return result
    _field_names = AdaNode._field_names + (
        "f_interfaces",
        "f_public_part",
        "f_private_part",
        "f_end_name",
    )
    _kind_name = 'TaskDef'
class TypeDef(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def p_is_tagged_type(self):
        """
        Return whether this type is tagged.

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _type_def_p_is_tagged_type)
        result = bool(c_result.value)
        return result
    _field_names = AdaNode._field_names + (
    )
class AccessDef(TypeDef):
    __slots__ = AdaNode.__slots__
    @property
    def f_has_not_null(self):
        """
        :rtype: NotNull
        """
        result = self._eval_astnode_field(_access_def_f_has_not_null)
        return result
    _field_names = TypeDef._field_names + (
        "f_has_not_null",
    )
class AccessToSubpDef(AccessDef):
    __slots__ = AdaNode.__slots__
    @property
    def f_has_protected(self):
        """
        :rtype: ProtectedNode
        """
        result = self._eval_astnode_field(_access_to_subp_def_f_has_protected)
        return result
    @property
    def f_subp_spec(self):
        """
        :rtype: SubpSpec
        """
        result = self._eval_astnode_field(_access_to_subp_def_f_subp_spec)
        return result
    _field_names = AccessDef._field_names + (
        "f_has_protected",
        "f_subp_spec",
    )
    _kind_name = 'AccessToSubpDef'
class BaseTypeAccessDef(AccessDef):
    __slots__ = AdaNode.__slots__
    _field_names = AccessDef._field_names + (
    )
class AnonymousTypeAccessDef(BaseTypeAccessDef):
    """
    Synthetic type access, that will directly reference a type decl. It is used
    to generate synthetic anonymous access types.
    """
    __slots__ = AdaNode.__slots__
    @property
    def f_type_decl(self):
        """
        :rtype: BaseTypeDecl
        """
        result = self._eval_astnode_field(_anonymous_type_access_def_f_type_decl)
        return result
    _field_names = BaseTypeAccessDef._field_names + (
        "f_type_decl",
    )
    _kind_name = 'AnonymousTypeAccessDef'
class TypeAccessDef(BaseTypeAccessDef):
    __slots__ = AdaNode.__slots__
    @property
    def f_has_all(self):
        """
        :rtype: AllNode
        """
        result = self._eval_astnode_field(_type_access_def_f_has_all)
        return result
    @property
    def f_has_constant(self):
        """
        :rtype: ConstantNode
        """
        result = self._eval_astnode_field(_type_access_def_f_has_constant)
        return result
    @property
    def f_subtype_indication(self):
        """
        :rtype: SubtypeIndication
        """
        result = self._eval_astnode_field(_type_access_def_f_subtype_indication)
        return result
    _field_names = BaseTypeAccessDef._field_names + (
        "f_has_all",
        "f_has_constant",
        "f_subtype_indication",
    )
    _kind_name = 'TypeAccessDef'
class ArrayTypeDef(TypeDef):
    __slots__ = AdaNode.__slots__
    @property
    def f_indices(self):
        """
        :rtype: ArrayIndices
        """
        result = self._eval_astnode_field(_array_type_def_f_indices)
        return result
    @property
    def f_component_type(self):
        """
        :rtype: ComponentDef
        """
        result = self._eval_astnode_field(_array_type_def_f_component_type)
        return result
    _field_names = TypeDef._field_names + (
        "f_indices",
        "f_component_type",
    )
    _kind_name = 'ArrayTypeDef'
class DerivedTypeDef(TypeDef):
    __slots__ = AdaNode.__slots__
    @property
    def f_has_abstract(self):
        """
        :rtype: AbstractNode
        """
        result = self._eval_astnode_field(_derived_type_def_f_has_abstract)
        return result
    @property
    def f_has_limited(self):
        """
        :rtype: LimitedNode
        """
        result = self._eval_astnode_field(_derived_type_def_f_has_limited)
        return result
    @property
    def f_has_synchronized(self):
        """
        :rtype: SynchronizedNode
        """
        result = self._eval_astnode_field(_derived_type_def_f_has_synchronized)
        return result
    @property
    def f_subtype_indication(self):
        """
        :rtype: SubtypeIndication
        """
        result = self._eval_astnode_field(_derived_type_def_f_subtype_indication)
        return result
    @property
    def f_interfaces(self):
        """
        :rtype: ParentList
        """
        result = self._eval_astnode_field(_derived_type_def_f_interfaces)
        return result
    @property
    def f_record_extension(self):
        """
        :rtype: BaseRecordDef
        """
        result = self._eval_astnode_field(_derived_type_def_f_record_extension)
        return result
    @property
    def f_has_with_private(self):
        """
        :rtype: WithPrivate
        """
        result = self._eval_astnode_field(_derived_type_def_f_has_with_private)
        return result
    _field_names = TypeDef._field_names + (
        "f_has_abstract",
        "f_has_limited",
        "f_has_synchronized",
        "f_subtype_indication",
        "f_interfaces",
        "f_record_extension",
        "f_has_with_private",
    )
    _kind_name = 'DerivedTypeDef'
class EnumTypeDef(TypeDef):
    __slots__ = AdaNode.__slots__
    @property
    def f_enum_literals(self):
        """
        :rtype: EnumLiteralDeclList
        """
        result = self._eval_astnode_field(_enum_type_def_f_enum_literals)
        return result
    _field_names = TypeDef._field_names + (
        "f_enum_literals",
    )
    _kind_name = 'EnumTypeDef'
class FormalDiscreteTypeDef(TypeDef):
    __slots__ = AdaNode.__slots__
    _field_names = TypeDef._field_names + (
    )
    _kind_name = 'FormalDiscreteTypeDef'
class InterfaceTypeDef(TypeDef):
    __slots__ = AdaNode.__slots__
    @property
    def f_interface_kind(self):
        """
        :rtype: InterfaceKind
        """
        result = self._eval_astnode_field(_interface_type_def_f_interface_kind)
        return result
    @property
    def f_interfaces(self):
        """
        :rtype: ParentList
        """
        result = self._eval_astnode_field(_interface_type_def_f_interfaces)
        return result
    _field_names = TypeDef._field_names + (
        "f_interface_kind",
        "f_interfaces",
    )
    _kind_name = 'InterfaceTypeDef'
class ModIntTypeDef(TypeDef):
    __slots__ = AdaNode.__slots__
    @property
    def f_expr(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_mod_int_type_def_f_expr)
        return result
    _field_names = TypeDef._field_names + (
        "f_expr",
    )
    _kind_name = 'ModIntTypeDef'
class PrivateTypeDef(TypeDef):
    __slots__ = AdaNode.__slots__
    @property
    def f_has_abstract(self):
        """
        :rtype: AbstractNode
        """
        result = self._eval_astnode_field(_private_type_def_f_has_abstract)
        return result
    @property
    def f_has_tagged(self):
        """
        :rtype: TaggedNode
        """
        result = self._eval_astnode_field(_private_type_def_f_has_tagged)
        return result
    @property
    def f_has_limited(self):
        """
        :rtype: LimitedNode
        """
        result = self._eval_astnode_field(_private_type_def_f_has_limited)
        return result
    _field_names = TypeDef._field_names + (
        "f_has_abstract",
        "f_has_tagged",
        "f_has_limited",
    )
    _kind_name = 'PrivateTypeDef'
class RealTypeDef(TypeDef):
    __slots__ = AdaNode.__slots__
    _field_names = TypeDef._field_names + (
    )
class DecimalFixedPointDef(RealTypeDef):
    __slots__ = AdaNode.__slots__
    @property
    def f_delta(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_decimal_fixed_point_def_f_delta)
        return result
    @property
    def f_digits(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_decimal_fixed_point_def_f_digits)
        return result
    @property
    def f_range(self):
        """
        :rtype: RangeSpec
        """
        result = self._eval_astnode_field(_decimal_fixed_point_def_f_range)
        return result
    _field_names = RealTypeDef._field_names + (
        "f_delta",
        "f_digits",
        "f_range",
    )
    _kind_name = 'DecimalFixedPointDef'
class FloatingPointDef(RealTypeDef):
    __slots__ = AdaNode.__slots__
    @property
    def f_num_digits(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_floating_point_def_f_num_digits)
        return result
    @property
    def f_range(self):
        """
        :rtype: RangeSpec
        """
        result = self._eval_astnode_field(_floating_point_def_f_range)
        return result
    _field_names = RealTypeDef._field_names + (
        "f_num_digits",
        "f_range",
    )
    _kind_name = 'FloatingPointDef'
class OrdinaryFixedPointDef(RealTypeDef):
    __slots__ = AdaNode.__slots__
    @property
    def f_delta(self):
        """
        :rtype: Expr
        """
        result = self._eval_astnode_field(_ordinary_fixed_point_def_f_delta)
        return result
    @property
    def f_range(self):
        """
        :rtype: RangeSpec
        """
        result = self._eval_astnode_field(_ordinary_fixed_point_def_f_range)
        return result
    _field_names = RealTypeDef._field_names + (
        "f_delta",
        "f_range",
    )
    _kind_name = 'OrdinaryFixedPointDef'
class RecordTypeDef(TypeDef):
    __slots__ = AdaNode.__slots__
    @property
    def f_has_abstract(self):
        """
        :rtype: AbstractNode
        """
        result = self._eval_astnode_field(_record_type_def_f_has_abstract)
        return result
    @property
    def f_has_tagged(self):
        """
        :rtype: TaggedNode
        """
        result = self._eval_astnode_field(_record_type_def_f_has_tagged)
        return result
    @property
    def f_has_limited(self):
        """
        :rtype: LimitedNode
        """
        result = self._eval_astnode_field(_record_type_def_f_has_limited)
        return result
    @property
    def f_record_def(self):
        """
        :rtype: BaseRecordDef
        """
        result = self._eval_astnode_field(_record_type_def_f_record_def)
        return result
    _field_names = TypeDef._field_names + (
        "f_has_abstract",
        "f_has_tagged",
        "f_has_limited",
        "f_record_def",
    )
    _kind_name = 'RecordTypeDef'
class SignedIntTypeDef(TypeDef):
    __slots__ = AdaNode.__slots__
    @property
    def f_range(self):
        """
        :rtype: RangeSpec
        """
        result = self._eval_astnode_field(_signed_int_type_def_f_range)
        return result
    _field_names = TypeDef._field_names + (
        "f_range",
    )
    _kind_name = 'SignedIntTypeDef'
class TypeExpr(AdaNode):
    """
    A type expression is an abstract node that embodies the concept of a
    reference to a type.

    Since Ada has both subtype_indications and anonymous (inline) type
    declarations, a type expression contains one or the other.
    """
    __slots__ = AdaNode.__slots__
    @property
    def p_type_name(self):
        """
        Return the name node for this type expression, if applicable, else null

        :rtype: Name
        """
        c_result = self._eval_field(_Entity_c_type(), _type_expr_p_type_name)
        result = AdaNode._wrap(c_result)
        return result
    @property
    def p_designated_type_decl(self):
        """
        Returns the type declaration designated by this type expression.

        :rtype: BaseTypeDecl
        """
        c_result = self._eval_field(_Entity_c_type(), _type_expr_p_designated_type_decl)
        result = AdaNode._wrap(c_result)
        return result
    def p_designated_type_decl_from(self, origin_node):
        """
        Return the type declaration designated by this type expression as
        viewed from the node given by origin_node.

        :rtype: BaseTypeDecl
        """
        unwrapped_origin_node = AdaNode._unwrap(origin_node)
        c_result = self._eval_field(_Entity_c_type(), _type_expr_p_designated_type_decl_from, unwrapped_origin_node)
        result = AdaNode._wrap(c_result)
        return result
    _field_names = AdaNode._field_names + (
    )
class AnonymousType(TypeExpr):
    """
    Container for inline anonymous array and access types declarations.
    """
    __slots__ = AdaNode.__slots__
    @property
    def f_type_decl(self):
        """
        :rtype: AnonymousTypeDecl
        """
        result = self._eval_astnode_field(_anonymous_type_f_type_decl)
        return result
    _field_names = TypeExpr._field_names + (
        "f_type_decl",
    )
    _kind_name = 'AnonymousType'
class SubtypeIndication(TypeExpr):
    __slots__ = AdaNode.__slots__
    @property
    def f_has_not_null(self):
        """
        :rtype: NotNull
        """
        result = self._eval_astnode_field(_subtype_indication_f_has_not_null)
        return result
    @property
    def f_name(self):
        """
        :rtype: Name
        """
        result = self._eval_astnode_field(_subtype_indication_f_name)
        return result
    @property
    def f_constraint(self):
        """
        :rtype: Constraint
        """
        result = self._eval_astnode_field(_subtype_indication_f_constraint)
        return result
    _field_names = TypeExpr._field_names + (
        "f_has_not_null",
        "f_name",
        "f_constraint",
    )
    _kind_name = 'SubtypeIndication'
class ConstrainedSubtypeIndication(SubtypeIndication):
    __slots__ = AdaNode.__slots__
    _field_names = SubtypeIndication._field_names + (
    )
    _kind_name = 'ConstrainedSubtypeIndication'
class DiscreteSubtypeIndication(SubtypeIndication):
    __slots__ = AdaNode.__slots__
    _field_names = SubtypeIndication._field_names + (
    )
    _kind_name = 'DiscreteSubtypeIndication'
class UnconstrainedArrayIndex(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_subtype_indication(self):
        """
        :rtype: SubtypeIndication
        """
        result = self._eval_astnode_field(_unconstrained_array_index_f_subtype_indication)
        return result
    _field_names = AdaNode._field_names + (
        "f_subtype_indication",
    )
    _kind_name = 'UnconstrainedArrayIndex'
class UntilNode(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def p_as_bool(self):
        """
        Return whether this is an instance of UntilPresent

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _until_node_p_as_bool)
        result = bool(c_result.value)
        return result
    _field_names = AdaNode._field_names + (
    )
class UntilAbsent(UntilNode):
    __slots__ = AdaNode.__slots__
    _field_names = UntilNode._field_names + (
    )
    _kind_name = 'UntilAbsent'
class UntilPresent(UntilNode):
    __slots__ = AdaNode.__slots__
    _field_names = UntilNode._field_names + (
    )
    _kind_name = 'UntilPresent'
class UseClause(AdaNode):
    __slots__ = AdaNode.__slots__
    _field_names = AdaNode._field_names + (
    )
class UsePackageClause(UseClause):
    __slots__ = AdaNode.__slots__
    @property
    def f_packages(self):
        """
        :rtype: NameList
        """
        result = self._eval_astnode_field(_use_package_clause_f_packages)
        return result
    _field_names = UseClause._field_names + (
        "f_packages",
    )
    _kind_name = 'UsePackageClause'
class UseTypeClause(UseClause):
    __slots__ = AdaNode.__slots__
    @property
    def f_has_all(self):
        """
        :rtype: AllNode
        """
        result = self._eval_astnode_field(_use_type_clause_f_has_all)
        return result
    @property
    def f_types(self):
        """
        :rtype: NameList
        """
        result = self._eval_astnode_field(_use_type_clause_f_types)
        return result
    _field_names = UseClause._field_names + (
        "f_has_all",
        "f_types",
    )
    _kind_name = 'UseTypeClause'
class Variant(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_choices(self):
        """
        :rtype: AlternativesList
        """
        result = self._eval_astnode_field(_variant_f_choices)
        return result
    @property
    def f_components(self):
        """
        :rtype: ComponentList
        """
        result = self._eval_astnode_field(_variant_f_components)
        return result
    _field_names = AdaNode._field_names + (
        "f_choices",
        "f_components",
    )
    _kind_name = 'Variant'
class VariantPart(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_discr_name(self):
        """
        :rtype: Identifier
        """
        result = self._eval_astnode_field(_variant_part_f_discr_name)
        return result
    @property
    def f_variant(self):
        """
        :rtype: VariantList
        """
        result = self._eval_astnode_field(_variant_part_f_variant)
        return result
    _field_names = AdaNode._field_names + (
        "f_discr_name",
        "f_variant",
    )
    _kind_name = 'VariantPart'
class WithClause(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def f_has_limited(self):
        """
        :rtype: LimitedNode
        """
        result = self._eval_astnode_field(_with_clause_f_has_limited)
        return result
    @property
    def f_has_private(self):
        """
        :rtype: PrivateNode
        """
        result = self._eval_astnode_field(_with_clause_f_has_private)
        return result
    @property
    def f_packages(self):
        """
        :rtype: NameList
        """
        result = self._eval_astnode_field(_with_clause_f_packages)
        return result
    _field_names = AdaNode._field_names + (
        "f_has_limited",
        "f_has_private",
        "f_packages",
    )
    _kind_name = 'WithClause'
class WithPrivate(AdaNode):
    __slots__ = AdaNode.__slots__
    @property
    def p_as_bool(self):
        """
        Return whether this is an instance of WithPrivatePresent

        :rtype: bool
        """
        c_result = self._eval_field(ctypes.c_uint8(), _with_private_p_as_bool)
        result = bool(c_result.value)
        return result
    _field_names = AdaNode._field_names + (
    )
class WithPrivateAbsent(WithPrivate):
    __slots__ = AdaNode.__slots__
    _field_names = WithPrivate._field_names + (
    )
    _kind_name = 'WithPrivateAbsent'
class WithPrivatePresent(WithPrivate):
    __slots__ = AdaNode.__slots__
    _field_names = WithPrivate._field_names + (
    )
    _kind_name = 'WithPrivatePresent'
_EnvRebindings_c_type = _hashable_c_pointer()
class _BaseStruct(object):
    """
    Mixin for Ada struct wrappers.
    """
    # Subclasses will override this to a subclass of ctypes.Structure
    _c_type = None
    def __getitem__(self, key):
      if not isinstance(key, int):
         raise TypeError('Tuples items are indexed by integers, not {}'.format(
            type(key)
         ))
      fields = self._c_type._fields_
      if 0 <= key < len(fields):
         field_name, _ = fields[key]
         return getattr(self, field_name)
      else:
         raise IndexError('There is no {}th field'.format(key))
    def __repr__(self):
        field_names = [name for name, _ in self._c_type._fields_]
        return '<{} {}>'.format(
            type(self).__name__,
            ' '.join('{}={}'.format(name, getattr(self, name))
                      for name in field_names)
        )
    @property
    def as_tuple(self):
        return tuple(getattr(self, f) for f, _ in self._c_type._fields_)
    def __eq__(self, other):
        return (isinstance(other, type(self)) and
                self.as_tuple == other.as_tuple)
    def __ne__(self, other):
        return not (self == other)
    def __hash__(self):
        return hash(self.as_tuple)
class _Metadata_c_type(ctypes.Structure):
    _fields_ =  [
        ('dottable_subp',
            ctypes.c_uint8
         ),
        ('access_entity',
            ctypes.c_uint8
         ),
        ('is_call',
            ctypes.c_uint8
         ),
        ('primitive',
            AdaNode._node_c_type
         ),
        ('primitive_real_type',
            AdaNode._node_c_type
         ),
] 
    @property
    def as_tuple(self):
        return tuple(getattr(self, f) for f, _ in self._fields_)
    def __eq__(self, other):
        return (isinstance(other, type(self)) and
                self.as_tuple == other.as_tuple)
    def __ne__(self, other):
        return not (self == other)
    def __hash__(self):
        return hash(self.as_tuple)
class _EntityInfo_c_type(ctypes.Structure):
    _fields_ =  [
        ('md',
            _Metadata_c_type
         ),
        ('rebindings',
            _EnvRebindings_c_type
         ),
        ('from_rebound',
            ctypes.c_uint8
         ),
] 
class _Entity_c_type(ctypes.Structure):
    _fields_ =  [
        ('node',
            AdaNode._node_c_type
         ),
        ('info',
            _EntityInfo_c_type
         ),
] 
    @classmethod
    def from_bare_node(cls, node_c_value):
        return cls(node_c_value, _EntityInfo_c_type._null_value)
_Metadata_c_type._null_value = _Metadata_c_type(False, False, False, False, False)
_EntityInfo_c_type._null_value = _EntityInfo_c_type(_Metadata_c_type._null_value,
                                                None)
#
# Low-level binding - Second part
#
# For performance, allocate a single C API entity for all uses of null
# entities.
_Entity_c_type._null_value = _Entity_c_type()
_Entity_c_type._null_value.node = None
class _BaseArray(object):
    """
    Base class for Ada arrays bindings.
    """
    c_element_type = None
    """
    Ctype class for array elements.
    """
    items_refcounted = False
    """
    Whether items for this arrays are ref-counted.
    """
    __slots__ = ('c_value', 'length', 'items')
    def __init__(self, c_value):
        self.c_value = c_value
        self.length = c_value.contents.n
        items_addr = _field_address(c_value.contents, 'items')
        items = self.c_element_type.from_address(items_addr)
        self.items = ctypes.pointer(items)
    def __repr__(self):
        return '<{} {}>'.format(type(self).__name__, list(self))
    def clear(self):
        self.c_value = None
        self.length = None
        self.items = None
    def __del__(self):
        self.dec_ref(self.c_value)
        self.clear()
    @classmethod
    def wrap(cls, c_value):
        helper = cls(c_value)
        result = []
        for i in range(helper.length):
            # In ctypes, accessing an array element does not copy it, which
            # means the the array must live at least as long as the accessed
            # element. We cannot guarantee that, so we must copy the element so
            # that it is independent of the array it comes from.
            #
            # The try/except block tries to do a copy if "item" is indeed a
            # buffer to be copied, and will fail if it's a mere integer, which
            # does not need the buffer copy anyway, hence the "pass".
            item = helper.items[i]
            try:
                item = cls.c_element_type.from_buffer_copy(item)
            except TypeError:
                pass
            result.append(helper.wrap_item(item))
        return result
    @classmethod
    def unwrap(cls, value, context=None):
        if not isinstance(value, list):
            _raise_type_error('list', value)
        # Create a holder for the result
        result = cls(cls.create(len(value)))
        # Unwrap all items at once, preserving their holder so that resources
        # are deallocated if there is an error at some point.
        items = [result.unwrap_item(item, context) for item in value]
        # Initialize the resulting array
        for i, (_, item) in enumerate(items):
            result.items[i] = item
        # At this point, we know that this is successful. We don't want
        # holders to dec-ref the content so that the return array takes over
        # the corresponding refcounting shares.
        if cls.items_refcounted:
            for holder, _ in items:
                holder.clear()
        return result
class _BareAdaNodeArrayConverter(_BaseArray):
    """
    Wrapper class for arrays of BareAdaNode.

    This class is not meant to be directly instantiated: it is only used to
    convert values that various methods take/return.
    """
    __slots__ = _BaseArray.__slots__
    items_refcounted = False
    @staticmethod
    def wrap_item(item):
        return AdaNode._wrap_bare_node(item)
    @staticmethod
    def unwrap_item(item, context=None):
        c_holder = item._node_c_value
        c_value = c_holder
        return (c_holder, c_value)
    c_element_type = AdaNode._node_c_type
    class c_struct(ctypes.Structure):
        _fields_ = [('n', ctypes.c_int),
                    ('ref_count', ctypes.c_int),
                    ('items', AdaNode._node_c_type * 1)]
    c_type = ctypes.POINTER(c_struct)
    create = staticmethod(_import_func(
        'ada_bare_ada_node_array_create', [ctypes.c_int], c_type))
    inc_ref = staticmethod(_import_func(
        'ada_bare_ada_node_array_inc_ref', [c_type], None))
    dec_ref = staticmethod(_import_func(
        'ada_bare_ada_node_array_dec_ref', [c_type], None))
class _AdaNodeArrayConverter(_BaseArray):
    """
    Wrapper class for arrays of InternalEntity.

    This class is not meant to be directly instantiated: it is only used to
    convert values that various methods take/return.
    """
    __slots__ = _BaseArray.__slots__
    items_refcounted = False
    @staticmethod
    def wrap_item(item):
        return AdaNode._wrap(item)
    @staticmethod
    def unwrap_item(item, context=None):
        c_holder = AdaNode._unwrap(item)
        c_value = c_holder
        return (c_holder, c_value)
    c_element_type = _Entity_c_type
    class c_struct(ctypes.Structure):
        _fields_ = [('n', ctypes.c_int),
                    ('ref_count', ctypes.c_int),
                    ('items', _Entity_c_type * 1)]
    c_type = ctypes.POINTER(c_struct)
    create = staticmethod(_import_func(
        'ada_ada_node_array_create', [ctypes.c_int], c_type))
    inc_ref = staticmethod(_import_func(
        'ada_ada_node_array_inc_ref', [c_type], None))
    dec_ref = staticmethod(_import_func(
        'ada_ada_node_array_dec_ref', [c_type], None))
class _TextTypeConverter(_BaseArray):
    """
    Wrapper class for arrays of CharacterType.

    This class is not meant to be directly instantiated: it is only used to
    convert values that various methods take/return.
    """
    __slots__ = _BaseArray.__slots__
    items_refcounted = False
    @staticmethod
    def wrap_item(item):
        return unichr(item)
    @staticmethod
    def unwrap_item(item, context=None):
        c_holder = ord(item)
        c_value = c_holder
        return (c_holder, c_value)
    @classmethod
    def wrap(cls, c_value):
        # Reinterpret this array of uint32_t values as the equivalent array of
        # characters, then decode it using the appropriate UTF-32 encoding.
        chars = ctypes.cast(ctypes.pointer(c_value.contents.items),
                            ctypes.POINTER(ctypes.c_char))
        return chars[:4 * c_value.contents.n].decode(_text.encoding)
    @classmethod
    def unwrap(cls, value, context=None):
        # If `value` is not a list, assume it's a string, and convert it to the
        # expected list.
        if not isinstance(value, list):
            value = list(_text.cast(value))
        return super(_TextTypeConverter, cls).unwrap(value, context)
    c_element_type = ctypes.c_uint32
    class c_struct(ctypes.Structure):
        _fields_ = [('n', ctypes.c_int),
                    ('ref_count', ctypes.c_int),
                    ('items', ctypes.c_uint32 * 1)]
    c_type = ctypes.POINTER(c_struct)
    create = staticmethod(_import_func(
        'ada_text_type_create', [ctypes.c_int], c_type))
    inc_ref = staticmethod(_import_func(
        'ada_text_type_inc_ref', [c_type], None))
    dec_ref = staticmethod(_import_func(
        'ada_text_type_dec_ref', [c_type], None))
class _AdaNodeArrayConverter(_BaseArray):
    """
    Wrapper class for arrays of InternalEntity.

    This class is not meant to be directly instantiated: it is only used to
    convert values that various methods take/return.
    """
    __slots__ = _BaseArray.__slots__
    items_refcounted = False
    @staticmethod
    def wrap_item(item):
        return AdaNode._wrap(item)
    @staticmethod
    def unwrap_item(item, context=None):
        c_holder = AdaNode._unwrap(item)
        c_value = c_holder
        return (c_holder, c_value)
    c_element_type = _Entity_c_type
    class c_struct(ctypes.Structure):
        _fields_ = [('n', ctypes.c_int),
                    ('ref_count', ctypes.c_int),
                    ('items', _Entity_c_type * 1)]
    c_type = ctypes.POINTER(c_struct)
    create = staticmethod(_import_func(
        'ada_ada_node_array_create', [ctypes.c_int], c_type))
    inc_ref = staticmethod(_import_func(
        'ada_ada_node_array_inc_ref', [c_type], None))
    dec_ref = staticmethod(_import_func(
        'ada_ada_node_array_dec_ref', [c_type], None))
class _AnalysisUnitArrayConverter(_BaseArray):
    """
    Wrapper class for arrays of InternalUnit.

    This class is not meant to be directly instantiated: it is only used to
    convert values that various methods take/return.
    """
    __slots__ = _BaseArray.__slots__
    items_refcounted = False
    @staticmethod
    def wrap_item(item):
        return AnalysisUnit._wrap(item)
    @staticmethod
    def unwrap_item(item, context=None):
        c_holder = AnalysisUnit._unwrap(item)
        c_value = c_holder
        return (c_holder, c_value)
    c_element_type = AnalysisUnit._c_type
    class c_struct(ctypes.Structure):
        _fields_ = [('n', ctypes.c_int),
                    ('ref_count', ctypes.c_int),
                    ('items', AnalysisUnit._c_type * 1)]
    c_type = ctypes.POINTER(c_struct)
    create = staticmethod(_import_func(
        'ada_analysis_unit_array_create', [ctypes.c_int], c_type))
    inc_ref = staticmethod(_import_func(
        'ada_analysis_unit_array_inc_ref', [c_type], None))
    dec_ref = staticmethod(_import_func(
        'ada_analysis_unit_array_dec_ref', [c_type], None))
class _UnboundedTextTypeArrayConverter(_BaseArray):
    """
    Wrapper class for arrays of SymbolType.

    This class is not meant to be directly instantiated: it is only used to
    convert values that various methods take/return.
    """
    __slots__ = _BaseArray.__slots__
    items_refcounted = False
    @staticmethod
    def wrap_item(item):
        return _symbol_type.wrap(item)
    @staticmethod
    def unwrap_item(item, context=None):
        c_holder = _symbol_type.unwrap(item, context)
        c_value = c_holder
        return (c_holder, c_value)
    c_element_type = _symbol_type
    class c_struct(ctypes.Structure):
        _fields_ = [('n', ctypes.c_int),
                    ('ref_count', ctypes.c_int),
                    ('items', _symbol_type * 1)]
    c_type = ctypes.POINTER(c_struct)
    create = staticmethod(_import_func(
        'ada_unbounded_text_type_array_create', [ctypes.c_int], c_type))
    inc_ref = staticmethod(_import_func(
        'ada_unbounded_text_type_array_inc_ref', [c_type], None))
    dec_ref = staticmethod(_import_func(
        'ada_unbounded_text_type_array_dec_ref', [c_type], None))
_initialize = _import_func(
    'libadalang_initialize',
    [], None, exc_wrap=False
)
_initialize()
_free = _import_func(
    'ada_free',
    [ctypes.c_void_p], None
)
_destroy_text = _import_func(
    'ada_destroy_text', [ctypes.POINTER(_text)], None
)
_symbol_text = _import_func(
    'ada_symbol_text',
    [ctypes.POINTER(_symbol_type), ctypes.POINTER(_text)], None
)
# Analysis primitives
_create_analysis_context = _import_func(
    'ada_create_analysis_context',
    [ctypes.c_char_p, _unit_provider, ctypes.c_int], AnalysisContext._c_type
)
_context_incref = _import_func(
    'ada_context_incref',
    [AnalysisContext._c_type], AnalysisContext._c_type
)
_context_decref = _import_func(
    'ada_context_decref',
    [AnalysisContext._c_type], None
)
_context_symbol = _import_func(
    'ada_context_symbol',
    [AnalysisContext._c_type,
     ctypes.POINTER(_text),
     ctypes.POINTER(_symbol_type)], ctypes.c_int
)
_discard_errors_in_populate_lexical_env = _import_func(
   'ada_context_discard_errors_in_populate_lexical_env',
   [AnalysisContext._c_type, ctypes.c_int], None
)
_get_analysis_unit_from_file = _import_func(
    'ada_get_analysis_unit_from_file',
    [AnalysisContext._c_type,  # context
     ctypes.c_char_p,          # filename
     ctypes.c_char_p,          # charset
     ctypes.c_int],            # reparse
    AnalysisUnit._c_type
)
_get_analysis_unit_from_buffer = _import_func(
    'ada_get_analysis_unit_from_buffer',
    [AnalysisContext._c_type,  # context
     ctypes.c_char_p,          # filename
     ctypes.c_char_p,          # charset
     ctypes.c_char_p,          # buffer
     ctypes.c_size_t],         # buffer_size
    AnalysisUnit._c_type
)
_get_analysis_unit_from_provider = _import_func(
    'ada_get_analysis_unit_from_provider',
    [AnalysisContext._c_type,  # context
     ctypes.POINTER(_text),    # name
     ctypes.c_int,             # kind
     ctypes.c_char_p,          # charset
     ctypes.c_int],            # reparse
    AnalysisUnit._c_type
)
_unit_root = _import_func(
    'ada_unit_root',
    [AnalysisUnit._c_type, ctypes.POINTER(_Entity_c_type)], None
)
_unit_first_token = _import_func(
    "ada_unit_first_token",
    [AnalysisUnit._c_type, ctypes.POINTER(Token)], None
)
_unit_last_token = _import_func(
    "ada_unit_last_token",
    [AnalysisUnit._c_type, ctypes.POINTER(Token)], None
)
_unit_token_count = _import_func(
    "ada_unit_token_count",
    [AnalysisUnit._c_type], ctypes.c_int
)
_unit_trivia_count = _import_func(
    "ada_unit_trivia_count",
    [AnalysisUnit._c_type], ctypes.c_int
)
_unit_lookup_token = _import_func(
    "ada_unit_lookup_token",
    [AnalysisUnit._c_type,
     ctypes.POINTER(Sloc._c_type),
     ctypes.POINTER(Token)],
    None
)
_unit_filename = _import_func(
    "ada_unit_filename",
    [AnalysisUnit._c_type], ctypes.POINTER(ctypes.c_char)
)
_unit_diagnostic_count = _import_func(
    'ada_unit_diagnostic_count',
    [AnalysisUnit._c_type], ctypes.c_uint
)
_unit_diagnostic = _import_func(
    'ada_unit_diagnostic',
    [AnalysisUnit._c_type, ctypes.c_uint, ctypes.POINTER(Diagnostic._c_type)],
    ctypes.c_int
)
_unit_context = _import_func(
    'ada_unit_context',
    [AnalysisUnit._c_type], AnalysisContext._c_type
)
_unit_reparse_from_file = _import_func(
    'ada_unit_reparse_from_file',
    [AnalysisUnit._c_type,    # unit
     ctypes.c_char_p],        # charset
    ctypes.c_int
)
_unit_reparse_from_buffer = _import_func(
    'ada_unit_reparse_from_buffer',
    [AnalysisUnit._c_type, # unit
     ctypes.c_char_p,      # charset
     ctypes.c_char_p,      # buffer
     ctypes.c_size_t],     # buffer_size
    None
)
_unit_populate_lexical_env = _import_func(
    'ada_unit_populate_lexical_env',
    [AnalysisUnit._c_type], ctypes.c_int
)
# General AST node primitives
_node_kind = _import_func(
    'ada_node_kind',
    [ctypes.POINTER(_Entity_c_type)], ctypes.c_int
)
_kind_name = _import_func(
    'ada_kind_name',
    [ctypes.c_int], _text
)
_node_unit = _import_func(
    'ada_node_unit',
    [ctypes.POINTER(_Entity_c_type)], AnalysisUnit._c_type
)
_node_is_token_node = _import_func(
    'ada_node_is_token_node',
    [ctypes.POINTER(_Entity_c_type)], ctypes.c_int
)
_node_short_image = _import_func(
    'ada_node_short_image',
    [ctypes.POINTER(_Entity_c_type)], _text
)
_node_sloc_range = _import_func(
    'ada_node_sloc_range',
    [ctypes.POINTER(_Entity_c_type), ctypes.POINTER(SlocRange._c_type)], None
)
_lookup_in_node = _import_func(
    'ada_lookup_in_node',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(Sloc._c_type),
     ctypes.POINTER(_Entity_c_type)], None
)
_node_children_count = _import_func(
    'ada_node_children_count',
    [ctypes.POINTER(_Entity_c_type)], ctypes.c_uint
)
_node_child = _import_func(
    'ada_node_child',
    [ctypes.POINTER(_Entity_c_type), ctypes.c_uint, ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_ada_node_parent = _import_func(
    'ada_ada_node_parent',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_ada_node_parents = _import_func(
    'ada_ada_node_parents',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_AdaNodeArrayConverter.c_type)],
    ctypes.c_int
)
_ada_node_children = _import_func(
    'ada_ada_node_children',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_AdaNodeArrayConverter.c_type)],
    ctypes.c_int
)
_ada_node_token_start = _import_func(
    'ada_ada_node_token_start',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(Token)],
    ctypes.c_int
)
_ada_node_token_end = _import_func(
    'ada_ada_node_token_end',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(Token)],
    ctypes.c_int
)
_ada_node_child_index = _import_func(
    'ada_ada_node_child_index',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_int)],
    ctypes.c_int
)
_ada_node_previous_sibling = _import_func(
    'ada_ada_node_previous_sibling',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_ada_node_next_sibling = _import_func(
    'ada_ada_node_next_sibling',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_ada_node_unit = _import_func(
    'ada_ada_node_unit',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(AnalysisUnit._c_type)],
    ctypes.c_int
)
_ada_node_is_ghost = _import_func(
    'ada_ada_node_is_ghost',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_ada_node_p_expression_type = _import_func(
    'ada_ada_node_p_expression_type',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_ada_node_p_referenced_decl = _import_func(
    'ada_ada_node_p_referenced_decl',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.c_uint8,
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_ada_node_p_xref = _import_func(
    'ada_ada_node_p_xref',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.c_uint8,
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_ada_node_p_complete = _import_func(
    'ada_ada_node_p_complete',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_AdaNodeArrayConverter.c_type)],
    ctypes.c_int
)
_ada_node_p_referenced_decl_internal = _import_func(
    'ada_ada_node_p_referenced_decl_internal',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.c_uint8,
        ctypes.c_uint8,
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_ada_node_p_generic_instantiations = _import_func(
    'ada_ada_node_p_generic_instantiations',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_AdaNodeArrayConverter.c_type)],
    ctypes.c_int
)
_ada_node_p_semantic_parent = _import_func(
    'ada_ada_node_p_semantic_parent',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_ada_node_p_filter_is_imported_by = _import_func(
    'ada_ada_node_p_filter_is_imported_by',
    [ctypes.POINTER(_Entity_c_type),
        _AnalysisUnitArrayConverter.c_type,
        ctypes.c_uint8,
     ctypes.POINTER(_AnalysisUnitArrayConverter.c_type)],
    ctypes.c_int
)
_ada_node_p_xref_entry_point = _import_func(
    'ada_ada_node_p_xref_entry_point',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_ada_node_p_resolve_names = _import_func(
    'ada_ada_node_p_resolve_names',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_ada_node_p_body_unit = _import_func(
    'ada_ada_node_p_body_unit',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(AnalysisUnit._c_type)],
    ctypes.c_int
)
_ada_node_p_spec_unit = _import_func(
    'ada_ada_node_p_spec_unit',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(AnalysisUnit._c_type)],
    ctypes.c_int
)
_ada_node_p_standard_unit = _import_func(
    'ada_ada_node_p_standard_unit',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(AnalysisUnit._c_type)],
    ctypes.c_int
)
_ada_node_p_std_entity = _import_func(
    'ada_ada_node_p_std_entity',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.POINTER(_symbol_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_ada_node_p_bool_type = _import_func(
    'ada_ada_node_p_bool_type',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_ada_node_p_int_type = _import_func(
    'ada_ada_node_p_int_type',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_ada_node_p_universal_int_type = _import_func(
    'ada_ada_node_p_universal_int_type',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_ada_node_p_universal_real_type = _import_func(
    'ada_ada_node_p_universal_real_type',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_ada_node_p_top_level_decl = _import_func(
    'ada_ada_node_p_top_level_decl',
    [ctypes.POINTER(_Entity_c_type),
        AnalysisUnit._c_type,
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_ada_node_p_gnat_xref = _import_func(
    'ada_ada_node_p_gnat_xref',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.c_uint8,
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_abort_node_p_as_bool = _import_func(
    'ada_abort_node_p_as_bool',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_abstract_node_p_as_bool = _import_func(
    'ada_abstract_node_p_as_bool',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_aliased_node_p_as_bool = _import_func(
    'ada_aliased_node_p_as_bool',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_all_node_p_as_bool = _import_func(
    'ada_all_node_p_as_bool',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_constrained_array_indices_f_list = _import_func(
    'ada_constrained_array_indices_f_list',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_unconstrained_array_indices_f_types = _import_func(
    'ada_unconstrained_array_indices_f_types',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_aspect_assoc_f_id = _import_func(
    'ada_aspect_assoc_f_id',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_aspect_assoc_f_expr = _import_func(
    'ada_aspect_assoc_f_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_at_clause_f_name = _import_func(
    'ada_at_clause_f_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_at_clause_f_expr = _import_func(
    'ada_at_clause_f_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_attribute_def_clause_f_attribute_expr = _import_func(
    'ada_attribute_def_clause_f_attribute_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_attribute_def_clause_f_expr = _import_func(
    'ada_attribute_def_clause_f_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_enum_rep_clause_f_type_name = _import_func(
    'ada_enum_rep_clause_f_type_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_enum_rep_clause_f_aggregate = _import_func(
    'ada_enum_rep_clause_f_aggregate',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_record_rep_clause_f_name = _import_func(
    'ada_record_rep_clause_f_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_record_rep_clause_f_at_expr = _import_func(
    'ada_record_rep_clause_f_at_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_record_rep_clause_f_components = _import_func(
    'ada_record_rep_clause_f_components',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_aspect_spec_f_aspect_assocs = _import_func(
    'ada_aspect_spec_f_aspect_assocs',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_assoc_p_assoc_expr = _import_func(
    'ada_base_assoc_p_assoc_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_contract_case_assoc_f_guard = _import_func(
    'ada_contract_case_assoc_f_guard',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_contract_case_assoc_f_consequence = _import_func(
    'ada_contract_case_assoc_f_consequence',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_pragma_argument_assoc_f_id = _import_func(
    'ada_pragma_argument_assoc_f_id',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_pragma_argument_assoc_f_expr = _import_func(
    'ada_pragma_argument_assoc_f_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_formal_param_holder_p_abstract_formal_params = _import_func(
    'ada_base_formal_param_holder_p_abstract_formal_params',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_AdaNodeArrayConverter.c_type)],
    ctypes.c_int
)
_base_formal_param_holder_p_nb_min_params = _import_func(
    'ada_base_formal_param_holder_p_nb_min_params',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_int)],
    ctypes.c_int
)
_base_formal_param_holder_p_nb_max_params = _import_func(
    'ada_base_formal_param_holder_p_nb_max_params',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_int)],
    ctypes.c_int
)
_base_formal_param_holder_p_return_type = _import_func(
    'ada_base_formal_param_holder_p_return_type',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_subp_spec_p_returns = _import_func(
    'ada_base_subp_spec_p_returns',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_subp_spec_p_params = _import_func(
    'ada_base_subp_spec_p_params',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_AdaNodeArrayConverter.c_type)],
    ctypes.c_int
)
_base_subp_spec_p_primitive_subp_of = _import_func(
    'ada_base_subp_spec_p_primitive_subp_of',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_entry_spec_f_entry_name = _import_func(
    'ada_entry_spec_f_entry_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_entry_spec_f_family_type = _import_func(
    'ada_entry_spec_f_family_type',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_entry_spec_f_entry_params = _import_func(
    'ada_entry_spec_f_entry_params',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_subp_spec_f_subp_kind = _import_func(
    'ada_subp_spec_f_subp_kind',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_subp_spec_f_subp_name = _import_func(
    'ada_subp_spec_f_subp_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_subp_spec_f_subp_params = _import_func(
    'ada_subp_spec_f_subp_params',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_subp_spec_f_subp_returns = _import_func(
    'ada_subp_spec_f_subp_returns',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_component_list_f_components = _import_func(
    'ada_component_list_f_components',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_component_list_f_variant_part = _import_func(
    'ada_component_list_f_variant_part',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_known_discriminant_part_f_discr_specs = _import_func(
    'ada_known_discriminant_part_f_discr_specs',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_formal_part_f_decls = _import_func(
    'ada_generic_formal_part_f_decls',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_record_def_f_components = _import_func(
    'ada_base_record_def_f_components',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_aggregate_assoc_f_designators = _import_func(
    'ada_aggregate_assoc_f_designators',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_aggregate_assoc_f_r_expr = _import_func(
    'ada_aggregate_assoc_f_r_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_discriminant_assoc_f_ids = _import_func(
    'ada_discriminant_assoc_f_ids',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_discriminant_assoc_f_discr_expr = _import_func(
    'ada_discriminant_assoc_f_discr_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_param_assoc_f_designator = _import_func(
    'ada_param_assoc_f_designator',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_param_assoc_f_r_expr = _import_func(
    'ada_param_assoc_f_r_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_basic_decl_p_previous_part_for_decl = _import_func(
    'ada_basic_decl_p_previous_part_for_decl',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_basic_decl_p_canonical_part = _import_func(
    'ada_basic_decl_p_canonical_part',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_basic_decl_p_is_static_decl = _import_func(
    'ada_basic_decl_p_is_static_decl',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.c_uint8,
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_basic_decl_p_is_imported = _import_func(
    'ada_basic_decl_p_is_imported',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_basic_decl_f_aspects = _import_func(
    'ada_basic_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_basic_decl_p_get_aspect = _import_func(
    'ada_basic_decl_p_get_aspect',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.POINTER(_symbol_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_basic_decl_p_get_aspect_expr = _import_func(
    'ada_basic_decl_p_get_aspect_expr',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.POINTER(_symbol_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_basic_decl_p_get_attribute = _import_func(
    'ada_basic_decl_p_get_attribute',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.POINTER(_symbol_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_basic_decl_p_get_pragma = _import_func(
    'ada_basic_decl_p_get_pragma',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.POINTER(_symbol_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_basic_decl_p_is_unit_root = _import_func(
    'ada_basic_decl_p_is_unit_root',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_basic_decl_p_defining_names = _import_func(
    'ada_basic_decl_p_defining_names',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_AdaNodeArrayConverter.c_type)],
    ctypes.c_int
)
_basic_decl_p_defining_name = _import_func(
    'ada_basic_decl_p_defining_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_basic_decl_p_subp_spec_or_null = _import_func(
    'ada_basic_decl_p_subp_spec_or_null',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.c_uint8,
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_basic_decl_p_is_subprogram = _import_func(
    'ada_basic_decl_p_is_subprogram',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_basic_decl_p_declarative_scope = _import_func(
    'ada_basic_decl_p_declarative_scope',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_basic_decl_p_relative_name = _import_func(
    'ada_basic_decl_p_relative_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_basic_decl_p_relative_name_text = _import_func(
    'ada_basic_decl_p_relative_name_text',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_symbol_type)],
    ctypes.c_int
)
_basic_decl_p_next_part_for_decl = _import_func(
    'ada_basic_decl_p_next_part_for_decl',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_basic_decl_p_body_part_for_decl = _import_func(
    'ada_basic_decl_p_body_part_for_decl',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_basic_decl_p_fully_qualified_name = _import_func(
    'ada_basic_decl_p_fully_qualified_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_UnboundedTextTypeArrayConverter.c_type)],
    ctypes.c_int
)
_base_formal_param_decl_p_formal_type = _import_func(
    'ada_base_formal_param_decl_p_formal_type',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_component_decl_f_ids = _import_func(
    'ada_component_decl_f_ids',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_component_decl_f_component_def = _import_func(
    'ada_component_decl_f_component_def',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_component_decl_f_default_expr = _import_func(
    'ada_component_decl_f_default_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_component_decl_f_aspects = _import_func(
    'ada_component_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_discriminant_spec_f_ids = _import_func(
    'ada_discriminant_spec_f_ids',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_discriminant_spec_f_type_expr = _import_func(
    'ada_discriminant_spec_f_type_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_discriminant_spec_f_default_expr = _import_func(
    'ada_discriminant_spec_f_default_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_discriminant_spec_f_aspects = _import_func(
    'ada_discriminant_spec_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_formal_f_decl = _import_func(
    'ada_generic_formal_f_decl',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_formal_f_aspects = _import_func(
    'ada_generic_formal_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_param_spec_f_ids = _import_func(
    'ada_param_spec_f_ids',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_param_spec_f_has_aliased = _import_func(
    'ada_param_spec_f_has_aliased',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_param_spec_f_mode = _import_func(
    'ada_param_spec_f_mode',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_param_spec_f_type_expr = _import_func(
    'ada_param_spec_f_type_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_param_spec_f_default_expr = _import_func(
    'ada_param_spec_f_default_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_param_spec_f_aspects = _import_func(
    'ada_param_spec_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_package_decl_f_package_name = _import_func(
    'ada_base_package_decl_f_package_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_package_decl_f_aspects = _import_func(
    'ada_base_package_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_package_decl_f_public_part = _import_func(
    'ada_base_package_decl_f_public_part',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_package_decl_f_private_part = _import_func(
    'ada_base_package_decl_f_private_part',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_package_decl_f_end_name = _import_func(
    'ada_base_package_decl_f_end_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_package_decl_p_body_part = _import_func(
    'ada_base_package_decl_p_body_part',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_type_decl_f_name = _import_func(
    'ada_base_type_decl_f_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_type_decl_p_private_completion = _import_func(
    'ada_base_type_decl_p_private_completion',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_type_decl_p_is_real_type = _import_func(
    'ada_base_type_decl_p_is_real_type',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_base_type_decl_p_is_float_type = _import_func(
    'ada_base_type_decl_p_is_float_type',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_base_type_decl_p_is_fixed_point = _import_func(
    'ada_base_type_decl_p_is_fixed_point',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_base_type_decl_p_is_access_type = _import_func(
    'ada_base_type_decl_p_is_access_type',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_base_type_decl_p_base_type = _import_func(
    'ada_base_type_decl_p_base_type',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_type_decl_p_comp_type = _import_func(
    'ada_base_type_decl_p_comp_type',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.c_uint8,
        ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_type_decl_p_index_type = _import_func(
    'ada_base_type_decl_p_index_type',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.c_int,
        ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_type_decl_p_is_derived_type = _import_func(
    'ada_base_type_decl_p_is_derived_type',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.POINTER(_Entity_c_type),
        ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_base_type_decl_p_matching_type = _import_func(
    'ada_base_type_decl_p_matching_type',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.POINTER(_Entity_c_type),
        ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_base_type_decl_p_canonical_type = _import_func(
    'ada_base_type_decl_p_canonical_type',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_type_decl_p_previous_part = _import_func(
    'ada_base_type_decl_p_previous_part',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.c_uint8,
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_type_decl_p_next_part = _import_func(
    'ada_base_type_decl_p_next_part',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_type_decl_p_is_private = _import_func(
    'ada_base_type_decl_p_is_private',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_discrete_base_subtype_decl_f_aspects = _import_func(
    'ada_discrete_base_subtype_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_subtype_decl_f_subtype = _import_func(
    'ada_subtype_decl_f_subtype',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_subtype_decl_f_aspects = _import_func(
    'ada_subtype_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_classwide_type_decl_f_aspects = _import_func(
    'ada_classwide_type_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_incomplete_type_decl_f_discriminants = _import_func(
    'ada_incomplete_type_decl_f_discriminants',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_incomplete_type_decl_f_aspects = _import_func(
    'ada_incomplete_type_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_incomplete_tagged_type_decl_f_has_abstract = _import_func(
    'ada_incomplete_tagged_type_decl_f_has_abstract',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_protected_type_decl_f_discriminants = _import_func(
    'ada_protected_type_decl_f_discriminants',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_protected_type_decl_f_aspects = _import_func(
    'ada_protected_type_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_protected_type_decl_f_interfaces = _import_func(
    'ada_protected_type_decl_f_interfaces',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_protected_type_decl_f_definition = _import_func(
    'ada_protected_type_decl_f_definition',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_task_type_decl_f_discriminants = _import_func(
    'ada_task_type_decl_f_discriminants',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_task_type_decl_f_aspects = _import_func(
    'ada_task_type_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_task_type_decl_f_definition = _import_func(
    'ada_task_type_decl_f_definition',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_type_decl_f_discriminants = _import_func(
    'ada_type_decl_f_discriminants',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_type_decl_f_type_def = _import_func(
    'ada_type_decl_f_type_def',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_type_decl_f_aspects = _import_func(
    'ada_type_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_basic_subp_decl_p_subp_decl_spec = _import_func(
    'ada_basic_subp_decl_p_subp_decl_spec',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_basic_subp_decl_p_body_part = _import_func(
    'ada_basic_subp_decl_p_body_part',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_classic_subp_decl_f_overriding = _import_func(
    'ada_classic_subp_decl_f_overriding',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_classic_subp_decl_f_subp_spec = _import_func(
    'ada_classic_subp_decl_f_subp_spec',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_abstract_subp_decl_f_aspects = _import_func(
    'ada_abstract_subp_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_formal_subp_decl_f_default_expr = _import_func(
    'ada_formal_subp_decl_f_default_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_formal_subp_decl_f_aspects = _import_func(
    'ada_formal_subp_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_null_subp_decl_f_aspects = _import_func(
    'ada_null_subp_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_subp_decl_f_aspects = _import_func(
    'ada_subp_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_subp_renaming_decl_f_renames = _import_func(
    'ada_subp_renaming_decl_f_renames',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_subp_renaming_decl_f_aspects = _import_func(
    'ada_subp_renaming_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_subp_internal_f_subp_spec = _import_func(
    'ada_generic_subp_internal_f_subp_spec',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_subp_internal_f_aspects = _import_func(
    'ada_generic_subp_internal_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_body_node_p_previous_part = _import_func(
    'ada_body_node_p_previous_part',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_body_node_p_decl_part = _import_func(
    'ada_body_node_p_decl_part',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_body_node_p_subunit_root = _import_func(
    'ada_body_node_p_subunit_root',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_subp_body_f_overriding = _import_func(
    'ada_base_subp_body_f_overriding',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_subp_body_f_subp_spec = _import_func(
    'ada_base_subp_body_f_subp_spec',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_expr_function_f_expr = _import_func(
    'ada_expr_function_f_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_expr_function_f_aspects = _import_func(
    'ada_expr_function_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_subp_body_f_aspects = _import_func(
    'ada_subp_body_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_subp_body_f_decls = _import_func(
    'ada_subp_body_f_decls',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_subp_body_f_stmts = _import_func(
    'ada_subp_body_f_stmts',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_subp_body_f_end_name = _import_func(
    'ada_subp_body_f_end_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_package_body_stub_f_name = _import_func(
    'ada_package_body_stub_f_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_package_body_stub_f_aspects = _import_func(
    'ada_package_body_stub_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_protected_body_stub_f_name = _import_func(
    'ada_protected_body_stub_f_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_protected_body_stub_f_aspects = _import_func(
    'ada_protected_body_stub_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_subp_body_stub_f_overriding = _import_func(
    'ada_subp_body_stub_f_overriding',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_subp_body_stub_f_subp_spec = _import_func(
    'ada_subp_body_stub_f_subp_spec',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_subp_body_stub_f_aspects = _import_func(
    'ada_subp_body_stub_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_task_body_stub_f_name = _import_func(
    'ada_task_body_stub_f_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_task_body_stub_f_aspects = _import_func(
    'ada_task_body_stub_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_entry_body_f_entry_name = _import_func(
    'ada_entry_body_f_entry_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_entry_body_f_index_spec = _import_func(
    'ada_entry_body_f_index_spec',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_entry_body_f_params = _import_func(
    'ada_entry_body_f_params',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_entry_body_f_barrier = _import_func(
    'ada_entry_body_f_barrier',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_entry_body_f_decls = _import_func(
    'ada_entry_body_f_decls',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_entry_body_f_stmts = _import_func(
    'ada_entry_body_f_stmts',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_entry_body_f_end_name = _import_func(
    'ada_entry_body_f_end_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_entry_body_f_aspects = _import_func(
    'ada_entry_body_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_package_body_f_package_name = _import_func(
    'ada_package_body_f_package_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_package_body_f_aspects = _import_func(
    'ada_package_body_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_package_body_f_decls = _import_func(
    'ada_package_body_f_decls',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_package_body_f_stmts = _import_func(
    'ada_package_body_f_stmts',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_package_body_f_end_name = _import_func(
    'ada_package_body_f_end_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_protected_body_f_name = _import_func(
    'ada_protected_body_f_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_protected_body_f_aspects = _import_func(
    'ada_protected_body_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_protected_body_f_decls = _import_func(
    'ada_protected_body_f_decls',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_protected_body_f_end_name = _import_func(
    'ada_protected_body_f_end_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_task_body_f_name = _import_func(
    'ada_task_body_f_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_task_body_f_aspects = _import_func(
    'ada_task_body_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_task_body_f_decls = _import_func(
    'ada_task_body_f_decls',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_task_body_f_stmts = _import_func(
    'ada_task_body_f_stmts',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_task_body_f_end_name = _import_func(
    'ada_task_body_f_end_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_entry_decl_f_overriding = _import_func(
    'ada_entry_decl_f_overriding',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_entry_decl_f_spec = _import_func(
    'ada_entry_decl_f_spec',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_entry_decl_f_aspects = _import_func(
    'ada_entry_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_entry_index_spec_f_id = _import_func(
    'ada_entry_index_spec_f_id',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_entry_index_spec_f_subtype = _import_func(
    'ada_entry_index_spec_f_subtype',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_entry_index_spec_f_aspects = _import_func(
    'ada_entry_index_spec_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_enum_literal_decl_f_name = _import_func(
    'ada_enum_literal_decl_f_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_enum_literal_decl_f_aspects = _import_func(
    'ada_enum_literal_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_enum_literal_decl_p_enum_type = _import_func(
    'ada_enum_literal_decl_p_enum_type',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_error_decl_f_aspects = _import_func(
    'ada_error_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_exception_decl_f_ids = _import_func(
    'ada_exception_decl_f_ids',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_exception_decl_f_renames = _import_func(
    'ada_exception_decl_f_renames',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_exception_decl_f_aspects = _import_func(
    'ada_exception_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_exception_handler_f_exception_name = _import_func(
    'ada_exception_handler_f_exception_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_exception_handler_f_handled_exceptions = _import_func(
    'ada_exception_handler_f_handled_exceptions',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_exception_handler_f_stmts = _import_func(
    'ada_exception_handler_f_stmts',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_exception_handler_f_aspects = _import_func(
    'ada_exception_handler_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_for_loop_var_decl_f_id = _import_func(
    'ada_for_loop_var_decl_f_id',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_for_loop_var_decl_f_id_type = _import_func(
    'ada_for_loop_var_decl_f_id_type',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_for_loop_var_decl_f_aspects = _import_func(
    'ada_for_loop_var_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_decl_f_formal_part = _import_func(
    'ada_generic_decl_f_formal_part',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_package_decl_f_package_decl = _import_func(
    'ada_generic_package_decl_f_package_decl',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_package_decl_f_aspects = _import_func(
    'ada_generic_package_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_package_decl_p_body_part = _import_func(
    'ada_generic_package_decl_p_body_part',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_subp_decl_f_subp_decl = _import_func(
    'ada_generic_subp_decl_f_subp_decl',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_subp_decl_f_aspects = _import_func(
    'ada_generic_subp_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_subp_decl_p_body_part = _import_func(
    'ada_generic_subp_decl_p_body_part',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_instantiation_p_designated_generic_decl = _import_func(
    'ada_generic_instantiation_p_designated_generic_decl',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_package_instantiation_f_name = _import_func(
    'ada_generic_package_instantiation_f_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_package_instantiation_f_generic_pkg_name = _import_func(
    'ada_generic_package_instantiation_f_generic_pkg_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_package_instantiation_f_params = _import_func(
    'ada_generic_package_instantiation_f_params',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_package_instantiation_f_aspects = _import_func(
    'ada_generic_package_instantiation_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_subp_instantiation_f_overriding = _import_func(
    'ada_generic_subp_instantiation_f_overriding',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_subp_instantiation_f_kind = _import_func(
    'ada_generic_subp_instantiation_f_kind',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_subp_instantiation_f_subp_name = _import_func(
    'ada_generic_subp_instantiation_f_subp_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_subp_instantiation_f_generic_subp_name = _import_func(
    'ada_generic_subp_instantiation_f_generic_subp_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_subp_instantiation_f_params = _import_func(
    'ada_generic_subp_instantiation_f_params',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_subp_instantiation_f_aspects = _import_func(
    'ada_generic_subp_instantiation_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_package_renaming_decl_f_name = _import_func(
    'ada_generic_package_renaming_decl_f_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_package_renaming_decl_f_renames = _import_func(
    'ada_generic_package_renaming_decl_f_renames',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_package_renaming_decl_f_aspects = _import_func(
    'ada_generic_package_renaming_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_subp_renaming_decl_f_kind = _import_func(
    'ada_generic_subp_renaming_decl_f_kind',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_subp_renaming_decl_f_name = _import_func(
    'ada_generic_subp_renaming_decl_f_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_subp_renaming_decl_f_renames = _import_func(
    'ada_generic_subp_renaming_decl_f_renames',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_generic_subp_renaming_decl_f_aspects = _import_func(
    'ada_generic_subp_renaming_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_label_decl_f_name = _import_func(
    'ada_label_decl_f_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_label_decl_f_aspects = _import_func(
    'ada_label_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_named_stmt_decl_f_name = _import_func(
    'ada_named_stmt_decl_f_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_named_stmt_decl_f_aspects = _import_func(
    'ada_named_stmt_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_number_decl_f_ids = _import_func(
    'ada_number_decl_f_ids',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_number_decl_f_expr = _import_func(
    'ada_number_decl_f_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_number_decl_f_aspects = _import_func(
    'ada_number_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_object_decl_f_ids = _import_func(
    'ada_object_decl_f_ids',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_object_decl_f_has_aliased = _import_func(
    'ada_object_decl_f_has_aliased',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_object_decl_f_has_constant = _import_func(
    'ada_object_decl_f_has_constant',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_object_decl_f_mode = _import_func(
    'ada_object_decl_f_mode',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_object_decl_f_type_expr = _import_func(
    'ada_object_decl_f_type_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_object_decl_f_default_expr = _import_func(
    'ada_object_decl_f_default_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_object_decl_f_renaming_clause = _import_func(
    'ada_object_decl_f_renaming_clause',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_object_decl_f_aspects = _import_func(
    'ada_object_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_object_decl_p_public_part_decl = _import_func(
    'ada_object_decl_p_public_part_decl',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_package_renaming_decl_f_name = _import_func(
    'ada_package_renaming_decl_f_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_package_renaming_decl_f_renames = _import_func(
    'ada_package_renaming_decl_f_renames',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_package_renaming_decl_f_aspects = _import_func(
    'ada_package_renaming_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_single_protected_decl_f_name = _import_func(
    'ada_single_protected_decl_f_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_single_protected_decl_f_aspects = _import_func(
    'ada_single_protected_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_single_protected_decl_f_interfaces = _import_func(
    'ada_single_protected_decl_f_interfaces',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_single_protected_decl_f_definition = _import_func(
    'ada_single_protected_decl_f_definition',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_single_task_decl_f_task_type = _import_func(
    'ada_single_task_decl_f_task_type',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_single_task_decl_f_aspects = _import_func(
    'ada_single_task_decl_f_aspects',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_case_stmt_alternative_f_choices = _import_func(
    'ada_case_stmt_alternative_f_choices',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_case_stmt_alternative_f_stmts = _import_func(
    'ada_case_stmt_alternative_f_stmts',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_compilation_unit_f_prelude = _import_func(
    'ada_compilation_unit_f_prelude',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_compilation_unit_f_body = _import_func(
    'ada_compilation_unit_f_body',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_compilation_unit_f_pragmas = _import_func(
    'ada_compilation_unit_f_pragmas',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_compilation_unit_p_syntactic_fully_qualified_name = _import_func(
    'ada_compilation_unit_p_syntactic_fully_qualified_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_UnboundedTextTypeArrayConverter.c_type)],
    ctypes.c_int
)
_compilation_unit_p_unit_kind = _import_func(
    'ada_compilation_unit_p_unit_kind',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_int)],
    ctypes.c_int
)
_component_clause_f_id = _import_func(
    'ada_component_clause_f_id',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_component_clause_f_position = _import_func(
    'ada_component_clause_f_position',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_component_clause_f_range = _import_func(
    'ada_component_clause_f_range',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_component_def_f_has_aliased = _import_func(
    'ada_component_def_f_has_aliased',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_component_def_f_has_constant = _import_func(
    'ada_component_def_f_has_constant',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_component_def_f_type_expr = _import_func(
    'ada_component_def_f_type_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_constant_node_p_as_bool = _import_func(
    'ada_constant_node_p_as_bool',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_delta_constraint_f_digits = _import_func(
    'ada_delta_constraint_f_digits',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_delta_constraint_f_range = _import_func(
    'ada_delta_constraint_f_range',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_digits_constraint_f_digits = _import_func(
    'ada_digits_constraint_f_digits',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_digits_constraint_f_range = _import_func(
    'ada_digits_constraint_f_range',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_discriminant_constraint_f_constraints = _import_func(
    'ada_discriminant_constraint_f_constraints',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_index_constraint_f_constraints = _import_func(
    'ada_index_constraint_f_constraints',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_range_constraint_f_range = _import_func(
    'ada_range_constraint_f_range',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_declarative_part_f_decls = _import_func(
    'ada_declarative_part_f_decls',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_elsif_expr_part_f_cond_expr = _import_func(
    'ada_elsif_expr_part_f_cond_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_elsif_expr_part_f_then_expr = _import_func(
    'ada_elsif_expr_part_f_then_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_elsif_stmt_part_f_cond_expr = _import_func(
    'ada_elsif_stmt_part_f_cond_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_elsif_stmt_part_f_stmts = _import_func(
    'ada_elsif_stmt_part_f_stmts',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_expr_p_is_static_expr = _import_func(
    'ada_expr_p_is_static_expr',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.c_uint8,
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_expr_p_first_corresponding_decl = _import_func(
    'ada_expr_p_first_corresponding_decl',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_expr_p_eval_as_int = _import_func(
    'ada_expr_p_eval_as_int',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_big_integer.c_type)],
    ctypes.c_int
)
_expr_p_matching_nodes = _import_func(
    'ada_expr_p_matching_nodes',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_AdaNodeArrayConverter.c_type)],
    ctypes.c_int
)
_allocator_f_subpool = _import_func(
    'ada_allocator_f_subpool',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_allocator_f_type_or_expr = _import_func(
    'ada_allocator_f_type_or_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_allocator_p_get_allocated_type = _import_func(
    'ada_allocator_p_get_allocated_type',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_aggregate_f_ancestor_expr = _import_func(
    'ada_base_aggregate_f_ancestor_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_aggregate_f_assocs = _import_func(
    'ada_base_aggregate_f_assocs',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_bin_op_f_left = _import_func(
    'ada_bin_op_f_left',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_bin_op_f_op = _import_func(
    'ada_bin_op_f_op',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_bin_op_f_right = _import_func(
    'ada_bin_op_f_right',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_case_expr_f_expr = _import_func(
    'ada_case_expr_f_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_case_expr_f_cases = _import_func(
    'ada_case_expr_f_cases',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_case_expr_alternative_f_choices = _import_func(
    'ada_case_expr_alternative_f_choices',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_case_expr_alternative_f_expr = _import_func(
    'ada_case_expr_alternative_f_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_contract_cases_f_contract_cases = _import_func(
    'ada_contract_cases_f_contract_cases',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_if_expr_f_cond_expr = _import_func(
    'ada_if_expr_f_cond_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_if_expr_f_then_expr = _import_func(
    'ada_if_expr_f_then_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_if_expr_f_alternatives = _import_func(
    'ada_if_expr_f_alternatives',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_if_expr_f_else_expr = _import_func(
    'ada_if_expr_f_else_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_membership_expr_f_expr = _import_func(
    'ada_membership_expr_f_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_membership_expr_f_op = _import_func(
    'ada_membership_expr_f_op',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_membership_expr_f_membership_exprs = _import_func(
    'ada_membership_expr_f_membership_exprs',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_name_p_enclosing_defining_name = _import_func(
    'ada_name_p_enclosing_defining_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_name_p_is_defining = _import_func(
    'ada_name_p_is_defining',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_name_p_name_is = _import_func(
    'ada_name_p_name_is',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.POINTER(_symbol_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_name_p_is_call = _import_func(
    'ada_name_p_is_call',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_name_p_is_dot_call = _import_func(
    'ada_name_p_is_dot_call',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.c_uint8,
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_name_p_referenced_id = _import_func(
    'ada_name_p_referenced_id',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_name_p_all_env_elements = _import_func(
    'ada_name_p_all_env_elements',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.c_uint8,
        ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_AdaNodeArrayConverter.c_type)],
    ctypes.c_int
)
_name_p_name_designated_type = _import_func(
    'ada_name_p_name_designated_type',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_name_p_name_matches = _import_func(
    'ada_name_p_name_matches',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_name_p_relative_name = _import_func(
    'ada_name_p_relative_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_name_p_as_symbol_array = _import_func(
    'ada_name_p_as_symbol_array',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_UnboundedTextTypeArrayConverter.c_type)],
    ctypes.c_int
)
_attribute_ref_f_prefix = _import_func(
    'ada_attribute_ref_f_prefix',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_attribute_ref_f_attribute = _import_func(
    'ada_attribute_ref_f_attribute',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_attribute_ref_f_args = _import_func(
    'ada_attribute_ref_f_args',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_call_expr_f_name = _import_func(
    'ada_call_expr_f_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_call_expr_f_suffix = _import_func(
    'ada_call_expr_f_suffix',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_defining_name_f_name = _import_func(
    'ada_defining_name_f_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_defining_name_p_basic_decl = _import_func(
    'ada_defining_name_p_basic_decl',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_defining_name_p_find_all_references = _import_func(
    'ada_defining_name_p_find_all_references',
    [ctypes.POINTER(_Entity_c_type),
        _AnalysisUnitArrayConverter.c_type,
        ctypes.c_uint8,
     ctypes.POINTER(_AdaNodeArrayConverter.c_type)],
    ctypes.c_int
)
_defining_name_p_next_part = _import_func(
    'ada_defining_name_p_next_part',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_defining_name_p_previous_part = _import_func(
    'ada_defining_name_p_previous_part',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_defining_name_p_canonical_part = _import_func(
    'ada_defining_name_p_canonical_part',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_discrete_subtype_name_f_subtype = _import_func(
    'ada_discrete_subtype_name_f_subtype',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_dotted_name_f_prefix = _import_func(
    'ada_dotted_name_f_prefix',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_dotted_name_f_suffix = _import_func(
    'ada_dotted_name_f_suffix',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_end_name_f_name = _import_func(
    'ada_end_name_f_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_end_name_p_basic_decl = _import_func(
    'ada_end_name_p_basic_decl',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_explicit_deref_f_prefix = _import_func(
    'ada_explicit_deref_f_prefix',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_qual_expr_f_prefix = _import_func(
    'ada_qual_expr_f_prefix',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_qual_expr_f_suffix = _import_func(
    'ada_qual_expr_f_suffix',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_char_literal_p_denoted_value = _import_func(
    'ada_char_literal_p_denoted_value',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint32)],
    ctypes.c_int
)
_string_literal_p_denoted_value = _import_func(
    'ada_string_literal_p_denoted_value',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_TextTypeConverter.c_type)],
    ctypes.c_int
)
_int_literal_p_denoted_value = _import_func(
    'ada_int_literal_p_denoted_value',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_big_integer.c_type)],
    ctypes.c_int
)
_paren_expr_f_expr = _import_func(
    'ada_paren_expr_f_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_quantified_expr_f_quantifier = _import_func(
    'ada_quantified_expr_f_quantifier',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_quantified_expr_f_loop_spec = _import_func(
    'ada_quantified_expr_f_loop_spec',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_quantified_expr_f_expr = _import_func(
    'ada_quantified_expr_f_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_raise_expr_f_exception_name = _import_func(
    'ada_raise_expr_f_exception_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_raise_expr_f_error_message = _import_func(
    'ada_raise_expr_f_error_message',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_un_op_f_op = _import_func(
    'ada_un_op_f_op',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_un_op_f_expr = _import_func(
    'ada_un_op_f_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_handled_stmts_f_stmts = _import_func(
    'ada_handled_stmts_f_stmts',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_handled_stmts_f_exceptions = _import_func(
    'ada_handled_stmts_f_exceptions',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_library_item_f_has_private = _import_func(
    'ada_library_item_f_has_private',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_library_item_f_item = _import_func(
    'ada_library_item_f_item',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_limited_node_p_as_bool = _import_func(
    'ada_limited_node_p_as_bool',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_for_loop_spec_f_var_decl = _import_func(
    'ada_for_loop_spec_f_var_decl',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_for_loop_spec_f_loop_type = _import_func(
    'ada_for_loop_spec_f_loop_type',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_for_loop_spec_f_has_reverse = _import_func(
    'ada_for_loop_spec_f_has_reverse',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_for_loop_spec_f_iter_expr = _import_func(
    'ada_for_loop_spec_f_iter_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_while_loop_spec_f_expr = _import_func(
    'ada_while_loop_spec_f_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_not_null_p_as_bool = _import_func(
    'ada_not_null_p_as_bool',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_params_f_params = _import_func(
    'ada_params_f_params',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_pragma_node_f_id = _import_func(
    'ada_pragma_node_f_id',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_pragma_node_f_args = _import_func(
    'ada_pragma_node_f_args',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_pragma_node_p_associated_decls = _import_func(
    'ada_pragma_node_p_associated_decls',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_AdaNodeArrayConverter.c_type)],
    ctypes.c_int
)
_private_node_p_as_bool = _import_func(
    'ada_private_node_p_as_bool',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_protected_def_f_public_part = _import_func(
    'ada_protected_def_f_public_part',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_protected_def_f_private_part = _import_func(
    'ada_protected_def_f_private_part',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_protected_def_f_end_name = _import_func(
    'ada_protected_def_f_end_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_protected_node_p_as_bool = _import_func(
    'ada_protected_node_p_as_bool',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_range_spec_f_range = _import_func(
    'ada_range_spec_f_range',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_renaming_clause_f_renamed_object = _import_func(
    'ada_renaming_clause_f_renamed_object',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_reverse_node_p_as_bool = _import_func(
    'ada_reverse_node_p_as_bool',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_select_when_part_f_cond_expr = _import_func(
    'ada_select_when_part_f_cond_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_select_when_part_f_stmts = _import_func(
    'ada_select_when_part_f_stmts',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_accept_stmt_f_name = _import_func(
    'ada_accept_stmt_f_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_accept_stmt_f_entry_index_expr = _import_func(
    'ada_accept_stmt_f_entry_index_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_accept_stmt_f_params = _import_func(
    'ada_accept_stmt_f_params',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_accept_stmt_with_stmts_f_stmts = _import_func(
    'ada_accept_stmt_with_stmts_f_stmts',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_accept_stmt_with_stmts_f_end_name = _import_func(
    'ada_accept_stmt_with_stmts_f_end_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_loop_stmt_f_spec = _import_func(
    'ada_base_loop_stmt_f_spec',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_loop_stmt_f_stmts = _import_func(
    'ada_base_loop_stmt_f_stmts',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_base_loop_stmt_f_end_name = _import_func(
    'ada_base_loop_stmt_f_end_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_begin_block_f_stmts = _import_func(
    'ada_begin_block_f_stmts',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_begin_block_f_end_name = _import_func(
    'ada_begin_block_f_end_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_decl_block_f_decls = _import_func(
    'ada_decl_block_f_decls',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_decl_block_f_stmts = _import_func(
    'ada_decl_block_f_stmts',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_decl_block_f_end_name = _import_func(
    'ada_decl_block_f_end_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_case_stmt_f_expr = _import_func(
    'ada_case_stmt_f_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_case_stmt_f_alternatives = _import_func(
    'ada_case_stmt_f_alternatives',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_extended_return_stmt_f_decl = _import_func(
    'ada_extended_return_stmt_f_decl',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_extended_return_stmt_f_stmts = _import_func(
    'ada_extended_return_stmt_f_stmts',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_if_stmt_f_cond_expr = _import_func(
    'ada_if_stmt_f_cond_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_if_stmt_f_then_stmts = _import_func(
    'ada_if_stmt_f_then_stmts',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_if_stmt_f_alternatives = _import_func(
    'ada_if_stmt_f_alternatives',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_if_stmt_f_else_stmts = _import_func(
    'ada_if_stmt_f_else_stmts',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_named_stmt_f_decl = _import_func(
    'ada_named_stmt_f_decl',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_named_stmt_f_stmt = _import_func(
    'ada_named_stmt_f_stmt',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_select_stmt_f_guards = _import_func(
    'ada_select_stmt_f_guards',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_select_stmt_f_else_stmts = _import_func(
    'ada_select_stmt_f_else_stmts',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_select_stmt_f_abort_stmts = _import_func(
    'ada_select_stmt_f_abort_stmts',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_abort_stmt_f_names = _import_func(
    'ada_abort_stmt_f_names',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_assign_stmt_f_dest = _import_func(
    'ada_assign_stmt_f_dest',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_assign_stmt_f_expr = _import_func(
    'ada_assign_stmt_f_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_call_stmt_f_call = _import_func(
    'ada_call_stmt_f_call',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_delay_stmt_f_has_until = _import_func(
    'ada_delay_stmt_f_has_until',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_delay_stmt_f_expr = _import_func(
    'ada_delay_stmt_f_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_exit_stmt_f_loop_name = _import_func(
    'ada_exit_stmt_f_loop_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_exit_stmt_f_cond_expr = _import_func(
    'ada_exit_stmt_f_cond_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_goto_stmt_f_label_name = _import_func(
    'ada_goto_stmt_f_label_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_label_f_decl = _import_func(
    'ada_label_f_decl',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_raise_stmt_f_exception_name = _import_func(
    'ada_raise_stmt_f_exception_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_raise_stmt_f_error_message = _import_func(
    'ada_raise_stmt_f_error_message',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_requeue_stmt_f_call_name = _import_func(
    'ada_requeue_stmt_f_call_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_requeue_stmt_f_has_abort = _import_func(
    'ada_requeue_stmt_f_has_abort',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_return_stmt_f_return_expr = _import_func(
    'ada_return_stmt_f_return_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_subunit_f_name = _import_func(
    'ada_subunit_f_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_subunit_f_body = _import_func(
    'ada_subunit_f_body',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_synchronized_node_p_as_bool = _import_func(
    'ada_synchronized_node_p_as_bool',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_tagged_node_p_as_bool = _import_func(
    'ada_tagged_node_p_as_bool',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_task_def_f_interfaces = _import_func(
    'ada_task_def_f_interfaces',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_task_def_f_public_part = _import_func(
    'ada_task_def_f_public_part',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_task_def_f_private_part = _import_func(
    'ada_task_def_f_private_part',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_task_def_f_end_name = _import_func(
    'ada_task_def_f_end_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_type_def_p_is_tagged_type = _import_func(
    'ada_type_def_p_is_tagged_type',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_access_def_f_has_not_null = _import_func(
    'ada_access_def_f_has_not_null',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_access_to_subp_def_f_has_protected = _import_func(
    'ada_access_to_subp_def_f_has_protected',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_access_to_subp_def_f_subp_spec = _import_func(
    'ada_access_to_subp_def_f_subp_spec',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_anonymous_type_access_def_f_type_decl = _import_func(
    'ada_anonymous_type_access_def_f_type_decl',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_type_access_def_f_has_all = _import_func(
    'ada_type_access_def_f_has_all',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_type_access_def_f_has_constant = _import_func(
    'ada_type_access_def_f_has_constant',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_type_access_def_f_subtype_indication = _import_func(
    'ada_type_access_def_f_subtype_indication',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_array_type_def_f_indices = _import_func(
    'ada_array_type_def_f_indices',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_array_type_def_f_component_type = _import_func(
    'ada_array_type_def_f_component_type',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_derived_type_def_f_has_abstract = _import_func(
    'ada_derived_type_def_f_has_abstract',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_derived_type_def_f_has_limited = _import_func(
    'ada_derived_type_def_f_has_limited',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_derived_type_def_f_has_synchronized = _import_func(
    'ada_derived_type_def_f_has_synchronized',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_derived_type_def_f_subtype_indication = _import_func(
    'ada_derived_type_def_f_subtype_indication',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_derived_type_def_f_interfaces = _import_func(
    'ada_derived_type_def_f_interfaces',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_derived_type_def_f_record_extension = _import_func(
    'ada_derived_type_def_f_record_extension',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_derived_type_def_f_has_with_private = _import_func(
    'ada_derived_type_def_f_has_with_private',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_enum_type_def_f_enum_literals = _import_func(
    'ada_enum_type_def_f_enum_literals',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_interface_type_def_f_interface_kind = _import_func(
    'ada_interface_type_def_f_interface_kind',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_interface_type_def_f_interfaces = _import_func(
    'ada_interface_type_def_f_interfaces',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_mod_int_type_def_f_expr = _import_func(
    'ada_mod_int_type_def_f_expr',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_private_type_def_f_has_abstract = _import_func(
    'ada_private_type_def_f_has_abstract',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_private_type_def_f_has_tagged = _import_func(
    'ada_private_type_def_f_has_tagged',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_private_type_def_f_has_limited = _import_func(
    'ada_private_type_def_f_has_limited',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_decimal_fixed_point_def_f_delta = _import_func(
    'ada_decimal_fixed_point_def_f_delta',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_decimal_fixed_point_def_f_digits = _import_func(
    'ada_decimal_fixed_point_def_f_digits',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_decimal_fixed_point_def_f_range = _import_func(
    'ada_decimal_fixed_point_def_f_range',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_floating_point_def_f_num_digits = _import_func(
    'ada_floating_point_def_f_num_digits',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_floating_point_def_f_range = _import_func(
    'ada_floating_point_def_f_range',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_ordinary_fixed_point_def_f_delta = _import_func(
    'ada_ordinary_fixed_point_def_f_delta',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_ordinary_fixed_point_def_f_range = _import_func(
    'ada_ordinary_fixed_point_def_f_range',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_record_type_def_f_has_abstract = _import_func(
    'ada_record_type_def_f_has_abstract',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_record_type_def_f_has_tagged = _import_func(
    'ada_record_type_def_f_has_tagged',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_record_type_def_f_has_limited = _import_func(
    'ada_record_type_def_f_has_limited',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_record_type_def_f_record_def = _import_func(
    'ada_record_type_def_f_record_def',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_signed_int_type_def_f_range = _import_func(
    'ada_signed_int_type_def_f_range',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_type_expr_p_type_name = _import_func(
    'ada_type_expr_p_type_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_type_expr_p_designated_type_decl = _import_func(
    'ada_type_expr_p_designated_type_decl',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_type_expr_p_designated_type_decl_from = _import_func(
    'ada_type_expr_p_designated_type_decl_from',
    [ctypes.POINTER(_Entity_c_type),
        ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_anonymous_type_f_type_decl = _import_func(
    'ada_anonymous_type_f_type_decl',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_subtype_indication_f_has_not_null = _import_func(
    'ada_subtype_indication_f_has_not_null',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_subtype_indication_f_name = _import_func(
    'ada_subtype_indication_f_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_subtype_indication_f_constraint = _import_func(
    'ada_subtype_indication_f_constraint',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_unconstrained_array_index_f_subtype_indication = _import_func(
    'ada_unconstrained_array_index_f_subtype_indication',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_until_node_p_as_bool = _import_func(
    'ada_until_node_p_as_bool',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
_use_package_clause_f_packages = _import_func(
    'ada_use_package_clause_f_packages',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_use_type_clause_f_has_all = _import_func(
    'ada_use_type_clause_f_has_all',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_use_type_clause_f_types = _import_func(
    'ada_use_type_clause_f_types',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_variant_f_choices = _import_func(
    'ada_variant_f_choices',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_variant_f_components = _import_func(
    'ada_variant_f_components',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_variant_part_f_discr_name = _import_func(
    'ada_variant_part_f_discr_name',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_variant_part_f_variant = _import_func(
    'ada_variant_part_f_variant',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_with_clause_f_has_limited = _import_func(
    'ada_with_clause_f_has_limited',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_with_clause_f_has_private = _import_func(
    'ada_with_clause_f_has_private',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_with_clause_f_packages = _import_func(
    'ada_with_clause_f_packages',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(_Entity_c_type)],
    ctypes.c_int
)
_with_private_p_as_bool = _import_func(
    'ada_with_private_p_as_bool',
    [ctypes.POINTER(_Entity_c_type),
     ctypes.POINTER(ctypes.c_uint8)],
    ctypes.c_int
)
# Unit providers
_destroy_unit_provider = _import_func(
    'ada_destroy_unit_provider',
    [_unit_provider], None
)
class _project_scenario_variable(ctypes.Structure):
    _fields_ = [('name', ctypes.c_char_p),
                ('value', ctypes.c_char_p)]
_create_project_unit_provider = _import_func(
    'ada_create_project_unit_provider',
    [ctypes.c_char_p,
     ctypes.POINTER(_project_scenario_variable),
     ctypes.c_char_p,
     ctypes.c_char_p],
    _unit_provider
)
_create_auto_provider = _import_func(
    'ada_create_auto_provider',
    [ctypes.POINTER(ctypes.c_char_p), ctypes.c_char_p],
    _unit_provider
)
# Misc
_token_kind_name = _import_func(
   "ada_token_kind_name",
   [ctypes.c_int], ctypes.POINTER(ctypes.c_char)
)
_token_next = _import_func(
    "ada_token_next",
    [ctypes.POINTER(Token), ctypes.POINTER(Token)], None
)
_token_is_equivalent = _import_func(
    "ada_token_is_equivalent",
    [ctypes.POINTER(Token), ctypes.POINTER(Token)], ctypes.c_int
)
_token_previous = _import_func(
    "ada_token_previous",
    [ctypes.POINTER(Token), ctypes.POINTER(Token)], None
)
_token_range_text = _import_func(
    "ada_token_range_text",
    [ctypes.POINTER(Token), ctypes.POINTER(Token), ctypes.POINTER(_text)],
    ctypes.c_int
)
_entity_image = _import_func(
    "ada_entity_image",
    [ctypes.POINTER(_Entity_c_type)], _text
)
#
# Layering helpers
#
def _unwrap_str(c_char_p_value):
    """
    Assuming c_char_p_value is a valid char*, convert it to a native Python
    string and free the C pointer.
    """
    result = ctypes.c_char_p(ctypes.addressof(c_char_p_value.contents)).value
    _free(c_char_p_value)
    return result
_kind_to_astnode_cls = {
    1: AbortAbsent,
    2: AbortPresent,
    3: AbstractAbsent,
    4: AbstractPresent,
    5: AdaNodeList,
    6: AlternativesList,
    7: ConstraintList,
    8: DeclList,
    9: StmtList,
    10: AspectAssocList,
    11: BaseAssocList,
    12: AssocList,
    13: CaseExprAlternativeList,
    14: CaseStmtAlternativeList,
    15: CompilationUnitList,
    16: ContractCaseAssocList,
    17: DefiningNameList,
    18: DiscriminantSpecList,
    19: ElsifExprPartList,
    20: ElsifStmtPartList,
    21: EnumLiteralDeclList,
    22: ExprAlternativesList,
    23: DiscriminantChoiceList,
    24: NameList,
    25: ParentList,
    26: ParamSpecList,
    27: PragmaNodeList,
    28: SelectWhenPartList,
    29: UnconstrainedArrayIndexList,
    30: VariantList,
    31: AliasedAbsent,
    32: AliasedPresent,
    33: AllAbsent,
    34: AllPresent,
    35: ConstrainedArrayIndices,
    36: UnconstrainedArrayIndices,
    37: AspectAssoc,
    38: AtClause,
    39: AttributeDefClause,
    40: EnumRepClause,
    41: RecordRepClause,
    42: AspectSpec,
    43: ContractCaseAssoc,
    44: PragmaArgumentAssoc,
    45: EntrySpec,
    46: SubpSpec,
    47: ComponentList,
    48: KnownDiscriminantPart,
    49: UnknownDiscriminantPart,
    50: GenericFormalPart,
    51: NullRecordDef,
    52: RecordDef,
    53: AggregateAssoc,
    54: MultiDimArrayAssoc,
    55: DiscriminantAssoc,
    56: ParamAssoc,
    57: ComponentDecl,
    58: DiscriminantSpec,
    59: GenericFormalObjDecl,
    60: GenericFormalPackage,
    61: GenericFormalSubpDecl,
    62: GenericFormalTypeDecl,
    63: ParamSpec,
    64: GenericPackageInternal,
    65: PackageDecl,
    66: DiscreteBaseSubtypeDecl,
    67: SubtypeDecl,
    68: ClasswideTypeDecl,
    69: IncompleteTypeDecl,
    70: IncompleteTaggedTypeDecl,
    71: ProtectedTypeDecl,
    72: TaskTypeDecl,
    73: SingleTaskTypeDecl,
    74: TypeDecl,
    75: AnonymousTypeDecl,
    76: SynthAnonymousTypeDecl,
    77: AbstractSubpDecl,
    78: AbstractFormalSubpDecl,
    79: ConcreteFormalSubpDecl,
    80: NullSubpDecl,
    81: SubpDecl,
    82: SubpRenamingDecl,
    83: GenericSubpInternal,
    84: ExprFunction,
    85: SubpBody,
    86: PackageBodyStub,
    87: ProtectedBodyStub,
    88: SubpBodyStub,
    89: TaskBodyStub,
    90: EntryBody,
    91: PackageBody,
    92: ProtectedBody,
    93: TaskBody,
    94: EntryDecl,
    95: EntryIndexSpec,
    96: EnumLiteralDecl,
    97: ErrorDecl,
    98: ExceptionDecl,
    99: ExceptionHandler,
    100: ForLoopVarDecl,
    101: GenericPackageDecl,
    102: GenericSubpDecl,
    103: GenericPackageInstantiation,
    104: GenericSubpInstantiation,
    105: GenericPackageRenamingDecl,
    106: GenericSubpRenamingDecl,
    107: LabelDecl,
    108: NamedStmtDecl,
    109: NumberDecl,
    110: ObjectDecl,
    111: ExtendedReturnStmtObjectDecl,
    112: PackageRenamingDecl,
    113: SingleProtectedDecl,
    114: SingleTaskDecl,
    115: CaseStmtAlternative,
    116: CompilationUnit,
    117: ComponentClause,
    118: ComponentDef,
    119: ConstantAbsent,
    120: ConstantPresent,
    121: DeltaConstraint,
    122: DigitsConstraint,
    123: DiscriminantConstraint,
    124: IndexConstraint,
    125: RangeConstraint,
    126: DeclarativePart,
    127: PrivatePart,
    128: PublicPart,
    129: ElsifExprPart,
    130: ElsifStmtPart,
    131: Allocator,
    132: Aggregate,
    133: NullRecordAggregate,
    134: BinOp,
    135: RelationOp,
    136: BoxExpr,
    137: CaseExpr,
    138: CaseExprAlternative,
    139: ContractCases,
    140: IfExpr,
    141: MembershipExpr,
    142: AttributeRef,
    143: UpdateAttributeRef,
    144: CallExpr,
    145: DefiningName,
    146: DiscreteSubtypeName,
    147: DottedName,
    148: EndName,
    149: ExplicitDeref,
    150: QualExpr,
    151: CharLiteral,
    152: Identifier,
    153: StringLiteral,
    154: NullLiteral,
    155: IntLiteral,
    156: RealLiteral,
    157: TargetName,
    158: ParenExpr,
    159: QuantifiedExpr,
    160: RaiseExpr,
    161: UnOp,
    162: HandledStmts,
    163: InterfaceKindLimited,
    164: InterfaceKindProtected,
    165: InterfaceKindSynchronized,
    166: InterfaceKindTask,
    167: IterTypeIn,
    168: IterTypeOf,
    169: LibraryItem,
    170: LimitedAbsent,
    171: LimitedPresent,
    172: ForLoopSpec,
    173: WhileLoopSpec,
    174: ModeDefault,
    175: ModeIn,
    176: ModeInOut,
    177: ModeOut,
    178: NotNullAbsent,
    179: NotNullPresent,
    180: NullComponentDecl,
    181: OpAbs,
    182: OpAnd,
    183: OpAndThen,
    184: OpConcat,
    185: OpDiv,
    186: OpDoubleDot,
    187: OpEq,
    188: OpGt,
    189: OpGte,
    190: OpIn,
    191: OpLt,
    192: OpLte,
    193: OpMinus,
    194: OpMod,
    195: OpMult,
    196: OpNeq,
    197: OpNot,
    198: OpNotIn,
    199: OpOr,
    200: OpOrElse,
    201: OpPlus,
    202: OpPow,
    203: OpRem,
    204: OpXor,
    205: OthersDesignator,
    206: OverridingNotOverriding,
    207: OverridingOverriding,
    208: OverridingUnspecified,
    209: Params,
    210: PragmaNode,
    211: PrivateAbsent,
    212: PrivatePresent,
    213: ProtectedDef,
    214: ProtectedAbsent,
    215: ProtectedPresent,
    216: QuantifierAll,
    217: QuantifierSome,
    218: RangeSpec,
    219: RenamingClause,
    220: ReverseAbsent,
    221: ReversePresent,
    222: SelectWhenPart,
    223: AcceptStmt,
    224: AcceptStmtWithStmts,
    225: ForLoopStmt,
    226: LoopStmt,
    227: WhileLoopStmt,
    228: BeginBlock,
    229: DeclBlock,
    230: CaseStmt,
    231: ExtendedReturnStmt,
    232: IfStmt,
    233: NamedStmt,
    234: SelectStmt,
    235: ErrorStmt,
    236: AbortStmt,
    237: AssignStmt,
    238: CallStmt,
    239: DelayStmt,
    240: ExitStmt,
    241: GotoStmt,
    242: Label,
    243: NullStmt,
    244: RaiseStmt,
    245: RequeueStmt,
    246: ReturnStmt,
    247: TerminateAlternative,
    248: SubpKindFunction,
    249: SubpKindProcedure,
    250: Subunit,
    251: SynchronizedAbsent,
    252: SynchronizedPresent,
    253: TaggedAbsent,
    254: TaggedPresent,
    255: TaskDef,
    256: AccessToSubpDef,
    257: AnonymousTypeAccessDef,
    258: TypeAccessDef,
    259: ArrayTypeDef,
    260: DerivedTypeDef,
    261: EnumTypeDef,
    262: FormalDiscreteTypeDef,
    263: InterfaceTypeDef,
    264: ModIntTypeDef,
    265: PrivateTypeDef,
    266: DecimalFixedPointDef,
    267: FloatingPointDef,
    268: OrdinaryFixedPointDef,
    269: RecordTypeDef,
    270: SignedIntTypeDef,
    271: AnonymousType,
    272: SubtypeIndication,
    273: ConstrainedSubtypeIndication,
    274: DiscreteSubtypeIndication,
    275: UnconstrainedArrayIndex,
    276: UntilAbsent,
    277: UntilPresent,
    278: UsePackageClause,
    279: UseTypeClause,
    280: Variant,
    281: VariantPart,
    282: WithClause,
    283: WithPrivateAbsent,
    284: WithPrivatePresent,
}
def _field_address(struct, field_name):
    """
    Get the address of a structure field from a structure value.

    For instance::

        class Foo(ctypes.Structure):
            _fields_ = [('i', ctypes.c_int)]

        f = Foo()
        i_addr =_field_address(f, 'i')
    """
    struct_type = type(struct)
    struct_addr = ctypes.addressof(struct)
    field = getattr(struct_type, field_name)
    field_type = None
    for f_name, f_type in struct_type._fields_:
        if f_name == field_name:
            field_type = f_type
            break
    assert field_type is not None
    return struct_addr + field.offset
#
# Language specific extensions #
#
def token_match(self, other):
    """
    Helper for the finditer/find/findall methods, so that a token matches
    another token even if they are not strictly equivalent.
    """
    return self == other or self.text == other
@property
def full_name(n):
    """
    Return a nicely pretty printed name for any expr that is only formed of
    DottedName and Identifier instances.
    """
    if isinstance(n, DottedName):
        return "{}.{}".format(n.f_prefix.full_name, n.f_suffix.full_name)
    elif isinstance(n, BaseId):
        return n.text
    else:
        raise Exception("Wrong type for name: {}".format(type(n)))
Token.match = token_match
Name.full_name = full_name