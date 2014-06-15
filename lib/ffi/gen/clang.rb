require 'ffi'
require 'ffi/gen/clang/enums'

module FFI::Gen::Clang
  extend FFI::Library
  ffi_lib 'clang'

  autoload :String, 'ffi/gen/clang/string'
  autoload :TranslationUnit, 'ffi/gen/clang/translation_unit'
  autoload :UnsavedFile, 'ffi/gen/clang/unsaved_file'
  autoload :Version, 'ffi/gen/clang/version'
  autoload :FileUniqueID, 'ffi/gen/clang/file_unique_id'
  autoload :SourceLocation, 'ffi/gen/clang/source_location'
  autoload :SourceRange, 'ffi/gen/clang/source_range'
  autoload :TUResourceUsageEntry, 'ffi/gen/clang/tu_resource_usage_entry'
  autoload :TUResourceUsage, 'ffi/gen/clang/tu_resource_usage'
  autoload :Cursor, 'ffi/gen/clang/cursor'
  autoload :Comment, 'ffi/gen/clang/comment'
  autoload :PlatformAvailability, 'ffi/gen/clang/platform_availability'
  autoload :CursorSet, 'ffi/gen/clang/cursor_set'
  autoload :Type, 'ffi/gen/clang/type'
  autoload :Token, 'ffi/gen/clang/token'
  autoload :CompletionResult, 'ffi/gen/clang/completion_result'
  autoload :CodeCompleteResults, 'ffi/gen/clang/code_complete_results'
  autoload :CursorAndRangeVisitor, 'ffi/gen/clang/cursor_and_range_visitor'
  autoload :IdxLoc, 'ffi/gen/clang/idx_loc'
  autoload :IdxIncludedFileInfo, 'ffi/gen/clang/idx_included_file_info'
  autoload :IdxImportedASTFileInfo, 'ffi/gen/clang/idx_imported_ast_file_info'
  autoload :IdxAttrInfo, 'ffi/gen/clang/idx_attr_info'
  autoload :IdxEntityInfo, 'ffi/gen/clang/idx_entity_info'
  autoload :IdxContainerInfo, 'ffi/gen/clang/idx_container_info'
  autoload :IdxIBOutletCollectionAttrInfo, 'ffi/gen/clang/idx_ib_outlet_collection_attr_info'
  autoload :IdxDeclInfo, 'ffi/gen/clang/idx_decl_info'
  autoload :IdxObjCContainerDeclInfo, 'ffi/gen/clang/idx_obj_c_container_decl_info'
  autoload :IdxBaseClassInfo, 'ffi/gen/clang/idx_base_class_info'
  autoload :IdxObjCProtocolRefInfo, 'ffi/gen/clang/idx_obj_c_protocol_ref_info'
  autoload :IdxObjCProtocolRefListInfo, 'ffi/gen/clang/idx_obj_c_protocol_ref_list_info'
  autoload :IdxObjCInterfaceDeclInfo, 'ffi/gen/clang/idx_obj_c_interface_decl_info'
  autoload :IdxObjCCategoryDeclInfo, 'ffi/gen/clang/idx_obj_c_category_decl_info'
  autoload :IdxObjCPropertyDeclInfo, 'ffi/gen/clang/idx_obj_c_property_decl_info'
  autoload :IdxCXXClassDeclInfo, 'ffi/gen/clang/idx_cxx_class_decl_info'
  autoload :IdxEntityRefInfo, 'ffi/gen/clang/idx_entity_ref_info'
  autoload :IndexerCallbacks, 'ffi/gen/clang/indexer_callbacks'

  # Visitor invoked for each cursor found by a traversal.
  #
  # This visitor function will be invoked for each cursor found by
  # clang_visitCursorChildren(). Its first argument is the cursor being
  # visited, its second argument is the parent visitor for that cursor,
  # and its third argument is the client data provided to
  # clang_visitCursorChildren().
  #
  # The visitor should return one of the \c CXChildVisitResult values
  # to direct clang_visitCursorChildren().
  #
  # @method `callback_cursor_visitor`(enum cx_child_visit_result, cursor, parent)
  # @param [Cursor] enum cx_child_visit_result
  # @param [Cursor] cursor
  # @param [FFI::Pointer(*Void)] parent
  # @return [Symbol from `enum_child_visit_result`]
  # @scope class
  #
  callback :cursor_visitor, [Cursor.by_value, Cursor.by_value, :pointer], :child_visit_result

  # Visitor invoked for each cursor found by a traversal.
  #
  # This visitor block will be invoked for each cursor found by
  # clang_visitChildrenWithBlock(). Its first argument is the cursor being
  # visited, its second argument is the parent visitor for that cursor.
  #
  # The visitor should return one of the \c CXChildVisitResult values
  # to direct clang_visitChildrenWithBlock().
  #
  # @method `callback_cursor_visitor_block`(enum cx_child_visit_result, cursor)
  # @param [Cursor] enum cx_child_visit_result
  # @param [Cursor] cursor
  # @return [Symbol from `enum_child_visit_result`]
  # @scope class
  #
  callback :cursor_visitor_block, [Cursor.by_value, Cursor.by_value], :child_visit_result

  # Visitor invoked for each file in a translation unit
  #        (used with clang_getInclusions()).
  #
  # This visitor function will be invoked by clang_getInclusions() for each
  # file included (either at the top-level or by \#include directives) within
  # a translation unit.  The first argument is the file being included, and
  # the second and third arguments provide the inclusion stack.  The
  # array is sorted in order of immediate inclusion.  For example,
  # the first element refers to the location that included 'included_file'.
  #
  # @method `callback_inclusion_visitor`(included_file, inclusion_stack, include_len, client_data)
  # @param [FFI::Pointer(*Void)] included_file
  # @param [SourceLocation] inclusion_stack
  # @param [Integer] include_len
  # @param [FFI::Pointer(*Void)] client_data
  # @return [nil]
  # @scope class
  #
  callback :inclusion_visitor, [:pointer, SourceLocation.by_ref, :uint, :pointer], :void

  # (Not documented)
  #
  # @method `callback_cursor_and_range_visitor_block`(enum cx_visitor_result, )
  # @param [Cursor] enum cx_visitor_result
  # @param [SourceRange]
  # @return [Symbol from `enum_visitor_result`]
  # @scope class
  #
  callback :cursor_and_range_visitor_block, [Cursor.by_value, SourceRange.by_value], :visitor_result

  # Retrieve the character data associated with the given string.
  #
  # @method get_c_string(string)
  # @param [String] string
  # @return [String]
  # @scope class
  #
  attach_function :get_c_string, :clang_getCString, [String.by_value], :string

  # Free the given string.
  #
  # @method dispose_string(string)
  # @param [String] string
  # @return [nil]
  # @scope class
  #
  attach_function :dispose_string, :clang_disposeString, [String.by_value], :void

  # Provides a shared context for creating translation units.
  #
  # It provides two options:
  #
  # - excludeDeclarationsFromPCH: When non-zero, allows enumeration of "local"
  # declarations (when loading any new translation units). A "local" declaration
  # is one that belongs in the translation unit itself and not in a precompiled
  # header that was used by the translation unit. If zero, all declarations
  # will be enumerated.
  #
  # Here is an example:
  #
  # \code
  #   // excludeDeclsFromPCH = 1, displayDiagnostics=1
  #   Idx = clang_createIndex(1, 1);
  #
  #   // IndexTest.pch was produced with the following command:
  #   // "clang -x c IndexTest.h -emit-ast -o IndexTest.pch"
  #   TU = clang_createTranslationUnit(Idx, "IndexTest.pch");
  #
  #   // This will load all the symbols from 'IndexTest.pch'
  #   clang_visitChildren(clang_getTranslationUnitCursor(TU),
  #                       TranslationUnitVisitor, 0);
  #   clang_disposeTranslationUnit(TU);
  #
  #   // This will load all the symbols from 'IndexTest.c', excluding symbols
  #   // from 'IndexTest.pch'.
  #   char *args() = { "-Xclang", "-include-pch=IndexTest.pch" };
  #   TU = clang_createTranslationUnitFromSourceFile(Idx, "IndexTest.c", 2, args,
  #                                                  0, 0);
  #   clang_visitChildren(clang_getTranslationUnitCursor(TU),
  #                       TranslationUnitVisitor, 0);
  #   clang_disposeTranslationUnit(TU);
  # \endcode
  #
  # This process of creating the 'pch', loading it separately, and using it (via
  # -include-pch) allows 'excludeDeclsFromPCH' to remove redundant callbacks
  # (which gives the indexer the same performance benefit as the compiler).
  #
  # @method create_index(exclude_declarations_from_pch, display_diagnostics)
  # @param [Integer] exclude_declarations_from_pch
  # @param [Integer] display_diagnostics
  # @return [FFI::Pointer(Index)]
  # @scope class
  #
  attach_function :create_index, :clang_createIndex, [:int, :int], :pointer

  # Destroy the given index.
  #
  # The index must not be destroyed until all of the translation units created
  # within that index have been destroyed.
  #
  # @method dispose_index(index)
  # @param [FFI::Pointer(Index)] index
  # @return [nil]
  # @scope class
  #
  attach_function :dispose_index, :clang_disposeIndex, [:pointer], :void

  # Sets general options associated with a CXIndex.
  #
  # For example:
  # \code
  # CXIndex idx = ...;
  # clang_CXIndex_setGlobalOptions(idx,
  #     clang_CXIndex_getGlobalOptions(idx) |
  #     CXGlobalOpt_ThreadBackgroundPriorityForIndexing);
  # \endcode
  #
  # @method cx_index_set_global_options(index, options)
  # @param [FFI::Pointer(Index)] index
  # @param [Integer] options A bitmask of options, a bitwise OR of CXGlobalOpt_XXX flags.
  # @return [nil]
  # @scope class
  #
  attach_function :cx_index_set_global_options, :clang_CXIndex_setGlobalOptions, [:pointer, :uint], :void

  # Gets the general options associated with a CXIndex.
  #
  # @method cx_index_get_global_options(index)
  # @param [FFI::Pointer(Index)] index
  # @return [Integer] A bitmask of options, a bitwise OR of CXGlobalOpt_XXX flags that
  #   are associated with the given CXIndex object.
  # @scope class
  #
  attach_function :cx_index_get_global_options, :clang_CXIndex_getGlobalOptions, [:pointer], :uint

  # Retrieve the complete file and path name of the given file.
  #
  # @method get_file_name(s_file)
  # @param [FFI::Pointer(File)] s_file
  # @return [String]
  # @scope class
  #
  attach_function :get_file_name, :clang_getFileName, [:pointer], String.by_value

  # Retrieve the last modification time of the given file.
  #
  # @method get_file_time(s_file)
  # @param [FFI::Pointer(File)] s_file
  # @return [Integer]
  # @scope class
  #
  attach_function :get_file_time, :clang_getFileTime, [:pointer], :long

  # Retrieve the unique ID for the given \c file.
  #
  # @method get_file_unique_id(file, out_id)
  # @param [FFI::Pointer(File)] file the file to get the ID for.
  # @param [FileUniqueID] out_id stores the returned CXFileUniqueID.
  # @return [Integer] If there was a failure getting the unique ID, returns non-zero,
  #   otherwise returns 0.
  # @scope class
  #
  attach_function :get_file_unique_id, :clang_getFileUniqueID, [:pointer, FileUniqueID.by_ref], :int

  # Determine whether the given header is guarded against
  # multiple inclusions, either with the conventional
  # \#ifndef/\#define/\#endif macro guards or with \#pragma once.
  #
  # @method is_file_multiple_include_guarded(tu, file)
  # @param [TranslationUnit] tu
  # @param [FFI::Pointer(File)] file
  # @return [Integer]
  # @scope class
  #
  attach_function :is_file_multiple_include_guarded, :clang_isFileMultipleIncludeGuarded, [TranslationUnit.by_ref, :pointer], :uint

  # Retrieve a file handle within the given translation unit.
  #
  # @method get_file(tu, file_name)
  # @param [TranslationUnit] tu the translation unit
  # @param [String] file_name the name of the file.
  # @return [FFI::Pointer(File)] the file handle for the named file in the translation unit \p tu,
  #   or a NULL file handle if the file was not a part of this translation unit.
  # @scope class
  #
  attach_function :get_file, :clang_getFile, [TranslationUnit.by_ref, :string], :pointer

  # Retrieve a NULL (invalid) source location.
  #
  # @method get_null_location()
  # @return [SourceLocation]
  # @scope class
  #
  attach_function :get_null_location, :clang_getNullLocation, [], SourceLocation.by_value

  # Determine whether two source locations, which must refer into
  # the same translation unit, refer to exactly the same point in the source
  # code.
  #
  # @method equal_locations(loc1, loc2)
  # @param [SourceLocation] loc1
  # @param [SourceLocation] loc2
  # @return [Integer] non-zero if the source locations refer to the same location, zero
  #   if they refer to different locations.
  # @scope class
  #
  attach_function :equal_locations, :clang_equalLocations, [SourceLocation.by_value, SourceLocation.by_value], :uint

  # Retrieves the source location associated with a given file/line/column
  # in a particular translation unit.
  #
  # @method get_location(tu, file, line, column)
  # @param [TranslationUnit] tu
  # @param [FFI::Pointer(File)] file
  # @param [Integer] line
  # @param [Integer] column
  # @return [SourceLocation]
  # @scope class
  #
  attach_function :get_location, :clang_getLocation, [TranslationUnit.by_ref, :pointer, :uint, :uint], SourceLocation.by_value

  # Retrieves the source location associated with a given character offset
  # in a particular translation unit.
  #
  # @method get_location_for_offset(tu, file, offset)
  # @param [TranslationUnit] tu
  # @param [FFI::Pointer(File)] file
  # @param [Integer] offset
  # @return [SourceLocation]
  # @scope class
  #
  attach_function :get_location_for_offset, :clang_getLocationForOffset, [TranslationUnit.by_ref, :pointer, :uint], SourceLocation.by_value

  # Returns non-zero if the given source location is in a system header.
  #
  # @method location_is_in_system_header(location)
  # @param [SourceLocation] location
  # @return [Integer]
  # @scope class
  #
  attach_function :location_is_in_system_header, :clang_Location_isInSystemHeader, [SourceLocation.by_value], :int

  # Returns non-zero if the given source location is in the main file of
  # the corresponding translation unit.
  #
  # @method location_is_from_main_file(location)
  # @param [SourceLocation] location
  # @return [Integer]
  # @scope class
  #
  attach_function :location_is_from_main_file, :clang_Location_isFromMainFile, [SourceLocation.by_value], :int

  # Retrieve a NULL (invalid) source range.
  #
  # @method get_null_range()
  # @return [SourceRange]
  # @scope class
  #
  attach_function :get_null_range, :clang_getNullRange, [], SourceRange.by_value

  # Retrieve a source range given the beginning and ending source
  # locations.
  #
  # @method get_range(begin_, end_)
  # @param [SourceLocation] begin_
  # @param [SourceLocation] end_
  # @return [SourceRange]
  # @scope class
  #
  attach_function :get_range, :clang_getRange, [SourceLocation.by_value, SourceLocation.by_value], SourceRange.by_value

  # Determine whether two ranges are equivalent.
  #
  # @method equal_ranges(range1, range2)
  # @param [SourceRange] range1
  # @param [SourceRange] range2
  # @return [Integer] non-zero if the ranges are the same, zero if they differ.
  # @scope class
  #
  attach_function :equal_ranges, :clang_equalRanges, [SourceRange.by_value, SourceRange.by_value], :uint

  # Returns non-zero if \p range is null.
  #
  # @method range_is_null(range)
  # @param [SourceRange] range
  # @return [Integer]
  # @scope class
  #
  attach_function :range_is_null, :clang_Range_isNull, [SourceRange.by_value], :int

  # Retrieve the file, line, column, and offset represented by
  # the given source location.
  #
  # If the location refers into a macro expansion, retrieves the
  # location of the macro expansion.
  #
  # @method get_expansion_location(location, file, line, column, offset)
  # @param [SourceLocation] location the location within a source file that will be decomposed
  #   into its parts.
  # @param [FFI::Pointer(*File)] file (out) if non-NULL, will be set to the file to which the given
  #   source location points.
  # @param [FFI::Pointer(*UInt)] line (out) if non-NULL, will be set to the line to which the given
  #   source location points.
  # @param [FFI::Pointer(*UInt)] column (out) if non-NULL, will be set to the column to which the given
  #   source location points.
  # @param [FFI::Pointer(*UInt)] offset (out) if non-NULL, will be set to the offset into the
  #   buffer to which the given source location points.
  # @return [nil]
  # @scope class
  #
  attach_function :get_expansion_location, :clang_getExpansionLocation, [SourceLocation.by_value, :pointer, :pointer, :pointer, :pointer], :void

  # Retrieve the file, line, column, and offset represented by
  # the given source location, as specified in a # line directive.
  #
  # Example: given the following source code in a file somefile.c
  #
  # \code
  # #123 "dummy.c" 1
  #
  # static int func(void)
  # {
  #     return 0;
  # }
  # \endcode
  #
  # the location information returned by this function would be
  #
  # File: dummy.c Line: 124 Column: 12
  #
  # whereas clang_getExpansionLocation would have returned
  #
  # File: somefile.c Line: 3 Column: 12
  #
  # @method get_presumed_location(location, filename, line, column)
  # @param [SourceLocation] location the location within a source file that will be decomposed
  #   into its parts.
  # @param [String] filename (out) if non-NULL, will be set to the filename of the
  #   source location. Note that filenames returned will be for "virtual" files,
  #   which don't necessarily exist on the machine running clang - e.g. when
  #   parsing preprocessed output obtained from a different environment. If
  #   a non-NULL value is passed in, remember to dispose of the returned value
  #   using \c clang_disposeString() once you've finished with it. For an invalid
  #   source location, an empty string is returned.
  # @param [FFI::Pointer(*UInt)] line (out) if non-NULL, will be set to the line number of the
  #   source location. For an invalid source location, zero is returned.
  # @param [FFI::Pointer(*UInt)] column (out) if non-NULL, will be set to the column number of the
  #   source location. For an invalid source location, zero is returned.
  # @return [nil]
  # @scope class
  #
  attach_function :get_presumed_location, :clang_getPresumedLocation, [SourceLocation.by_value, String.by_ref, :pointer, :pointer], :void

  # Legacy API to retrieve the file, line, column, and offset represented
  # by the given source location.
  #
  # This interface has been replaced by the newer interface
  # #clang_getExpansionLocation(). See that interface's documentation for
  # details.
  #
  # @method get_instantiation_location(location, file, line, column, offset)
  # @param [SourceLocation] location
  # @param [FFI::Pointer(*File)] file
  # @param [FFI::Pointer(*UInt)] line
  # @param [FFI::Pointer(*UInt)] column
  # @param [FFI::Pointer(*UInt)] offset
  # @return [nil]
  # @scope class
  #
  attach_function :get_instantiation_location, :clang_getInstantiationLocation, [SourceLocation.by_value, :pointer, :pointer, :pointer, :pointer], :void

  # Retrieve the file, line, column, and offset represented by
  # the given source location.
  #
  # If the location refers into a macro instantiation, return where the
  # location was originally spelled in the source file.
  #
  # @method get_spelling_location(location, file, line, column, offset)
  # @param [SourceLocation] location the location within a source file that will be decomposed
  #   into its parts.
  # @param [FFI::Pointer(*File)] file (out) if non-NULL, will be set to the file to which the given
  #   source location points.
  # @param [FFI::Pointer(*UInt)] line (out) if non-NULL, will be set to the line to which the given
  #   source location points.
  # @param [FFI::Pointer(*UInt)] column (out) if non-NULL, will be set to the column to which the given
  #   source location points.
  # @param [FFI::Pointer(*UInt)] offset (out) if non-NULL, will be set to the offset into the
  #   buffer to which the given source location points.
  # @return [nil]
  # @scope class
  #
  attach_function :get_spelling_location, :clang_getSpellingLocation, [SourceLocation.by_value, :pointer, :pointer, :pointer, :pointer], :void

  # Retrieve the file, line, column, and offset represented by
  # the given source location.
  #
  # If the location refers into a macro expansion, return where the macro was
  # expanded or where the macro argument was written, if the location points at
  # a macro argument.
  #
  # @method get_file_location(location, file, line, column, offset)
  # @param [SourceLocation] location the location within a source file that will be decomposed
  #   into its parts.
  # @param [FFI::Pointer(*File)] file (out) if non-NULL, will be set to the file to which the given
  #   source location points.
  # @param [FFI::Pointer(*UInt)] line (out) if non-NULL, will be set to the line to which the given
  #   source location points.
  # @param [FFI::Pointer(*UInt)] column (out) if non-NULL, will be set to the column to which the given
  #   source location points.
  # @param [FFI::Pointer(*UInt)] offset (out) if non-NULL, will be set to the offset into the
  #   buffer to which the given source location points.
  # @return [nil]
  # @scope class
  #
  attach_function :get_file_location, :clang_getFileLocation, [SourceLocation.by_value, :pointer, :pointer, :pointer, :pointer], :void

  # Retrieve a source location representing the first character within a
  # source range.
  #
  # @method get_range_start(range)
  # @param [SourceRange] range
  # @return [SourceLocation]
  # @scope class
  #
  attach_function :get_range_start, :clang_getRangeStart, [SourceRange.by_value], SourceLocation.by_value

  # Retrieve a source location representing the last character within a
  # source range.
  #
  # @method get_range_end(range)
  # @param [SourceRange] range
  # @return [SourceLocation]
  # @scope class
  #
  attach_function :get_range_end, :clang_getRangeEnd, [SourceRange.by_value], SourceLocation.by_value

  # Determine the number of diagnostics in a CXDiagnosticSet.
  #
  # @method get_num_diagnostics_in_set(diags)
  # @param [FFI::Pointer(DiagnosticSet)] diags
  # @return [Integer]
  # @scope class
  #
  attach_function :get_num_diagnostics_in_set, :clang_getNumDiagnosticsInSet, [:pointer], :uint

  # Retrieve a diagnostic associated with the given CXDiagnosticSet.
  #
  # @method get_diagnostic_in_set(diags, index)
  # @param [FFI::Pointer(DiagnosticSet)] diags the CXDiagnosticSet to query.
  # @param [Integer] index the zero-based diagnostic number to retrieve.
  # @return [FFI::Pointer(Diagnostic)] the requested diagnostic. This diagnostic must be freed
  #   via a call to \c clang_disposeDiagnostic().
  # @scope class
  #
  attach_function :get_diagnostic_in_set, :clang_getDiagnosticInSet, [:pointer, :uint], :pointer

  # Deserialize a set of diagnostics from a Clang diagnostics bitcode
  # file.
  #
  # @method load_diagnostics(file, error, error_string)
  # @param [String] file The name of the file to deserialize.
  # @param [FFI::Pointer(*LoadDiagError)] error A pointer to a enum value recording if there was a problem
  #          deserializing the diagnostics.
  # @param [String] error_string A pointer to a CXString for recording the error string
  #          if the file was not successfully loaded.
  # @return [FFI::Pointer(DiagnosticSet)] A loaded CXDiagnosticSet if successful, and NULL otherwise.  These
  #   diagnostics should be released using clang_disposeDiagnosticSet().
  # @scope class
  #
  attach_function :load_diagnostics, :clang_loadDiagnostics, [:string, :pointer, String.by_ref], :pointer

  # Release a CXDiagnosticSet and all of its contained diagnostics.
  #
  # @method dispose_diagnostic_set(diags)
  # @param [FFI::Pointer(DiagnosticSet)] diags
  # @return [nil]
  # @scope class
  #
  attach_function :dispose_diagnostic_set, :clang_disposeDiagnosticSet, [:pointer], :void

  # Retrieve the child diagnostics of a CXDiagnostic.
  #
  # This CXDiagnosticSet does not need to be released by
  # clang_disposeDiagnosticSet.
  #
  # @method get_child_diagnostics(d)
  # @param [FFI::Pointer(Diagnostic)] d
  # @return [FFI::Pointer(DiagnosticSet)]
  # @scope class
  #
  attach_function :get_child_diagnostics, :clang_getChildDiagnostics, [:pointer], :pointer

  # Determine the number of diagnostics produced for the given
  # translation unit.
  #
  # @method get_num_diagnostics(unit)
  # @param [TranslationUnit] unit
  # @return [Integer]
  # @scope class
  #
  attach_function :get_num_diagnostics, :clang_getNumDiagnostics, [TranslationUnit.by_ref], :uint

  # Retrieve a diagnostic associated with the given translation unit.
  #
  # @method get_diagnostic(unit, index)
  # @param [TranslationUnit] unit the translation unit to query.
  # @param [Integer] index the zero-based diagnostic number to retrieve.
  # @return [FFI::Pointer(Diagnostic)] the requested diagnostic. This diagnostic must be freed
  #   via a call to \c clang_disposeDiagnostic().
  # @scope class
  #
  attach_function :get_diagnostic, :clang_getDiagnostic, [TranslationUnit.by_ref, :uint], :pointer

  # Retrieve the complete set of diagnostics associated with a
  #        translation unit.
  #
  # @method get_diagnostic_set_from_tu(unit)
  # @param [TranslationUnit] unit the translation unit to query.
  # @return [FFI::Pointer(DiagnosticSet)]
  # @scope class
  #
  attach_function :get_diagnostic_set_from_tu, :clang_getDiagnosticSetFromTU, [TranslationUnit.by_ref], :pointer

  # Destroy a diagnostic.
  #
  # @method dispose_diagnostic(diagnostic)
  # @param [FFI::Pointer(Diagnostic)] diagnostic
  # @return [nil]
  # @scope class
  #
  attach_function :dispose_diagnostic, :clang_disposeDiagnostic, [:pointer], :void

  # Format the given diagnostic in a manner that is suitable for display.
  #
  # This routine will format the given diagnostic to a string, rendering
  # the diagnostic according to the various options given. The
  # \c clang_defaultDiagnosticDisplayOptions() function returns the set of
  # options that most closely mimics the behavior of the clang compiler.
  #
  # @method format_diagnostic(diagnostic, options)
  # @param [FFI::Pointer(Diagnostic)] diagnostic The diagnostic to print.
  # @param [Integer] options A set of options that control the diagnostic display,
  #   created by combining \c CXDiagnosticDisplayOptions values.
  # @return [String] A new string containing for formatted diagnostic.
  # @scope class
  #
  attach_function :format_diagnostic, :clang_formatDiagnostic, [:pointer, :uint], String.by_value

  # Retrieve the set of display options most similar to the
  # default behavior of the clang compiler.
  #
  # @method default_diagnostic_display_options()
  # @return [Integer] A set of display options suitable for use with \c
  #   clang_formatDiagnostic().
  # @scope class
  #
  attach_function :default_diagnostic_display_options, :clang_defaultDiagnosticDisplayOptions, [], :uint

  # Determine the severity of the given diagnostic.
  #
  # @method get_diagnostic_severity(diagnostic)
  # @param [FFI::Pointer(Diagnostic)] diagnostic
  # @return [Symbol from `enum_diagnostic_severity`]
  # @scope class
  #
  attach_function :get_diagnostic_severity, :clang_getDiagnosticSeverity, [:pointer], :diagnostic_severity

  # Retrieve the source location of the given diagnostic.
  #
  # This location is where Clang would print the caret ('^') when
  # displaying the diagnostic on the command line.
  #
  # @method get_diagnostic_location(diagnostic)
  # @param [FFI::Pointer(Diagnostic)] diagnostic
  # @return [SourceLocation]
  # @scope class
  #
  attach_function :get_diagnostic_location, :clang_getDiagnosticLocation, [:pointer], SourceLocation.by_value

  # Retrieve the text of the given diagnostic.
  #
  # @method get_diagnostic_spelling(diagnostic)
  # @param [FFI::Pointer(Diagnostic)] diagnostic
  # @return [String]
  # @scope class
  #
  attach_function :get_diagnostic_spelling, :clang_getDiagnosticSpelling, [:pointer], String.by_value

  # Retrieve the name of the command-line option that enabled this
  # diagnostic.
  #
  # @method get_diagnostic_option(diag, disable)
  # @param [FFI::Pointer(Diagnostic)] diag The diagnostic to be queried.
  # @param [String] disable If non-NULL, will be set to the option that disables this
  #   diagnostic (if any).
  # @return [String] A string that contains the command-line option used to enable this
  #   warning, such as "-Wconversion" or "-pedantic".
  # @scope class
  #
  attach_function :get_diagnostic_option, :clang_getDiagnosticOption, [:pointer, String.by_ref], String.by_value

  # Retrieve the category number for this diagnostic.
  #
  # Diagnostics can be categorized into groups along with other, related
  # diagnostics (e.g., diagnostics under the same warning flag). This routine
  # retrieves the category number for the given diagnostic.
  #
  # @method get_diagnostic_category(diagnostic)
  # @param [FFI::Pointer(Diagnostic)] diagnostic
  # @return [Integer] The number of the category that contains this diagnostic, or zero
  #   if this diagnostic is uncategorized.
  # @scope class
  #
  attach_function :get_diagnostic_category, :clang_getDiagnosticCategory, [:pointer], :uint

  # Retrieve the name of a particular diagnostic category.  This
  #  is now deprecated.  Use clang_getDiagnosticCategoryText()
  #  instead.
  #
  # @method get_diagnostic_category_name(category)
  # @param [Integer] category A diagnostic category number, as returned by
  #   \c clang_getDiagnosticCategory().
  # @return [String] The name of the given diagnostic category.
  # @scope class
  #
  attach_function :get_diagnostic_category_name, :clang_getDiagnosticCategoryName, [:uint], String.by_value

  # Retrieve the diagnostic category text for a given diagnostic.
  #
  # @method get_diagnostic_category_text(diagnostic)
  # @param [FFI::Pointer(Diagnostic)] diagnostic
  # @return [String] The text of the given diagnostic category.
  # @scope class
  #
  attach_function :get_diagnostic_category_text, :clang_getDiagnosticCategoryText, [:pointer], String.by_value

  # Determine the number of source ranges associated with the given
  # diagnostic.
  #
  # @method get_diagnostic_num_ranges(diagnostic)
  # @param [FFI::Pointer(Diagnostic)] diagnostic
  # @return [Integer]
  # @scope class
  #
  attach_function :get_diagnostic_num_ranges, :clang_getDiagnosticNumRanges, [:pointer], :uint

  # Retrieve a source range associated with the diagnostic.
  #
  # A diagnostic's source ranges highlight important elements in the source
  # code. On the command line, Clang displays source ranges by
  # underlining them with '~' characters.
  #
  # @method get_diagnostic_range(diagnostic, range)
  # @param [FFI::Pointer(Diagnostic)] diagnostic the diagnostic whose range is being extracted.
  # @param [Integer] range the zero-based index specifying which range to
  # @return [SourceRange] the requested source range.
  # @scope class
  #
  attach_function :get_diagnostic_range, :clang_getDiagnosticRange, [:pointer, :uint], SourceRange.by_value

  # Determine the number of fix-it hints associated with the
  # given diagnostic.
  #
  # @method get_diagnostic_num_fix_its(diagnostic)
  # @param [FFI::Pointer(Diagnostic)] diagnostic
  # @return [Integer]
  # @scope class
  #
  attach_function :get_diagnostic_num_fix_its, :clang_getDiagnosticNumFixIts, [:pointer], :uint

  # Retrieve the replacement information for a given fix-it.
  #
  # Fix-its are described in terms of a source range whose contents
  # should be replaced by a string. This approach generalizes over
  # three kinds of operations: removal of source code (the range covers
  # the code to be removed and the replacement string is empty),
  # replacement of source code (the range covers the code to be
  # replaced and the replacement string provides the new code), and
  # insertion (both the start and end of the range point at the
  # insertion location, and the replacement string provides the text to
  # insert).
  #
  # @method get_diagnostic_fix_it(diagnostic, fix_it, replacement_range)
  # @param [FFI::Pointer(Diagnostic)] diagnostic The diagnostic whose fix-its are being queried.
  # @param [Integer] fix_it The zero-based index of the fix-it.
  # @param [SourceRange] replacement_range The source range whose contents will be
  #   replaced with the returned replacement string. Note that source
  #   ranges are half-open ranges (a, b), so the source code should be
  #   replaced from a and up to (but not including) b.
  # @return [String] A string containing text that should be replace the source
  #   code indicated by the \c ReplacementRange.
  # @scope class
  #
  attach_function :get_diagnostic_fix_it, :clang_getDiagnosticFixIt, [:pointer, :uint, SourceRange.by_ref], String.by_value

  # Get the original translation unit source file name.
  #
  # @method get_translation_unit_spelling(ct_unit)
  # @param [TranslationUnit] ct_unit
  # @return [String]
  # @scope class
  #
  attach_function :get_translation_unit_spelling, :clang_getTranslationUnitSpelling, [TranslationUnit.by_ref], String.by_value

  # Return the CXTranslationUnit for a given source file and the provided
  # command line arguments one would pass to the compiler.
  #
  # Note: The 'source_filename' argument is optional.  If the caller provides a
  # NULL pointer, the name of the source file is expected to reside in the
  # specified command line arguments.
  #
  # Note: When encountered in 'clang_command_line_args', the following options
  # are ignored:
  #
  #   '-c'
  #   '-emit-ast'
  #   '-fsyntax-only'
  #   '-o \<output file>'  (both '-o' and '\<output file>' are ignored)
  #
  # @method create_translation_unit_from_source_file(c_idx, source_filename, num_clang_command_line_args, command_line_args, num_unsaved_files, unsaved_files)
  # @param [FFI::Pointer(Index)] c_idx The index object with which the translation unit will be
  #   associated.
  # @param [String] source_filename The name of the source file to load, or NULL if the
  #   source file is included in \p clang_command_line_args.
  # @param [Integer] num_clang_command_line_args The number of command-line arguments in
  #   \p clang_command_line_args.
  # @param [FFI::Pointer(**CharS)] command_line_args The command-line arguments that would be
  #   passed to the \c clang executable if it were being invoked out-of-process.
  #   These command-line options will be parsed and will affect how the translation
  #   unit is parsed. Note that the following options are ignored: '-c',
  #   '-emit-ast', '-fsyntax-only' (which is the default), and '-o \<output file>'.
  # @param [Integer] num_unsaved_files the number of unsaved file entries in \p
  #   unsaved_files.
  # @param [UnsavedFile] unsaved_files the files that have not yet been saved to disk
  #   but may be required for code completion, including the contents of
  #   those files.  The contents and name of these files (as specified by
  #   CXUnsavedFile) are copied when necessary, so the client only needs to
  #   guarantee their validity until the call to this function returns.
  # @return [TranslationUnit]
  # @scope class
  #
  attach_function :create_translation_unit_from_source_file, :clang_createTranslationUnitFromSourceFile, [:pointer, :string, :int, :pointer, :uint, UnsavedFile.by_ref], TranslationUnit.by_ref

  # Create a translation unit from an AST file (-emit-ast).
  #
  # @method create_translation_unit(index, ast_filename)
  # @param [FFI::Pointer(Index)] index
  # @param [String] ast_filename
  # @return [TranslationUnit]
  # @scope class
  #
  attach_function :create_translation_unit, :clang_createTranslationUnit, [:pointer, :string], TranslationUnit.by_ref

  # Returns the set of flags that is suitable for parsing a translation
  # unit that is being edited.
  #
  # The set of flags returned provide options for \c clang_parseTranslationUnit()
  # to indicate that the translation unit is likely to be reparsed many times,
  # either explicitly (via \c clang_reparseTranslationUnit()) or implicitly
  # (e.g., by code completion (\c clang_codeCompletionAt())). The returned flag
  # set contains an unspecified set of optimizations (e.g., the precompiled
  # preamble) geared toward improving the performance of these routines. The
  # set of optimizations enabled may change from one version to the next.
  #
  # @method default_editing_translation_unit_options()
  # @return [Integer]
  # @scope class
  #
  attach_function :default_editing_translation_unit_options, :clang_defaultEditingTranslationUnitOptions, [], :uint

  # Parse the given source file and the translation unit corresponding
  # to that file.
  #
  # This routine is the main entry point for the Clang C API, providing the
  # ability to parse a source file into a translation unit that can then be
  # queried by other functions in the API. This routine accepts a set of
  # command-line arguments so that the compilation can be configured in the same
  # way that the compiler is configured on the command line.
  #
  # @method parse_translation_unit(c_idx, source_filename, command_line_args, num_command_line_args, unsaved_files, num_unsaved_files, options)
  # @param [FFI::Pointer(Index)] c_idx The index object with which the translation unit will be
  #   associated.
  # @param [String] source_filename The name of the source file to load, or NULL if the
  #   source file is included in \p command_line_args.
  # @param [FFI::Pointer(**CharS)] command_line_args The command-line arguments that would be
  #   passed to the \c clang executable if it were being invoked out-of-process.
  #   These command-line options will be parsed and will affect how the translation
  #   unit is parsed. Note that the following options are ignored: '-c',
  #   '-emit-ast', '-fsyntax-only' (which is the default), and '-o \<output file>'.
  # @param [Integer] num_command_line_args The number of command-line arguments in
  #   \p command_line_args.
  # @param [UnsavedFile] unsaved_files the files that have not yet been saved to disk
  #   but may be required for parsing, including the contents of
  #   those files.  The contents and name of these files (as specified by
  #   CXUnsavedFile) are copied when necessary, so the client only needs to
  #   guarantee their validity until the call to this function returns.
  # @param [Integer] num_unsaved_files the number of unsaved file entries in \p
  #   unsaved_files.
  # @param [Integer] options A bitmask of options that affects how the translation unit
  #   is managed but not its compilation. This should be a bitwise OR of the
  #   CXTranslationUnit_XXX flags.
  # @return [TranslationUnit] A new translation unit describing the parsed code and containing
  #   any diagnostics produced by the compiler. If there is a failure from which
  #   the compiler cannot recover, returns NULL.
  # @scope class
  #
  attach_function :parse_translation_unit, :clang_parseTranslationUnit, [:pointer, :string, :pointer, :int, UnsavedFile.by_ref, :uint, :uint], TranslationUnit.by_ref

  # Returns the set of flags that is suitable for saving a translation
  # unit.
  #
  # The set of flags returned provide options for
  # \c clang_saveTranslationUnit() by default. The returned flag
  # set contains an unspecified set of options that save translation units with
  # the most commonly-requested data.
  #
  # @method default_save_options(tu)
  # @param [TranslationUnit] tu
  # @return [Integer]
  # @scope class
  #
  attach_function :default_save_options, :clang_defaultSaveOptions, [TranslationUnit.by_ref], :uint

  # Saves a translation unit into a serialized representation of
  # that translation unit on disk.
  #
  # Any translation unit that was parsed without error can be saved
  # into a file. The translation unit can then be deserialized into a
  # new \c CXTranslationUnit with \c clang_createTranslationUnit() or,
  # if it is an incomplete translation unit that corresponds to a
  # header, used as a precompiled header when parsing other translation
  # units.
  #
  # @method save_translation_unit(tu, file_name, options)
  # @param [TranslationUnit] tu The translation unit to save.
  # @param [String] file_name The file to which the translation unit will be saved.
  # @param [Integer] options A bitmask of options that affects how the translation unit
  #   is saved. This should be a bitwise OR of the
  #   CXSaveTranslationUnit_XXX flags.
  # @return [Integer] A value that will match one of the enumerators of the CXSaveError
  #   enumeration. Zero (CXSaveError_None) indicates that the translation unit was
  #   saved successfully, while a non-zero value indicates that a problem occurred.
  # @scope class
  #
  attach_function :save_translation_unit, :clang_saveTranslationUnit, [TranslationUnit.by_ref, :string, :uint], :int

  # Destroy the specified CXTranslationUnit object.
  #
  # @method dispose_translation_unit(translation_unit)
  # @param [TranslationUnit] translation_unit
  # @return [nil]
  # @scope class
  #
  attach_function :dispose_translation_unit, :clang_disposeTranslationUnit, [TranslationUnit.by_ref], :void

  # Returns the set of flags that is suitable for reparsing a translation
  # unit.
  #
  # The set of flags returned provide options for
  # \c clang_reparseTranslationUnit() by default. The returned flag
  # set contains an unspecified set of optimizations geared toward common uses
  # of reparsing. The set of optimizations enabled may change from one version
  # to the next.
  #
  # @method default_reparse_options(tu)
  # @param [TranslationUnit] tu
  # @return [Integer]
  # @scope class
  #
  attach_function :default_reparse_options, :clang_defaultReparseOptions, [TranslationUnit.by_ref], :uint

  # Reparse the source files that produced this translation unit.
  #
  # This routine can be used to re-parse the source files that originally
  # created the given translation unit, for example because those source files
  # have changed (either on disk or as passed via \p unsaved_files). The
  # source code will be reparsed with the same command-line options as it
  # was originally parsed.
  #
  # Reparsing a translation unit invalidates all cursors and source locations
  # that refer into that translation unit. This makes reparsing a translation
  # unit semantically equivalent to destroying the translation unit and then
  # creating a new translation unit with the same command-line arguments.
  # However, it may be more efficient to reparse a translation
  # unit using this routine.
  #
  # @method reparse_translation_unit(tu, num_unsaved_files, unsaved_files, options)
  # @param [TranslationUnit] tu The translation unit whose contents will be re-parsed. The
  #   translation unit must originally have been built with
  #   \c clang_createTranslationUnitFromSourceFile().
  # @param [Integer] num_unsaved_files The number of unsaved file entries in \p
  #   unsaved_files.
  # @param [UnsavedFile] unsaved_files The files that have not yet been saved to disk
  #   but may be required for parsing, including the contents of
  #   those files.  The contents and name of these files (as specified by
  #   CXUnsavedFile) are copied when necessary, so the client only needs to
  #   guarantee their validity until the call to this function returns.
  # @param [Integer] options A bitset of options composed of the flags in CXReparse_Flags.
  #   The function \c clang_defaultReparseOptions() produces a default set of
  #   options recommended for most uses, based on the translation unit.
  # @return [Integer] 0 if the sources could be reparsed. A non-zero value will be
  #   returned if reparsing was impossible, such that the translation unit is
  #   invalid. In such cases, the only valid call for \p TU is
  #   \c clang_disposeTranslationUnit(TU).
  # @scope class
  #
  attach_function :reparse_translation_unit, :clang_reparseTranslationUnit, [TranslationUnit.by_ref, :uint, UnsavedFile.by_ref, :uint], :int

  # Returns the human-readable null-terminated C string that represents
  #  the name of the memory category.  This string should never be freed.
  #
  # @method get_tu_resource_usage_name(kind)
  # @param [Symbol from `enum_tu_resource_usage_kind`] kind
  # @return [String]
  # @scope class
  #
  attach_function :get_tu_resource_usage_name, :clang_getTUResourceUsageName, [:tu_resource_usage_kind], :string

  # Return the memory usage of a translation unit.  This object
  #  should be released with clang_disposeCXTUResourceUsage().
  #
  # @method get_cxtu_resource_usage(tu)
  # @param [TranslationUnit] tu
  # @return [TUResourceUsage]
  # @scope class
  #
  attach_function :get_cxtu_resource_usage, :clang_getCXTUResourceUsage, [TranslationUnit.by_ref], TUResourceUsage.by_value

  # (Not documented)
  #
  # @method dispose_cxtu_resource_usage(usage)
  # @param [TUResourceUsage] usage
  # @return [nil]
  # @scope class
  #
  attach_function :dispose_cxtu_resource_usage, :clang_disposeCXTUResourceUsage, [TUResourceUsage.by_value], :void

  # Retrieve the NULL cursor, which represents no entity.
  #
  # @method get_null_cursor()
  # @return [Cursor]
  # @scope class
  #
  attach_function :get_null_cursor, :clang_getNullCursor, [], Cursor.by_value

  # Retrieve the cursor that represents the given translation unit.
  #
  # The translation unit cursor can be used to start traversing the
  # various declarations within the given translation unit.
  #
  # @method get_translation_unit_cursor(translation_unit)
  # @param [TranslationUnit] translation_unit
  # @return [Cursor]
  # @scope class
  #
  attach_function :get_translation_unit_cursor, :clang_getTranslationUnitCursor, [TranslationUnit.by_ref], Cursor.by_value

  # Determine whether two cursors are equivalent.
  #
  # @method equal_cursors(cursor, cursor)
  # @param [Cursor] cursor
  # @param [Cursor] cursor
  # @return [Integer]
  # @scope class
  #
  attach_function :equal_cursors, :clang_equalCursors, [Cursor.by_value, Cursor.by_value], :uint

  # Returns non-zero if \p cursor is null.
  #
  # @method cursor_is_null(cursor)
  # @param [Cursor] cursor
  # @return [Integer]
  # @scope class
  #
  attach_function :cursor_is_null, :clang_Cursor_isNull, [Cursor.by_value], :int

  # Compute a hash value for the given cursor.
  #
  # @method hash_cursor(cursor)
  # @param [Cursor] cursor
  # @return [Integer]
  # @scope class
  #
  attach_function :hash_cursor, :clang_hashCursor, [Cursor.by_value], :uint

  # Retrieve the kind of the given cursor.
  #
  # @method get_cursor_kind(cursor)
  # @param [Cursor] cursor
  # @return [Symbol from `enum_cursor_kind`]
  # @scope class
  #
  attach_function :get_cursor_kind, :clang_getCursorKind, [Cursor.by_value], :cursor_kind

  # Determine whether the given cursor kind represents a declaration.
  #
  # @method is_declaration(cursor_kind)
  # @param [Symbol from `enum_cursor_kind`] cursor_kind
  # @return [Integer]
  # @scope class
  #
  attach_function :is_declaration, :clang_isDeclaration, [:cursor_kind], :uint

  # Determine whether the given cursor kind represents a simple
  # reference.
  #
  # Note that other kinds of cursors (such as expressions) can also refer to
  # other cursors. Use clang_getCursorReferenced() to determine whether a
  # particular cursor refers to another entity.
  #
  # @method is_reference(cursor_kind)
  # @param [Symbol from `enum_cursor_kind`] cursor_kind
  # @return [Integer]
  # @scope class
  #
  attach_function :is_reference, :clang_isReference, [:cursor_kind], :uint

  # Determine whether the given cursor kind represents an expression.
  #
  # @method is_expression(cursor_kind)
  # @param [Symbol from `enum_cursor_kind`] cursor_kind
  # @return [Integer]
  # @scope class
  #
  attach_function :is_expression, :clang_isExpression, [:cursor_kind], :uint

  # Determine whether the given cursor kind represents a statement.
  #
  # @method is_statement(cursor_kind)
  # @param [Symbol from `enum_cursor_kind`] cursor_kind
  # @return [Integer]
  # @scope class
  #
  attach_function :is_statement, :clang_isStatement, [:cursor_kind], :uint

  # Determine whether the given cursor kind represents an attribute.
  #
  # @method is_attribute(cursor_kind)
  # @param [Symbol from `enum_cursor_kind`] cursor_kind
  # @return [Integer]
  # @scope class
  #
  attach_function :is_attribute, :clang_isAttribute, [:cursor_kind], :uint

  # Determine whether the given cursor kind represents an invalid
  # cursor.
  #
  # @method is_invalid(cursor_kind)
  # @param [Symbol from `enum_cursor_kind`] cursor_kind
  # @return [Integer]
  # @scope class
  #
  attach_function :is_invalid, :clang_isInvalid, [:cursor_kind], :uint

  # Determine whether the given cursor kind represents a translation
  # unit.
  #
  # @method is_translation_unit(cursor_kind)
  # @param [Symbol from `enum_cursor_kind`] cursor_kind
  # @return [Integer]
  # @scope class
  #
  attach_function :is_translation_unit, :clang_isTranslationUnit, [:cursor_kind], :uint

  # Determine whether the given cursor represents a preprocessing
  # element, such as a preprocessor directive or macro instantiation.
  #
  # @method is_preprocessing(cursor_kind)
  # @param [Symbol from `enum_cursor_kind`] cursor_kind
  # @return [Integer]
  # @scope class
  #
  attach_function :is_preprocessing, :clang_isPreprocessing, [:cursor_kind], :uint

  # Determine whether the given cursor represents a currently
  #  unexposed piece of the AST (e.g., CXCursor_UnexposedStmt).
  #
  # @method is_unexposed(cursor_kind)
  # @param [Symbol from `enum_cursor_kind`] cursor_kind
  # @return [Integer]
  # @scope class
  #
  attach_function :is_unexposed, :clang_isUnexposed, [:cursor_kind], :uint

  # Determine the linkage of the entity referred to by a given cursor.
  #
  # @method get_cursor_linkage(cursor)
  # @param [Cursor] cursor
  # @return [Symbol from `enum_linkage_kind`]
  # @scope class
  #
  attach_function :get_cursor_linkage, :clang_getCursorLinkage, [Cursor.by_value], :linkage_kind

  # Determine the availability of the entity that this cursor refers to,
  # taking the current target platform into account.
  #
  # @method get_cursor_availability(cursor)
  # @param [Cursor] cursor The cursor to query.
  # @return [Symbol from `enum_availability_kind`] The availability of the cursor.
  # @scope class
  #
  attach_function :get_cursor_availability, :clang_getCursorAvailability, [Cursor.by_value], :availability_kind

  # Determine the availability of the entity that this cursor refers to
  # on any platforms for which availability information is known.
  #
  # @method get_cursor_platform_availability(cursor, always_deprecated, deprecated_message, always_unavailable, unavailable_message, availability, availability_size)
  # @param [Cursor] cursor The cursor to query.
  # @param [FFI::Pointer(*Int)] always_deprecated If non-NULL, will be set to indicate whether the
  #   entity is deprecated on all platforms.
  # @param [String] deprecated_message If non-NULL, will be set to the message text
  #   provided along with the unconditional deprecation of this entity. The client
  #   is responsible for deallocating this string.
  # @param [FFI::Pointer(*Int)] always_unavailable If non-NULL, will be set to indicate whether the
  #   entity is unavailable on all platforms.
  # @param [String] unavailable_message If non-NULL, will be set to the message text
  #   provided along with the unconditional unavailability of this entity. The
  #   client is responsible for deallocating this string.
  # @param [PlatformAvailability] availability If non-NULL, an array of CXPlatformAvailability instances
  #   that will be populated with platform availability information, up to either
  #   the number of platforms for which availability information is available (as
  #   returned by this function) or \c availability_size, whichever is smaller.
  # @param [Integer] availability_size The number of elements available in the
  #   \c availability array.
  # @return [Integer] The number of platforms (N) for which availability information is
  #   available (which is unrelated to \c availability_size).
  #
  #   Note that the client is responsible for calling
  #   \c clang_disposeCXPlatformAvailability to free each of the
  #   platform-availability structures returned. There are
  #   \c min(N, availability_size) such structures.
  # @scope class
  #
  attach_function :get_cursor_platform_availability, :clang_getCursorPlatformAvailability, [Cursor.by_value, :pointer, String.by_ref, :pointer, String.by_ref, PlatformAvailability.by_ref, :int], :int

  # Free the memory associated with a \c CXPlatformAvailability structure.
  #
  # @method dispose_cx_platform_availability(availability)
  # @param [PlatformAvailability] availability
  # @return [nil]
  # @scope class
  #
  attach_function :dispose_cx_platform_availability, :clang_disposeCXPlatformAvailability, [PlatformAvailability.by_ref], :void

  # Determine the "language" of the entity referred to by a given cursor.
  #
  # @method get_cursor_language(cursor)
  # @param [Cursor] cursor
  # @return [Symbol from `enum_language_kind`]
  # @scope class
  #
  attach_function :get_cursor_language, :clang_getCursorLanguage, [Cursor.by_value], :language_kind

  # Returns the translation unit that a cursor originated from.
  #
  # @method cursor_get_translation_unit(cursor)
  # @param [Cursor] cursor
  # @return [TranslationUnit]
  # @scope class
  #
  attach_function :cursor_get_translation_unit, :clang_Cursor_getTranslationUnit, [Cursor.by_value], TranslationUnit.by_ref

  # Creates an empty CXCursorSet.
  #
  # @method create_cx_cursor_set()
  # @return [CursorSet]
  # @scope class
  #
  attach_function :create_cx_cursor_set, :clang_createCXCursorSet, [], CursorSet.by_ref

  # Disposes a CXCursorSet and releases its associated memory.
  #
  # @method dispose_cx_cursor_set(cset)
  # @param [CursorSet] cset
  # @return [nil]
  # @scope class
  #
  attach_function :dispose_cx_cursor_set, :clang_disposeCXCursorSet, [CursorSet.by_ref], :void

  # Queries a CXCursorSet to see if it contains a specific CXCursor.
  #
  # @method cx_cursor_set_contains(cset, cursor)
  # @param [CursorSet] cset
  # @param [Cursor] cursor
  # @return [Integer] non-zero if the set contains the specified cursor.
  # @scope class
  #
  attach_function :cx_cursor_set_contains, :clang_CXCursorSet_contains, [CursorSet.by_ref, Cursor.by_value], :uint

  # Inserts a CXCursor into a CXCursorSet.
  #
  # @method cx_cursor_set_insert(cset, cursor)
  # @param [CursorSet] cset
  # @param [Cursor] cursor
  # @return [Integer] zero if the CXCursor was already in the set, and non-zero otherwise.
  # @scope class
  #
  attach_function :cx_cursor_set_insert, :clang_CXCursorSet_insert, [CursorSet.by_ref, Cursor.by_value], :uint

  # Determine the semantic parent of the given cursor.
  #
  # The semantic parent of a cursor is the cursor that semantically contains
  # the given \p cursor. For many declarations, the lexical and semantic parents
  # are equivalent (the lexical parent is returned by
  # \c clang_getCursorLexicalParent()). They diverge when declarations or
  # definitions are provided out-of-line. For example:
  #
  # \code
  # class C {
  #  void f();
  # };
  #
  # void C::f() { }
  # \endcode
  #
  # In the out-of-line definition of \c C::f, the semantic parent is the
  # the class \c C, of which this function is a member. The lexical parent is
  # the place where the declaration actually occurs in the source code; in this
  # case, the definition occurs in the translation unit. In general, the
  # lexical parent for a given entity can change without affecting the semantics
  # of the program, and the lexical parent of different declarations of the
  # same entity may be different. Changing the semantic parent of a declaration,
  # on the other hand, can have a major impact on semantics, and redeclarations
  # of a particular entity should all have the same semantic context.
  #
  # In the example above, both declarations of \c C::f have \c C as their
  # semantic context, while the lexical context of the first \c C::f is \c C
  # and the lexical context of the second \c C::f is the translation unit.
  #
  # For global declarations, the semantic parent is the translation unit.
  #
  # @method get_cursor_semantic_parent(cursor)
  # @param [Cursor] cursor
  # @return [Cursor]
  # @scope class
  #
  attach_function :get_cursor_semantic_parent, :clang_getCursorSemanticParent, [Cursor.by_value], Cursor.by_value

  # Determine the lexical parent of the given cursor.
  #
  # The lexical parent of a cursor is the cursor in which the given \p cursor
  # was actually written. For many declarations, the lexical and semantic parents
  # are equivalent (the semantic parent is returned by
  # \c clang_getCursorSemanticParent()). They diverge when declarations or
  # definitions are provided out-of-line. For example:
  #
  # \code
  # class C {
  #  void f();
  # };
  #
  # void C::f() { }
  # \endcode
  #
  # In the out-of-line definition of \c C::f, the semantic parent is the
  # the class \c C, of which this function is a member. The lexical parent is
  # the place where the declaration actually occurs in the source code; in this
  # case, the definition occurs in the translation unit. In general, the
  # lexical parent for a given entity can change without affecting the semantics
  # of the program, and the lexical parent of different declarations of the
  # same entity may be different. Changing the semantic parent of a declaration,
  # on the other hand, can have a major impact on semantics, and redeclarations
  # of a particular entity should all have the same semantic context.
  #
  # In the example above, both declarations of \c C::f have \c C as their
  # semantic context, while the lexical context of the first \c C::f is \c C
  # and the lexical context of the second \c C::f is the translation unit.
  #
  # For declarations written in the global scope, the lexical parent is
  # the translation unit.
  #
  # @method get_cursor_lexical_parent(cursor)
  # @param [Cursor] cursor
  # @return [Cursor]
  # @scope class
  #
  attach_function :get_cursor_lexical_parent, :clang_getCursorLexicalParent, [Cursor.by_value], Cursor.by_value

  # Determine the set of methods that are overridden by the given
  # method.
  #
  # In both Objective-C and C++, a method (aka virtual member function,
  # in C++) can override a virtual method in a base class. For
  # Objective-C, a method is said to override any method in the class's
  # base class, its protocols, or its categories' protocols, that has the same
  # selector and is of the same kind (class or instance).
  # If no such method exists, the search continues to the class's superclass,
  # its protocols, and its categories, and so on. A method from an Objective-C
  # implementation is considered to override the same methods as its
  # corresponding method in the interface.
  #
  # For C++, a virtual member function overrides any virtual member
  # function with the same signature that occurs in its base
  # classes. With multiple inheritance, a virtual member function can
  # override several virtual member functions coming from different
  # base classes.
  #
  # In all cases, this function determines the immediate overridden
  # method, rather than all of the overridden methods. For example, if
  # a method is originally declared in a class A, then overridden in B
  # (which in inherits from A) and also in C (which inherited from B),
  # then the only overridden method returned from this function when
  # invoked on C's method will be B's method. The client may then
  # invoke this function again, given the previously-found overridden
  # methods, to map out the complete method-override set.
  #
  # @method get_overridden_cursors(cursor, overridden, num_overridden)
  # @param [Cursor] cursor A cursor representing an Objective-C or C++
  #   method. This routine will compute the set of methods that this
  #   method overrides.
  # @param [FFI::Pointer(**Cursor)] overridden A pointer whose pointee will be replaced with a
  #   pointer to an array of cursors, representing the set of overridden
  #   methods. If there are no overridden methods, the pointee will be
  #   set to NULL. The pointee must be freed via a call to
  #   \c clang_disposeOverriddenCursors().
  # @param [FFI::Pointer(*UInt)] num_overridden A pointer to the number of overridden
  #   functions, will be set to the number of overridden functions in the
  #   array pointed to by \p overridden.
  # @return [nil]
  # @scope class
  #
  attach_function :get_overridden_cursors, :clang_getOverriddenCursors, [Cursor.by_value, :pointer, :pointer], :void

  # Free the set of overridden cursors returned by \c
  # clang_getOverriddenCursors().
  #
  # @method dispose_overridden_cursors(overridden)
  # @param [Cursor] overridden
  # @return [nil]
  # @scope class
  #
  attach_function :dispose_overridden_cursors, :clang_disposeOverriddenCursors, [Cursor.by_ref], :void

  # Retrieve the file that is included by the given inclusion directive
  # cursor.
  #
  # @method get_included_file(cursor)
  # @param [Cursor] cursor
  # @return [FFI::Pointer(File)]
  # @scope class
  #
  attach_function :get_included_file, :clang_getIncludedFile, [Cursor.by_value], :pointer

  # Map a source location to the cursor that describes the entity at that
  # location in the source code.
  #
  # clang_getCursor() maps an arbitrary source location within a translation
  # unit down to the most specific cursor that describes the entity at that
  # location. For example, given an expression \c x + y, invoking
  # clang_getCursor() with a source location pointing to "x" will return the
  # cursor for "x"; similarly for "y". If the cursor points anywhere between
  # "x" or "y" (e.g., on the + or the whitespace around it), clang_getCursor()
  # will return a cursor referring to the "+" expression.
  #
  # @method get_cursor(translation_unit, source_location)
  # @param [TranslationUnit] translation_unit
  # @param [SourceLocation] source_location
  # @return [Cursor] a cursor representing the entity at the given source location, or
  #   a NULL cursor if no such entity can be found.
  # @scope class
  #
  attach_function :get_cursor, :clang_getCursor, [TranslationUnit.by_ref, SourceLocation.by_value], Cursor.by_value

  # Retrieve the physical location of the source constructor referenced
  # by the given cursor.
  #
  # The location of a declaration is typically the location of the name of that
  # declaration, where the name of that declaration would occur if it is
  # unnamed, or some keyword that introduces that particular declaration.
  # The location of a reference is where that reference occurs within the
  # source code.
  #
  # @method get_cursor_location(cursor)
  # @param [Cursor] cursor
  # @return [SourceLocation]
  # @scope class
  #
  attach_function :get_cursor_location, :clang_getCursorLocation, [Cursor.by_value], SourceLocation.by_value

  # Retrieve the physical extent of the source construct referenced by
  # the given cursor.
  #
  # The extent of a cursor starts with the file/line/column pointing at the
  # first character within the source construct that the cursor refers to and
  # ends with the last character withinin that source construct. For a
  # declaration, the extent covers the declaration itself. For a reference,
  # the extent covers the location of the reference (e.g., where the referenced
  # entity was actually used).
  #
  # @method get_cursor_extent(cursor)
  # @param [Cursor] cursor
  # @return [SourceRange]
  # @scope class
  #
  attach_function :get_cursor_extent, :clang_getCursorExtent, [Cursor.by_value], SourceRange.by_value

  # Retrieve the type of a CXCursor (if any).
  #
  # @method get_cursor_type(c)
  # @param [Cursor] c
  # @return [Type]
  # @scope class
  #
  attach_function :get_cursor_type, :clang_getCursorType, [Cursor.by_value], Type.by_value

  # Pretty-print the underlying type using the rules of the
  # language of the translation unit from which it came.
  #
  # If the type is invalid, an empty string is returned.
  #
  # @method get_type_spelling(ct)
  # @param [Type] ct
  # @return [String]
  # @scope class
  #
  attach_function :get_type_spelling, :clang_getTypeSpelling, [Type.by_value], String.by_value

  # Retrieve the underlying type of a typedef declaration.
  #
  # If the cursor does not reference a typedef declaration, an invalid type is
  # returned.
  #
  # @method get_typedef_decl_underlying_type(c)
  # @param [Cursor] c
  # @return [Type]
  # @scope class
  #
  attach_function :get_typedef_decl_underlying_type, :clang_getTypedefDeclUnderlyingType, [Cursor.by_value], Type.by_value

  # Retrieve the integer type of an enum declaration.
  #
  # If the cursor does not reference an enum declaration, an invalid type is
  # returned.
  #
  # @method get_enum_decl_integer_type(c)
  # @param [Cursor] c
  # @return [Type]
  # @scope class
  #
  attach_function :get_enum_decl_integer_type, :clang_getEnumDeclIntegerType, [Cursor.by_value], Type.by_value

  # Retrieve the integer value of an enum constant declaration as a signed
  #  long long.
  #
  # If the cursor does not reference an enum constant declaration, LLONG_MIN is returned.
  # Since this is also potentially a valid constant value, the kind of the cursor
  # must be verified before calling this function.
  #
  # @method get_enum_constant_decl_value(c)
  # @param [Cursor] c
  # @return [Integer]
  # @scope class
  #
  attach_function :get_enum_constant_decl_value, :clang_getEnumConstantDeclValue, [Cursor.by_value], :long_long

  # Retrieve the integer value of an enum constant declaration as an unsigned
  #  long long.
  #
  # If the cursor does not reference an enum constant declaration, ULLONG_MAX is returned.
  # Since this is also potentially a valid constant value, the kind of the cursor
  # must be verified before calling this function.
  #
  # @method get_enum_constant_decl_unsigned_value(c)
  # @param [Cursor] c
  # @return [Integer]
  # @scope class
  #
  attach_function :get_enum_constant_decl_unsigned_value, :clang_getEnumConstantDeclUnsignedValue, [Cursor.by_value], :ulong_long

  # Retrieve the bit width of a bit field declaration as an integer.
  #
  # If a cursor that is not a bit field declaration is passed in, -1 is returned.
  #
  # @method get_field_decl_bit_width(c)
  # @param [Cursor] c
  # @return [Integer]
  # @scope class
  #
  attach_function :get_field_decl_bit_width, :clang_getFieldDeclBitWidth, [Cursor.by_value], :int

  # Retrieve the number of non-variadic arguments associated with a given
  # cursor.
  #
  # The number of arguments can be determined for calls as well as for
  # declarations of functions or methods. For other cursors -1 is returned.
  #
  # @method cursor_get_num_arguments(c)
  # @param [Cursor] c
  # @return [Integer]
  # @scope class
  #
  attach_function :cursor_get_num_arguments, :clang_Cursor_getNumArguments, [Cursor.by_value], :int

  # Retrieve the argument cursor of a function or method.
  #
  # The argument cursor can be determined for calls as well as for declarations
  # of functions or methods. For other cursors and for invalid indices, an
  # invalid cursor is returned.
  #
  # @method cursor_get_argument(c, i)
  # @param [Cursor] c
  # @param [Integer] i
  # @return [Cursor]
  # @scope class
  #
  attach_function :cursor_get_argument, :clang_Cursor_getArgument, [Cursor.by_value, :uint], Cursor.by_value

  # Determine whether two CXTypes represent the same type.
  #
  # @method equal_types(a, b)
  # @param [Type] a
  # @param [Type] b
  # @return [Integer] non-zero if the CXTypes represent the same type and
  #            zero otherwise.
  # @scope class
  #
  attach_function :equal_types, :clang_equalTypes, [Type.by_value, Type.by_value], :uint

  # Return the canonical type for a CXType.
  #
  # Clang's type system explicitly models typedefs and all the ways
  # a specific type can be represented.  The canonical type is the underlying
  # type with all the "sugar" removed.  For example, if 'T' is a typedef
  # for 'int', the canonical type for 'T' would be 'int'.
  #
  # @method get_canonical_type(t)
  # @param [Type] t
  # @return [Type]
  # @scope class
  #
  attach_function :get_canonical_type, :clang_getCanonicalType, [Type.by_value], Type.by_value

  # Determine whether a CXType has the "const" qualifier set,
  # without looking through typedefs that may have added "const" at a
  # different level.
  #
  # @method is_const_qualified_type(t)
  # @param [Type] t
  # @return [Integer]
  # @scope class
  #
  attach_function :is_const_qualified_type, :clang_isConstQualifiedType, [Type.by_value], :uint

  # Determine whether a CXType has the "volatile" qualifier set,
  # without looking through typedefs that may have added "volatile" at
  # a different level.
  #
  # @method is_volatile_qualified_type(t)
  # @param [Type] t
  # @return [Integer]
  # @scope class
  #
  attach_function :is_volatile_qualified_type, :clang_isVolatileQualifiedType, [Type.by_value], :uint

  # Determine whether a CXType has the "restrict" qualifier set,
  # without looking through typedefs that may have added "restrict" at a
  # different level.
  #
  # @method is_restrict_qualified_type(t)
  # @param [Type] t
  # @return [Integer]
  # @scope class
  #
  attach_function :is_restrict_qualified_type, :clang_isRestrictQualifiedType, [Type.by_value], :uint

  # For pointer types, returns the type of the pointee.
  #
  # @method get_pointee_type(t)
  # @param [Type] t
  # @return [Type]
  # @scope class
  #
  attach_function :get_pointee_type, :clang_getPointeeType, [Type.by_value], Type.by_value

  # Return the cursor for the declaration of the given type.
  #
  # @method get_type_declaration(t)
  # @param [Type] t
  # @return [Cursor]
  # @scope class
  #
  attach_function :get_type_declaration, :clang_getTypeDeclaration, [Type.by_value], Cursor.by_value

  # Returns the Objective-C type encoding for the specified declaration.
  #
  # @method get_decl_obj_c_type_encoding(c)
  # @param [Cursor] c
  # @return [String]
  # @scope class
  #
  attach_function :get_decl_obj_c_type_encoding, :clang_getDeclObjCTypeEncoding, [Cursor.by_value], String.by_value

  # Retrieve the spelling of a given CXTypeKind.
  #
  # @method get_type_kind_spelling(k)
  # @param [Symbol from `enum_type_kind`] k
  # @return [String]
  # @scope class
  #
  attach_function :get_type_kind_spelling, :clang_getTypeKindSpelling, [:type_kind], String.by_value

  # Retrieve the calling convention associated with a function type.
  #
  # If a non-function type is passed in, CXCallingConv_Invalid is returned.
  #
  # @method get_function_type_calling_conv(t)
  # @param [Type] t
  # @return [Symbol from `enum_calling_conv`]
  # @scope class
  #
  attach_function :get_function_type_calling_conv, :clang_getFunctionTypeCallingConv, [Type.by_value], :calling_conv

  # Retrieve the result type associated with a function type.
  #
  # If a non-function type is passed in, an invalid type is returned.
  #
  # @method get_result_type(t)
  # @param [Type] t
  # @return [Type]
  # @scope class
  #
  attach_function :get_result_type, :clang_getResultType, [Type.by_value], Type.by_value

  # Retrieve the number of non-variadic arguments associated with a
  # function type.
  #
  # If a non-function type is passed in, -1 is returned.
  #
  # @method get_num_arg_types(t)
  # @param [Type] t
  # @return [Integer]
  # @scope class
  #
  attach_function :get_num_arg_types, :clang_getNumArgTypes, [Type.by_value], :int

  # Retrieve the type of an argument of a function type.
  #
  # If a non-function type is passed in or the function does not have enough
  # parameters, an invalid type is returned.
  #
  # @method get_arg_type(t, i)
  # @param [Type] t
  # @param [Integer] i
  # @return [Type]
  # @scope class
  #
  attach_function :get_arg_type, :clang_getArgType, [Type.by_value, :uint], Type.by_value

  # Return 1 if the CXType is a variadic function type, and 0 otherwise.
  #
  # @method is_function_type_variadic(t)
  # @param [Type] t
  # @return [Integer]
  # @scope class
  #
  attach_function :is_function_type_variadic, :clang_isFunctionTypeVariadic, [Type.by_value], :uint

  # Retrieve the result type associated with a given cursor.
  #
  # This only returns a valid type if the cursor refers to a function or method.
  #
  # @method get_cursor_result_type(c)
  # @param [Cursor] c
  # @return [Type]
  # @scope class
  #
  attach_function :get_cursor_result_type, :clang_getCursorResultType, [Cursor.by_value], Type.by_value

  # Return 1 if the CXType is a POD (plain old data) type, and 0
  #  otherwise.
  #
  # @method is_pod_type(t)
  # @param [Type] t
  # @return [Integer]
  # @scope class
  #
  attach_function :is_pod_type, :clang_isPODType, [Type.by_value], :uint

  # Return the element type of an array, complex, or vector type.
  #
  # If a type is passed in that is not an array, complex, or vector type,
  # an invalid type is returned.
  #
  # @method get_element_type(t)
  # @param [Type] t
  # @return [Type]
  # @scope class
  #
  attach_function :get_element_type, :clang_getElementType, [Type.by_value], Type.by_value

  # Return the number of elements of an array or vector type.
  #
  # If a type is passed in that is not an array or vector type,
  # -1 is returned.
  #
  # @method get_num_elements(t)
  # @param [Type] t
  # @return [Integer]
  # @scope class
  #
  attach_function :get_num_elements, :clang_getNumElements, [Type.by_value], :long_long

  # Return the element type of an array type.
  #
  # If a non-array type is passed in, an invalid type is returned.
  #
  # @method get_array_element_type(t)
  # @param [Type] t
  # @return [Type]
  # @scope class
  #
  attach_function :get_array_element_type, :clang_getArrayElementType, [Type.by_value], Type.by_value

  # Return the array size of a constant array.
  #
  # If a non-array type is passed in, -1 is returned.
  #
  # @method get_array_size(t)
  # @param [Type] t
  # @return [Integer]
  # @scope class
  #
  attach_function :get_array_size, :clang_getArraySize, [Type.by_value], :long_long

  # Return the alignment of a type in bytes as per C++(expr.alignof)
  #   standard.
  #
  # If the type declaration is invalid, CXTypeLayoutError_Invalid is returned.
  # If the type declaration is an incomplete type, CXTypeLayoutError_Incomplete
  #   is returned.
  # If the type declaration is a dependent type, CXTypeLayoutError_Dependent is
  #   returned.
  # If the type declaration is not a constant size type,
  #   CXTypeLayoutError_NotConstantSize is returned.
  #
  # @method type_get_align_of(t)
  # @param [Type] t
  # @return [Integer]
  # @scope class
  #
  attach_function :type_get_align_of, :clang_Type_getAlignOf, [Type.by_value], :long_long

  # Return the class type of an member pointer type.
  #
  # If a non-member-pointer type is passed in, an invalid type is returned.
  #
  # @method type_get_class_type(t)
  # @param [Type] t
  # @return [Type]
  # @scope class
  #
  attach_function :type_get_class_type, :clang_Type_getClassType, [Type.by_value], Type.by_value

  # Return the size of a type in bytes as per C++(expr.sizeof) standard.
  #
  # If the type declaration is invalid, CXTypeLayoutError_Invalid is returned.
  # If the type declaration is an incomplete type, CXTypeLayoutError_Incomplete
  #   is returned.
  # If the type declaration is a dependent type, CXTypeLayoutError_Dependent is
  #   returned.
  #
  # @method type_get_size_of(t)
  # @param [Type] t
  # @return [Integer]
  # @scope class
  #
  attach_function :type_get_size_of, :clang_Type_getSizeOf, [Type.by_value], :long_long

  # Return the offset of a field named S in a record of type T in bits
  #   as it would be returned by __offsetof__ as per C++11(18.2p4)
  #
  # If the cursor is not a record field declaration, CXTypeLayoutError_Invalid
  #   is returned.
  # If the field's type declaration is an incomplete type,
  #   CXTypeLayoutError_Incomplete is returned.
  # If the field's type declaration is a dependent type,
  #   CXTypeLayoutError_Dependent is returned.
  # If the field's name S is not found,
  #   CXTypeLayoutError_InvalidFieldName is returned.
  #
  # @method type_get_offset_of(t, s)
  # @param [Type] t
  # @param [String] s
  # @return [Integer]
  # @scope class
  #
  attach_function :type_get_offset_of, :clang_Type_getOffsetOf, [Type.by_value, :string], :long_long

  # Retrieve the ref-qualifier kind of a function or method.
  #
  # The ref-qualifier is returned for C++ functions or methods. For other types
  # or non-C++ declarations, CXRefQualifier_None is returned.
  #
  # @method type_get_cxx_ref_qualifier(t)
  # @param [Type] t
  # @return [Symbol from `enum_ref_qualifier_kind`]
  # @scope class
  #
  attach_function :type_get_cxx_ref_qualifier, :clang_Type_getCXXRefQualifier, [Type.by_value], :ref_qualifier_kind

  # Returns non-zero if the cursor specifies a Record member that is a
  #   bitfield.
  #
  # @method cursor_is_bit_field(c)
  # @param [Cursor] c
  # @return [Integer]
  # @scope class
  #
  attach_function :cursor_is_bit_field, :clang_Cursor_isBitField, [Cursor.by_value], :uint

  # Returns 1 if the base class specified by the cursor with kind
  #   CX_CXXBaseSpecifier is virtual.
  #
  # @method is_virtual_base(cursor)
  # @param [Cursor] cursor
  # @return [Integer]
  # @scope class
  #
  attach_function :is_virtual_base, :clang_isVirtualBase, [Cursor.by_value], :uint

  # Returns the access control level for the referenced object.
  #
  # If the cursor refers to a C++ declaration, its access control level within its
  # parent scope is returned. Otherwise, if the cursor refers to a base specifier or
  # access specifier, the specifier itself is returned.
  #
  # @method get_cxx_access_specifier(cursor)
  # @param [Cursor] cursor
  # @return [Symbol from `enum_cxx_access_specifier`]
  # @scope class
  #
  attach_function :get_cxx_access_specifier, :clang_getCXXAccessSpecifier, [Cursor.by_value], :cxx_access_specifier

  # Determine the number of overloaded declarations referenced by a
  # \c CXCursor_OverloadedDeclRef cursor.
  #
  # @method get_num_overloaded_decls(cursor)
  # @param [Cursor] cursor The cursor whose overloaded declarations are being queried.
  # @return [Integer] The number of overloaded declarations referenced by \c cursor. If it
  #   is not a \c CXCursor_OverloadedDeclRef cursor, returns 0.
  # @scope class
  #
  attach_function :get_num_overloaded_decls, :clang_getNumOverloadedDecls, [Cursor.by_value], :uint

  # Retrieve a cursor for one of the overloaded declarations referenced
  # by a \c CXCursor_OverloadedDeclRef cursor.
  #
  # @method get_overloaded_decl(cursor, index)
  # @param [Cursor] cursor The cursor whose overloaded declarations are being queried.
  # @param [Integer] index The zero-based index into the set of overloaded declarations in
  #   the cursor.
  # @return [Cursor] A cursor representing the declaration referenced by the given
  #   \c cursor at the specified \c index. If the cursor does not have an
  #   associated set of overloaded declarations, or if the index is out of bounds,
  #   returns \c clang_getNullCursor();
  # @scope class
  #
  attach_function :get_overloaded_decl, :clang_getOverloadedDecl, [Cursor.by_value, :uint], Cursor.by_value

  # For cursors representing an iboutletcollection attribute,
  #  this function returns the collection element type.
  #
  # @method get_ib_outlet_collection_type(cursor)
  # @param [Cursor] cursor
  # @return [Type]
  # @scope class
  #
  attach_function :get_ib_outlet_collection_type, :clang_getIBOutletCollectionType, [Cursor.by_value], Type.by_value

  # Visit the children of a particular cursor.
  #
  # This function visits all the direct children of the given cursor,
  # invoking the given \p visitor function with the cursors of each
  # visited child. The traversal may be recursive, if the visitor returns
  # \c CXChildVisit_Recurse. The traversal may also be ended prematurely, if
  # the visitor returns \c CXChildVisit_Break.
  #
  # @method visit_children(parent, visitor, client_data)
  # @param [Cursor] parent the cursor whose child may be visited. All kinds of
  #   cursors can be visited, including invalid cursors (which, by
  #   definition, have no children).
  # @param [Proc(callback_cursor_visitor)] visitor the visitor function that will be invoked for each
  #   child of \p parent.
  # @param [FFI::Pointer(ClientData)] client_data pointer data supplied by the client, which will
  #   be passed to the visitor each time it is invoked.
  # @return [Integer] a non-zero value if the traversal was terminated
  #   prematurely by the visitor returning \c CXChildVisit_Break.
  # @scope class
  #
  attach_function :visit_children, :clang_visitChildren, [Cursor.by_value, :cursor_visitor, :pointer], :uint

  # Visits the children of a cursor using the specified block.  Behaves
  # identically to clang_visitChildren() in all other respects.
  #
  # @method visit_children_with_block(parent, block)
  # @param [Cursor] parent
  # @param [Proc(callback_cursor_visitor_block)] block
  # @return [Integer]
  # @scope class
  #
  attach_function :visit_children_with_block, :clang_visitChildrenWithBlock, [Cursor.by_value, :cursor_visitor_block], :uint

  # Retrieve a Unified Symbol Resolution (USR) for the entity referenced
  # by the given cursor.
  #
  # A Unified Symbol Resolution (USR) is a string that identifies a particular
  # entity (function, class, variable, etc.) within a program. USRs can be
  # compared across translation units to determine, e.g., when references in
  # one translation refer to an entity defined in another translation unit.
  #
  # @method get_cursor_usr(cursor)
  # @param [Cursor] cursor
  # @return [String]
  # @scope class
  #
  attach_function :get_cursor_usr, :clang_getCursorUSR, [Cursor.by_value], String.by_value

  # Construct a USR for a specified Objective-C class.
  #
  # @method construct_usr_obj_c_class(class_name)
  # @param [String] class_name
  # @return [String]
  # @scope class
  #
  attach_function :construct_usr_obj_c_class, :clang_constructUSR_ObjCClass, [:string], String.by_value

  # Construct a USR for a specified Objective-C category.
  #
  # @method construct_usr_obj_c_category(class_name, category_name)
  # @param [String] class_name
  # @param [String] category_name
  # @return [String]
  # @scope class
  #
  attach_function :construct_usr_obj_c_category, :clang_constructUSR_ObjCCategory, [:string, :string], String.by_value

  # Construct a USR for a specified Objective-C protocol.
  #
  # @method construct_usr_obj_c_protocol(protocol_name)
  # @param [String] protocol_name
  # @return [String]
  # @scope class
  #
  attach_function :construct_usr_obj_c_protocol, :clang_constructUSR_ObjCProtocol, [:string], String.by_value

  # Construct a USR for a specified Objective-C instance variable and
  #   the USR for its containing class.
  #
  # @method construct_usr_obj_c_ivar(name, class_usr)
  # @param [String] name
  # @param [String] class_usr
  # @return [String]
  # @scope class
  #
  attach_function :construct_usr_obj_c_ivar, :clang_constructUSR_ObjCIvar, [:string, String.by_value], String.by_value

  # Construct a USR for a specified Objective-C method and
  #   the USR for its containing class.
  #
  # @method construct_usr_obj_c_method(name, is_instance_method, class_usr)
  # @param [String] name
  # @param [Integer] is_instance_method
  # @param [String] class_usr
  # @return [String]
  # @scope class
  #
  attach_function :construct_usr_obj_c_method, :clang_constructUSR_ObjCMethod, [:string, :uint, String.by_value], String.by_value

  # Construct a USR for a specified Objective-C property and the USR
  #  for its containing class.
  #
  # @method construct_usr_obj_c_property(property, class_usr)
  # @param [String] property
  # @param [String] class_usr
  # @return [String]
  # @scope class
  #
  attach_function :construct_usr_obj_c_property, :clang_constructUSR_ObjCProperty, [:string, String.by_value], String.by_value

  # Retrieve a name for the entity referenced by this cursor.
  #
  # @method get_cursor_spelling(cursor)
  # @param [Cursor] cursor
  # @return [String]
  # @scope class
  #
  attach_function :get_cursor_spelling, :clang_getCursorSpelling, [Cursor.by_value], String.by_value

  # Retrieve a range for a piece that forms the cursors spelling name.
  # Most of the times there is only one range for the complete spelling but for
  # objc methods and objc message expressions, there are multiple pieces for each
  # selector identifier.
  #
  # @method cursor_get_spelling_name_range(cursor, piece_index, options)
  # @param [Cursor] cursor
  # @param [Integer] piece_index the index of the spelling name piece. If this is greater
  #   than the actual number of pieces, it will return a NULL (invalid) range.
  # @param [Integer] options Reserved.
  # @return [SourceRange]
  # @scope class
  #
  attach_function :cursor_get_spelling_name_range, :clang_Cursor_getSpellingNameRange, [Cursor.by_value, :uint, :uint], SourceRange.by_value

  # Retrieve the display name for the entity referenced by this cursor.
  #
  # The display name contains extra information that helps identify the cursor,
  # such as the parameters of a function or template or the arguments of a
  # class template specialization.
  #
  # @method get_cursor_display_name(cursor)
  # @param [Cursor] cursor
  # @return [String]
  # @scope class
  #
  attach_function :get_cursor_display_name, :clang_getCursorDisplayName, [Cursor.by_value], String.by_value

  # For a cursor that is a reference, retrieve a cursor representing the
  # entity that it references.
  #
  # Reference cursors refer to other entities in the AST. For example, an
  # Objective-C superclass reference cursor refers to an Objective-C class.
  # This function produces the cursor for the Objective-C class from the
  # cursor for the superclass reference. If the input cursor is a declaration or
  # definition, it returns that declaration or definition unchanged.
  # Otherwise, returns the NULL cursor.
  #
  # @method get_cursor_referenced(cursor)
  # @param [Cursor] cursor
  # @return [Cursor]
  # @scope class
  #
  attach_function :get_cursor_referenced, :clang_getCursorReferenced, [Cursor.by_value], Cursor.by_value

  # For a cursor that is either a reference to or a declaration
  # of some entity, retrieve a cursor that describes the definition of
  # that entity.
  #
  # Some entities can be declared multiple times within a translation
  # unit, but only one of those declarations can also be a
  # definition. For example, given:
  #
  # \code
  # int f(int, int);
  # int g(int x, int y) { return f(x, y); }
  # int f(int a, int b) { return a + b; }
  # int f(int, int);
  # \endcode
  #
  # there are three declarations of the function "f", but only the
  # second one is a definition. The clang_getCursorDefinition()
  # function will take any cursor pointing to a declaration of "f"
  # (the first or fourth lines of the example) or a cursor referenced
  # that uses "f" (the call to "f' inside "g") and will return a
  # declaration cursor pointing to the definition (the second "f"
  # declaration).
  #
  # If given a cursor for which there is no corresponding definition,
  # e.g., because there is no definition of that entity within this
  # translation unit, returns a NULL cursor.
  #
  # @method get_cursor_definition(cursor)
  # @param [Cursor] cursor
  # @return [Cursor]
  # @scope class
  #
  attach_function :get_cursor_definition, :clang_getCursorDefinition, [Cursor.by_value], Cursor.by_value

  # Determine whether the declaration pointed to by this cursor
  # is also a definition of that entity.
  #
  # @method is_cursor_definition(cursor)
  # @param [Cursor] cursor
  # @return [Integer]
  # @scope class
  #
  attach_function :is_cursor_definition, :clang_isCursorDefinition, [Cursor.by_value], :uint

  # Retrieve the canonical cursor corresponding to the given cursor.
  #
  # In the C family of languages, many kinds of entities can be declared several
  # times within a single translation unit. For example, a structure type can
  # be forward-declared (possibly multiple times) and later defined:
  #
  # \code
  # struct X;
  # struct X;
  # struct X {
  #   int member;
  # };
  # \endcode
  #
  # The declarations and the definition of \c X are represented by three
  # different cursors, all of which are declarations of the same underlying
  # entity. One of these cursor is considered the "canonical" cursor, which
  # is effectively the representative for the underlying entity. One can
  # determine if two cursors are declarations of the same underlying entity by
  # comparing their canonical cursors.
  #
  # @method get_canonical_cursor(cursor)
  # @param [Cursor] cursor
  # @return [Cursor] The canonical cursor for the entity referred to by the given cursor.
  # @scope class
  #
  attach_function :get_canonical_cursor, :clang_getCanonicalCursor, [Cursor.by_value], Cursor.by_value

  # If the cursor points to a selector identifier in a objc method or
  # message expression, this returns the selector index.
  #
  # After getting a cursor with #clang_getCursor, this can be called to
  # determine if the location points to a selector identifier.
  #
  # @method cursor_get_obj_c_selector_index(cursor)
  # @param [Cursor] cursor
  # @return [Integer] The selector index if the cursor is an objc method or message
  #   expression and the cursor is pointing to a selector identifier, or -1
  #   otherwise.
  # @scope class
  #
  attach_function :cursor_get_obj_c_selector_index, :clang_Cursor_getObjCSelectorIndex, [Cursor.by_value], :int

  # Given a cursor pointing to a C++ method call or an ObjC message,
  # returns non-zero if the method/message is "dynamic", meaning:
  #
  # For a C++ method: the call is virtual.
  # For an ObjC message: the receiver is an object instance, not 'super' or a
  # specific class.
  #
  # If the method/message is "static" or the cursor does not point to a
  # method/message, it will return zero.
  #
  # @method cursor_is_dynamic_call(c)
  # @param [Cursor] c
  # @return [Integer]
  # @scope class
  #
  attach_function :cursor_is_dynamic_call, :clang_Cursor_isDynamicCall, [Cursor.by_value], :int

  # Given a cursor pointing to an ObjC message, returns the CXType of the
  # receiver.
  #
  # @method cursor_get_receiver_type(c)
  # @param [Cursor] c
  # @return [Type]
  # @scope class
  #
  attach_function :cursor_get_receiver_type, :clang_Cursor_getReceiverType, [Cursor.by_value], Type.by_value

  # Given a cursor that represents a property declaration, return the
  # associated property attributes. The bits are formed from
  # \c CXObjCPropertyAttrKind.
  #
  # @method cursor_get_obj_c_property_attributes(c, reserved)
  # @param [Cursor] c
  # @param [Integer] reserved Reserved for future use, pass 0.
  # @return [Integer]
  # @scope class
  #
  attach_function :cursor_get_obj_c_property_attributes, :clang_Cursor_getObjCPropertyAttributes, [Cursor.by_value, :uint], :uint

  # Given a cursor that represents an ObjC method or parameter
  # declaration, return the associated ObjC qualifiers for the return type or the
  # parameter respectively. The bits are formed from CXObjCDeclQualifierKind.
  #
  # @method cursor_get_obj_c_decl_qualifiers(c)
  # @param [Cursor] c
  # @return [Integer]
  # @scope class
  #
  attach_function :cursor_get_obj_c_decl_qualifiers, :clang_Cursor_getObjCDeclQualifiers, [Cursor.by_value], :uint

  # Given a cursor that represents an ObjC method or property declaration,
  # return non-zero if the declaration was affected by "@optional".
  # Returns zero if the cursor is not such a declaration or it is "@required".
  #
  # @method cursor_is_obj_c_optional(c)
  # @param [Cursor] c
  # @return [Integer]
  # @scope class
  #
  attach_function :cursor_is_obj_c_optional, :clang_Cursor_isObjCOptional, [Cursor.by_value], :uint

  # Returns non-zero if the given cursor is a variadic function or method.
  #
  # @method cursor_is_variadic(c)
  # @param [Cursor] c
  # @return [Integer]
  # @scope class
  #
  attach_function :cursor_is_variadic, :clang_Cursor_isVariadic, [Cursor.by_value], :uint

  # Given a cursor that represents a declaration, return the associated
  # comment's source range.  The range may include multiple consecutive comments
  # with whitespace in between.
  #
  # @method cursor_get_comment_range(c)
  # @param [Cursor] c
  # @return [SourceRange]
  # @scope class
  #
  attach_function :cursor_get_comment_range, :clang_Cursor_getCommentRange, [Cursor.by_value], SourceRange.by_value

  # Given a cursor that represents a declaration, return the associated
  # comment text, including comment markers.
  #
  # @method cursor_get_raw_comment_text(c)
  # @param [Cursor] c
  # @return [String]
  # @scope class
  #
  attach_function :cursor_get_raw_comment_text, :clang_Cursor_getRawCommentText, [Cursor.by_value], String.by_value

  # Given a cursor that represents a documentable entity (e.g.,
  # declaration), return the associated \paragraph; otherwise return the
  # first paragraph.
  #
  # @method cursor_get_brief_comment_text(c)
  # @param [Cursor] c
  # @return [String]
  # @scope class
  #
  attach_function :cursor_get_brief_comment_text, :clang_Cursor_getBriefCommentText, [Cursor.by_value], String.by_value

  # Given a cursor that represents a documentable entity (e.g.,
  # declaration), return the associated parsed comment as a
  # \c CXComment_FullComment AST node.
  #
  # @method cursor_get_parsed_comment(c)
  # @param [Cursor] c
  # @return [Comment]
  # @scope class
  #
  attach_function :cursor_get_parsed_comment, :clang_Cursor_getParsedComment, [Cursor.by_value], Comment.by_value

  # Given a CXCursor_ModuleImportDecl cursor, return the associated module.
  #
  # @method cursor_get_module(c)
  # @param [Cursor] c
  # @return [FFI::Pointer(Module)]
  # @scope class
  #
  attach_function :cursor_get_module, :clang_Cursor_getModule, [Cursor.by_value], :pointer

  # (Not documented)
  #
  # @method module_get_ast_file(module_)
  # @param [FFI::Pointer(Module)] module_ a module object.
  # @return [FFI::Pointer(File)] the module file where the provided module object came from.
  # @scope class
  #
  attach_function :module_get_ast_file, :clang_Module_getASTFile, [:pointer], :pointer

  # (Not documented)
  #
  # @method module_get_parent(module_)
  # @param [FFI::Pointer(Module)] module_ a module object.
  # @return [FFI::Pointer(Module)] the parent of a sub-module or NULL if the given module is top-level,
  #   e.g. for 'std.vector' it will return the 'std' module.
  # @scope class
  #
  attach_function :module_get_parent, :clang_Module_getParent, [:pointer], :pointer

  # (Not documented)
  #
  # @method module_get_name(module_)
  # @param [FFI::Pointer(Module)] module_ a module object.
  # @return [String] the name of the module, e.g. for the 'std.vector' sub-module it
  #   will return "vector".
  # @scope class
  #
  attach_function :module_get_name, :clang_Module_getName, [:pointer], String.by_value

  # (Not documented)
  #
  # @method module_get_full_name(module_)
  # @param [FFI::Pointer(Module)] module_ a module object.
  # @return [String] the full name of the module, e.g. "std.vector".
  # @scope class
  #
  attach_function :module_get_full_name, :clang_Module_getFullName, [:pointer], String.by_value

  # (Not documented)
  #
  # @method module_get_num_top_level_headers(translation_unit, module_)
  # @param [TranslationUnit] translation_unit
  # @param [FFI::Pointer(Module)] module_ a module object.
  # @return [Integer] the number of top level headers associated with this module.
  # @scope class
  #
  attach_function :module_get_num_top_level_headers, :clang_Module_getNumTopLevelHeaders, [TranslationUnit.by_ref, :pointer], :uint

  # (Not documented)
  #
  # @method module_get_top_level_header(translation_unit, module_, index)
  # @param [TranslationUnit] translation_unit
  # @param [FFI::Pointer(Module)] module_ a module object.
  # @param [Integer] index top level header index (zero-based).
  # @return [FFI::Pointer(File)] the specified top level header associated with the module.
  # @scope class
  #
  attach_function :module_get_top_level_header, :clang_Module_getTopLevelHeader, [TranslationUnit.by_ref, :pointer, :uint], :pointer

  # (Not documented)
  #
  # @method comment_get_kind(comment)
  # @param [Comment] comment AST node of any kind.
  # @return [Symbol from `enum_comment_kind`] the type of the AST node.
  # @scope class
  #
  attach_function :comment_get_kind, :clang_Comment_getKind, [Comment.by_value], :comment_kind

  # (Not documented)
  #
  # @method comment_get_num_children(comment)
  # @param [Comment] comment AST node of any kind.
  # @return [Integer] number of children of the AST node.
  # @scope class
  #
  attach_function :comment_get_num_children, :clang_Comment_getNumChildren, [Comment.by_value], :uint

  # (Not documented)
  #
  # @method comment_get_child(comment, child_idx)
  # @param [Comment] comment AST node of any kind.
  # @param [Integer] child_idx child index (zero-based).
  # @return [Comment] the specified child of the AST node.
  # @scope class
  #
  attach_function :comment_get_child, :clang_Comment_getChild, [Comment.by_value, :uint], Comment.by_value

  # A \c CXComment_Paragraph node is considered whitespace if it contains
  # only \c CXComment_Text nodes that are empty or whitespace.
  #
  # Other AST nodes (except \c CXComment_Paragraph and \c CXComment_Text) are
  # never considered whitespace.
  #
  # @method comment_is_whitespace(comment)
  # @param [Comment] comment
  # @return [Integer] non-zero if \c Comment is whitespace.
  # @scope class
  #
  attach_function :comment_is_whitespace, :clang_Comment_isWhitespace, [Comment.by_value], :uint

  # (Not documented)
  #
  # @method inline_content_comment_has_trailing_newline(comment)
  # @param [Comment] comment
  # @return [Integer] non-zero if \c Comment is inline content and has a newline
  #   immediately following it in the comment text.  Newlines between paragraphs
  #   do not count.
  # @scope class
  #
  attach_function :inline_content_comment_has_trailing_newline, :clang_InlineContentComment_hasTrailingNewline, [Comment.by_value], :uint

  # (Not documented)
  #
  # @method text_comment_get_text(comment)
  # @param [Comment] comment a \c CXComment_Text AST node.
  # @return [String] text contained in the AST node.
  # @scope class
  #
  attach_function :text_comment_get_text, :clang_TextComment_getText, [Comment.by_value], String.by_value

  # (Not documented)
  #
  # @method inline_command_comment_get_command_name(comment)
  # @param [Comment] comment a \c CXComment_InlineCommand AST node.
  # @return [String] name of the inline command.
  # @scope class
  #
  attach_function :inline_command_comment_get_command_name, :clang_InlineCommandComment_getCommandName, [Comment.by_value], String.by_value

  # (Not documented)
  #
  # @method inline_command_comment_get_render_kind(comment)
  # @param [Comment] comment a \c CXComment_InlineCommand AST node.
  # @return [Symbol from `enum_comment_inline_command_render_kind`] the most appropriate rendering mode, chosen on command
  #   semantics in Doxygen.
  # @scope class
  #
  attach_function :inline_command_comment_get_render_kind, :clang_InlineCommandComment_getRenderKind, [Comment.by_value], :comment_inline_command_render_kind

  # (Not documented)
  #
  # @method inline_command_comment_get_num_args(comment)
  # @param [Comment] comment a \c CXComment_InlineCommand AST node.
  # @return [Integer] number of command arguments.
  # @scope class
  #
  attach_function :inline_command_comment_get_num_args, :clang_InlineCommandComment_getNumArgs, [Comment.by_value], :uint

  # (Not documented)
  #
  # @method inline_command_comment_get_arg_text(comment, arg_idx)
  # @param [Comment] comment a \c CXComment_InlineCommand AST node.
  # @param [Integer] arg_idx argument index (zero-based).
  # @return [String] text of the specified argument.
  # @scope class
  #
  attach_function :inline_command_comment_get_arg_text, :clang_InlineCommandComment_getArgText, [Comment.by_value, :uint], String.by_value

  # (Not documented)
  #
  # @method html_tag_comment_get_tag_name(comment)
  # @param [Comment] comment a \c CXComment_HTMLStartTag or \c CXComment_HTMLEndTag AST
  #   node.
  # @return [String] HTML tag name.
  # @scope class
  #
  attach_function :html_tag_comment_get_tag_name, :clang_HTMLTagComment_getTagName, [Comment.by_value], String.by_value

  # (Not documented)
  #
  # @method html_start_tag_comment_is_self_closing(comment)
  # @param [Comment] comment a \c CXComment_HTMLStartTag AST node.
  # @return [Integer] non-zero if tag is self-closing (for example, &lt;br /&gt;).
  # @scope class
  #
  attach_function :html_start_tag_comment_is_self_closing, :clang_HTMLStartTagComment_isSelfClosing, [Comment.by_value], :uint

  # (Not documented)
  #
  # @method html_start_tag_get_num_attrs(comment)
  # @param [Comment] comment a \c CXComment_HTMLStartTag AST node.
  # @return [Integer] number of attributes (name-value pairs) attached to the start tag.
  # @scope class
  #
  attach_function :html_start_tag_get_num_attrs, :clang_HTMLStartTag_getNumAttrs, [Comment.by_value], :uint

  # (Not documented)
  #
  # @method html_start_tag_get_attr_name(comment, attr_idx)
  # @param [Comment] comment a \c CXComment_HTMLStartTag AST node.
  # @param [Integer] attr_idx attribute index (zero-based).
  # @return [String] name of the specified attribute.
  # @scope class
  #
  attach_function :html_start_tag_get_attr_name, :clang_HTMLStartTag_getAttrName, [Comment.by_value, :uint], String.by_value

  # (Not documented)
  #
  # @method html_start_tag_get_attr_value(comment, attr_idx)
  # @param [Comment] comment a \c CXComment_HTMLStartTag AST node.
  # @param [Integer] attr_idx attribute index (zero-based).
  # @return [String] value of the specified attribute.
  # @scope class
  #
  attach_function :html_start_tag_get_attr_value, :clang_HTMLStartTag_getAttrValue, [Comment.by_value, :uint], String.by_value

  # (Not documented)
  #
  # @method block_command_comment_get_command_name(comment)
  # @param [Comment] comment a \c CXComment_BlockCommand AST node.
  # @return [String] name of the block command.
  # @scope class
  #
  attach_function :block_command_comment_get_command_name, :clang_BlockCommandComment_getCommandName, [Comment.by_value], String.by_value

  # (Not documented)
  #
  # @method block_command_comment_get_num_args(comment)
  # @param [Comment] comment a \c CXComment_BlockCommand AST node.
  # @return [Integer] number of word-like arguments.
  # @scope class
  #
  attach_function :block_command_comment_get_num_args, :clang_BlockCommandComment_getNumArgs, [Comment.by_value], :uint

  # (Not documented)
  #
  # @method block_command_comment_get_arg_text(comment, arg_idx)
  # @param [Comment] comment a \c CXComment_BlockCommand AST node.
  # @param [Integer] arg_idx argument index (zero-based).
  # @return [String] text of the specified word-like argument.
  # @scope class
  #
  attach_function :block_command_comment_get_arg_text, :clang_BlockCommandComment_getArgText, [Comment.by_value, :uint], String.by_value

  # (Not documented)
  #
  # @method block_command_comment_get_paragraph(comment)
  # @param [Comment] comment a \c CXComment_BlockCommand or
  #   \c CXComment_VerbatimBlockCommand AST node.
  # @return [Comment] paragraph argument of the block command.
  # @scope class
  #
  attach_function :block_command_comment_get_paragraph, :clang_BlockCommandComment_getParagraph, [Comment.by_value], Comment.by_value

  # (Not documented)
  #
  # @method param_command_comment_get_param_name(comment)
  # @param [Comment] comment a \c CXComment_ParamCommand AST node.
  # @return [String] parameter name.
  # @scope class
  #
  attach_function :param_command_comment_get_param_name, :clang_ParamCommandComment_getParamName, [Comment.by_value], String.by_value

  # (Not documented)
  #
  # @method param_command_comment_is_param_index_valid(comment)
  # @param [Comment] comment a \c CXComment_ParamCommand AST node.
  # @return [Integer] non-zero if the parameter that this AST node represents was found
  #   in the function prototype and \c clang_ParamCommandComment_getParamIndex
  #   function will return a meaningful value.
  # @scope class
  #
  attach_function :param_command_comment_is_param_index_valid, :clang_ParamCommandComment_isParamIndexValid, [Comment.by_value], :uint

  # (Not documented)
  #
  # @method param_command_comment_get_param_index(comment)
  # @param [Comment] comment a \c CXComment_ParamCommand AST node.
  # @return [Integer] zero-based parameter index in function prototype.
  # @scope class
  #
  attach_function :param_command_comment_get_param_index, :clang_ParamCommandComment_getParamIndex, [Comment.by_value], :uint

  # (Not documented)
  #
  # @method param_command_comment_is_direction_explicit(comment)
  # @param [Comment] comment a \c CXComment_ParamCommand AST node.
  # @return [Integer] non-zero if parameter passing direction was specified explicitly in
  #   the comment.
  # @scope class
  #
  attach_function :param_command_comment_is_direction_explicit, :clang_ParamCommandComment_isDirectionExplicit, [Comment.by_value], :uint

  # (Not documented)
  #
  # @method param_command_comment_get_direction(comment)
  # @param [Comment] comment a \c CXComment_ParamCommand AST node.
  # @return [Symbol from `enum_comment_param_pass_direction`] parameter passing direction.
  # @scope class
  #
  attach_function :param_command_comment_get_direction, :clang_ParamCommandComment_getDirection, [Comment.by_value], :comment_param_pass_direction

  # (Not documented)
  #
  # @method t_param_command_comment_get_param_name(comment)
  # @param [Comment] comment a \c CXComment_TParamCommand AST node.
  # @return [String] template parameter name.
  # @scope class
  #
  attach_function :t_param_command_comment_get_param_name, :clang_TParamCommandComment_getParamName, [Comment.by_value], String.by_value

  # (Not documented)
  #
  # @method t_param_command_comment_is_param_position_valid(comment)
  # @param [Comment] comment a \c CXComment_TParamCommand AST node.
  # @return [Integer] non-zero if the parameter that this AST node represents was found
  #   in the template parameter list and
  #   \c clang_TParamCommandComment_getDepth and
  #   \c clang_TParamCommandComment_getIndex functions will return a meaningful
  #   value.
  # @scope class
  #
  attach_function :t_param_command_comment_is_param_position_valid, :clang_TParamCommandComment_isParamPositionValid, [Comment.by_value], :uint

  # (Not documented)
  #
  # @method t_param_command_comment_get_depth(comment)
  # @param [Comment] comment a \c CXComment_TParamCommand AST node.
  # @return [Integer] zero-based nesting depth of this parameter in the template parameter list.
  #
  #   For example,
  #   \verbatim
  #       template<typename C, template<typename T> class TT>
  #       void test(TT<int> aaa);
  #   \endverbatim
  #   for C and TT nesting depth is 0,
  #   for T nesting depth is 1.
  # @scope class
  #
  attach_function :t_param_command_comment_get_depth, :clang_TParamCommandComment_getDepth, [Comment.by_value], :uint

  # (Not documented)
  #
  # @method t_param_command_comment_get_index(comment, depth)
  # @param [Comment] comment a \c CXComment_TParamCommand AST node.
  # @param [Integer] depth
  # @return [Integer] zero-based parameter index in the template parameter list at a
  #   given nesting depth.
  #
  #   For example,
  #   \verbatim
  #       template<typename C, template<typename T> class TT>
  #       void test(TT<int> aaa);
  #   \endverbatim
  #   for C and TT nesting depth is 0, so we can ask for index at depth 0:
  #   at depth 0 C's index is 0, TT's index is 1.
  #
  #   For T nesting depth is 1, so we can ask for index at depth 0 and 1:
  #   at depth 0 T's index is 1 (same as TT's),
  #   at depth 1 T's index is 0.
  # @scope class
  #
  attach_function :t_param_command_comment_get_index, :clang_TParamCommandComment_getIndex, [Comment.by_value, :uint], :uint

  # (Not documented)
  #
  # @method verbatim_block_line_comment_get_text(comment)
  # @param [Comment] comment a \c CXComment_VerbatimBlockLine AST node.
  # @return [String] text contained in the AST node.
  # @scope class
  #
  attach_function :verbatim_block_line_comment_get_text, :clang_VerbatimBlockLineComment_getText, [Comment.by_value], String.by_value

  # (Not documented)
  #
  # @method verbatim_line_comment_get_text(comment)
  # @param [Comment] comment a \c CXComment_VerbatimLine AST node.
  # @return [String] text contained in the AST node.
  # @scope class
  #
  attach_function :verbatim_line_comment_get_text, :clang_VerbatimLineComment_getText, [Comment.by_value], String.by_value

  # Convert an HTML tag AST node to string.
  #
  # @method html_tag_comment_get_as_string(comment)
  # @param [Comment] comment a \c CXComment_HTMLStartTag or \c CXComment_HTMLEndTag AST
  #   node.
  # @return [String] string containing an HTML tag.
  # @scope class
  #
  attach_function :html_tag_comment_get_as_string, :clang_HTMLTagComment_getAsString, [Comment.by_value], String.by_value

  # Convert a given full parsed comment to an HTML fragment.
  #
  # Specific details of HTML layout are subject to change.  Don't try to parse
  # this HTML back into an AST, use other APIs instead.
  #
  # Currently the following CSS classes are used:
  # \li "para-brief" for \paragraph and equivalent commands;
  #
  # @method full_comment_get_as_html(comment)
  # @param [Comment] comment a \c CXComment_FullComment AST node.
  # @return [String] \li "para-returns" for \paragraph and equivalent commands;
  #   \li "word-returns" for the "Returns" word in \paragraph.
  #
  #   Function argument documentation is rendered as a \<dl\> list with arguments
  #   sorted in function prototype order.  CSS classes used:
  #   \li "param-name-index-NUMBER" for parameter name (\<dt\>);
  #   \li "param-descr-index-NUMBER" for parameter description (\<dd\>);
  #   \li "param-name-index-invalid" and "param-descr-index-invalid" are used if
  #   parameter index is invalid.
  #
  #   Template parameter documentation is rendered as a \<dl\> list with
  #   parameters sorted in template parameter list order.  CSS classes used:
  #   \li "tparam-name-index-NUMBER" for parameter name (\<dt\>);
  #   \li "tparam-descr-index-NUMBER" for parameter description (\<dd\>);
  #   \li "tparam-name-index-other" and "tparam-descr-index-other" are used for
  #   names inside template template parameters;
  #   \li "tparam-name-index-invalid" and "tparam-descr-index-invalid" are used if
  #   parameter position is invalid.
  #
  #   string containing an HTML fragment.
  # @scope class
  #
  attach_function :full_comment_get_as_html, :clang_FullComment_getAsHTML, [Comment.by_value], String.by_value

  # Convert a given full parsed comment to an XML document.
  #
  # A Relax NG schema for the XML can be found in comment-xml-schema.rng file
  # inside clang source tree.
  #
  # @method full_comment_get_as_xml(comment)
  # @param [Comment] comment a \c CXComment_FullComment AST node.
  # @return [String] string containing an XML document.
  # @scope class
  #
  attach_function :full_comment_get_as_xml, :clang_FullComment_getAsXML, [Comment.by_value], String.by_value

  # Determine if a C++ member function or member function template is
  # pure virtual.
  #
  # @method cxx_method_is_pure_virtual(c)
  # @param [Cursor] c
  # @return [Integer]
  # @scope class
  #
  attach_function :cxx_method_is_pure_virtual, :clang_CXXMethod_isPureVirtual, [Cursor.by_value], :uint

  # Determine if a C++ member function or member function template is
  # declared 'static'.
  #
  # @method cxx_method_is_static(c)
  # @param [Cursor] c
  # @return [Integer]
  # @scope class
  #
  attach_function :cxx_method_is_static, :clang_CXXMethod_isStatic, [Cursor.by_value], :uint

  # Determine if a C++ member function or member function template is
  # explicitly declared 'virtual' or if it overrides a virtual method from
  # one of the base classes.
  #
  # @method cxx_method_is_virtual(c)
  # @param [Cursor] c
  # @return [Integer]
  # @scope class
  #
  attach_function :cxx_method_is_virtual, :clang_CXXMethod_isVirtual, [Cursor.by_value], :uint

  # Given a cursor that represents a template, determine
  # the cursor kind of the specializations would be generated by instantiating
  # the template.
  #
  # This routine can be used to determine what flavor of function template,
  # class template, or class template partial specialization is stored in the
  # cursor. For example, it can describe whether a class template cursor is
  # declared with "struct", "class" or "union".
  #
  # @method get_template_cursor_kind(c)
  # @param [Cursor] c The cursor to query. This cursor should represent a template
  #   declaration.
  # @return [Symbol from `enum_cursor_kind`] The cursor kind of the specializations that would be generated
  #   by instantiating the template \p C. If \p C is not a template, returns
  #   \c CXCursor_NoDeclFound.
  # @scope class
  #
  attach_function :get_template_cursor_kind, :clang_getTemplateCursorKind, [Cursor.by_value], :cursor_kind

  # Given a cursor that may represent a specialization or instantiation
  # of a template, retrieve the cursor that represents the template that it
  # specializes or from which it was instantiated.
  #
  # This routine determines the template involved both for explicit
  # specializations of templates and for implicit instantiations of the template,
  # both of which are referred to as "specializations". For a class template
  # specialization (e.g., \c std::vector<bool>), this routine will return
  # either the primary template (\c std::vector) or, if the specialization was
  # instantiated from a class template partial specialization, the class template
  # partial specialization. For a class template partial specialization and a
  # function template specialization (including instantiations), this
  # this routine will return the specialized template.
  #
  # For members of a class template (e.g., member functions, member classes, or
  # static data members), returns the specialized or instantiated member.
  # Although not strictly "templates" in the C++ language, members of class
  # templates have the same notions of specializations and instantiations that
  # templates do, so this routine treats them similarly.
  #
  # @method get_specialized_cursor_template(c)
  # @param [Cursor] c A cursor that may be a specialization of a template or a member
  #   of a template.
  # @return [Cursor] If the given cursor is a specialization or instantiation of a
  #   template or a member thereof, the template or member that it specializes or
  #   from which it was instantiated. Otherwise, returns a NULL cursor.
  # @scope class
  #
  attach_function :get_specialized_cursor_template, :clang_getSpecializedCursorTemplate, [Cursor.by_value], Cursor.by_value

  # Given a cursor that references something else, return the source range
  # covering that reference.
  #
  # @method get_cursor_reference_name_range(c, name_flags, piece_index)
  # @param [Cursor] c A cursor pointing to a member reference, a declaration reference, or
  #   an operator call.
  # @param [Integer] name_flags A bitset with three independent flags:
  #   CXNameRange_WantQualifier, CXNameRange_WantTemplateArgs, and
  #   CXNameRange_WantSinglePiece.
  # @param [Integer] piece_index For contiguous names or when passing the flag
  #   CXNameRange_WantSinglePiece, only one piece with index 0 is
  #   available. When the CXNameRange_WantSinglePiece flag is not passed for a
  #   non-contiguous names, this index can be used to retrieve the individual
  #   pieces of the name. See also CXNameRange_WantSinglePiece.
  # @return [SourceRange] The piece of the name pointed to by the given cursor. If there is no
  #   name, or if the PieceIndex is out-of-range, a null-cursor will be returned.
  # @scope class
  #
  attach_function :get_cursor_reference_name_range, :clang_getCursorReferenceNameRange, [Cursor.by_value, :uint, :uint], SourceRange.by_value

  # Determine the kind of the given token.
  #
  # @method get_token_kind(token)
  # @param [Token] token
  # @return [Symbol from `enum_token_kind`]
  # @scope class
  #
  attach_function :get_token_kind, :clang_getTokenKind, [Token.by_value], :token_kind

  # Determine the spelling of the given token.
  #
  # The spelling of a token is the textual representation of that token, e.g.,
  # the text of an identifier or keyword.
  #
  # @method get_token_spelling(translation_unit, token)
  # @param [TranslationUnit] translation_unit
  # @param [Token] token
  # @return [String]
  # @scope class
  #
  attach_function :get_token_spelling, :clang_getTokenSpelling, [TranslationUnit.by_ref, Token.by_value], String.by_value

  # Retrieve the source location of the given token.
  #
  # @method get_token_location(translation_unit, token)
  # @param [TranslationUnit] translation_unit
  # @param [Token] token
  # @return [SourceLocation]
  # @scope class
  #
  attach_function :get_token_location, :clang_getTokenLocation, [TranslationUnit.by_ref, Token.by_value], SourceLocation.by_value

  # Retrieve a source range that covers the given token.
  #
  # @method get_token_extent(translation_unit, token)
  # @param [TranslationUnit] translation_unit
  # @param [Token] token
  # @return [SourceRange]
  # @scope class
  #
  attach_function :get_token_extent, :clang_getTokenExtent, [TranslationUnit.by_ref, Token.by_value], SourceRange.by_value

  # Tokenize the source code described by the given range into raw
  # lexical tokens.
  #
  # @method tokenize(tu, range, tokens, num_tokens)
  # @param [TranslationUnit] tu the translation unit whose text is being tokenized.
  # @param [SourceRange] range the source range in which text should be tokenized. All of the
  #   tokens produced by tokenization will fall within this source range,
  # @param [FFI::Pointer(**Token)] tokens this pointer will be set to point to the array of tokens
  #   that occur within the given source range. The returned pointer must be
  #   freed with clang_disposeTokens() before the translation unit is destroyed.
  # @param [FFI::Pointer(*UInt)] num_tokens will be set to the number of tokens in the \c *Tokens
  #   array.
  # @return [nil]
  # @scope class
  #
  attach_function :tokenize, :clang_tokenize, [TranslationUnit.by_ref, SourceRange.by_value, :pointer, :pointer], :void

  # Annotate the given set of tokens by providing cursors for each token
  # that can be mapped to a specific entity within the abstract syntax tree.
  #
  # This token-annotation routine is equivalent to invoking
  # clang_getCursor() for the source locations of each of the
  # tokens. The cursors provided are filtered, so that only those
  # cursors that have a direct correspondence to the token are
  # accepted. For example, given a function call \c f(x),
  # clang_getCursor() would provide the following cursors:
  #
  #   * when the cursor is over the 'f', a DeclRefExpr cursor referring to 'f'.
  #   * when the cursor is over the '(' or the ')', a CallExpr referring to 'f'.
  #   * when the cursor is over the 'x', a DeclRefExpr cursor referring to 'x'.
  #
  # Only the first and last of these cursors will occur within the
  # annotate, since the tokens "f" and "x' directly refer to a function
  # and a variable, respectively, but the parentheses are just a small
  # part of the full syntax of the function call expression, which is
  # not provided as an annotation.
  #
  # @method annotate_tokens(tu, tokens, num_tokens, cursors)
  # @param [TranslationUnit] tu the translation unit that owns the given tokens.
  # @param [Token] tokens the set of tokens to annotate.
  # @param [Integer] num_tokens the number of tokens in \p Tokens.
  # @param [Cursor] cursors an array of \p NumTokens cursors, whose contents will be
  #   replaced with the cursors corresponding to each token.
  # @return [nil]
  # @scope class
  #
  attach_function :annotate_tokens, :clang_annotateTokens, [TranslationUnit.by_ref, Token.by_ref, :uint, Cursor.by_ref], :void

  # Free the given set of tokens.
  #
  # @method dispose_tokens(tu, tokens, num_tokens)
  # @param [TranslationUnit] tu
  # @param [Token] tokens
  # @param [Integer] num_tokens
  # @return [nil]
  # @scope class
  #
  attach_function :dispose_tokens, :clang_disposeTokens, [TranslationUnit.by_ref, Token.by_ref, :uint], :void

  # for debug/testing
  #
  # @method get_cursor_kind_spelling(kind)
  # @param [Symbol from `enum_cursor_kind`] kind
  # @return [String]
  # @scope class
  #
  attach_function :get_cursor_kind_spelling, :clang_getCursorKindSpelling, [:cursor_kind], String.by_value

  # (Not documented)
  #
  # @method get_definition_spelling_and_extent(cursor, start_buf, end_buf, start_line, start_column, end_line, end_column)
  # @param [Cursor] cursor
  # @param [FFI::Pointer(**CharS)] start_buf
  # @param [FFI::Pointer(**CharS)] end_buf
  # @param [FFI::Pointer(*UInt)] start_line
  # @param [FFI::Pointer(*UInt)] start_column
  # @param [FFI::Pointer(*UInt)] end_line
  # @param [FFI::Pointer(*UInt)] end_column
  # @return [nil]
  # @scope class
  #
  attach_function :get_definition_spelling_and_extent, :clang_getDefinitionSpellingAndExtent, [Cursor.by_value, :pointer, :pointer, :pointer, :pointer, :pointer, :pointer], :void

  # (Not documented)
  #
  # @method enable_stack_traces()
  # @return [nil]
  # @scope class
  #
  attach_function :enable_stack_traces, :clang_enableStackTraces, [], :void

  # (Not documented)
  #
  # @method execute_on_thread(fn, user_data, stack_size)
  # @param [FFI::Pointer(*)] fn
  # @param [FFI::Pointer(*Void)] user_data
  # @param [Integer] stack_size
  # @return [nil]
  # @scope class
  #
  attach_function :execute_on_thread, :clang_executeOnThread, [:pointer, :pointer, :uint], :void

  # Determine the kind of a particular chunk within a completion string.
  #
  # @method get_completion_chunk_kind(completion_string, chunk_number)
  # @param [FFI::Pointer(CompletionString)] completion_string the completion string to query.
  # @param [Integer] chunk_number the 0-based index of the chunk in the completion string.
  # @return [Symbol from `enum_completion_chunk_kind`] the kind of the chunk at the index \c chunk_number.
  # @scope class
  #
  attach_function :get_completion_chunk_kind, :clang_getCompletionChunkKind, [:pointer, :uint], :completion_chunk_kind

  # Retrieve the text associated with a particular chunk within a
  # completion string.
  #
  # @method get_completion_chunk_text(completion_string, chunk_number)
  # @param [FFI::Pointer(CompletionString)] completion_string the completion string to query.
  # @param [Integer] chunk_number the 0-based index of the chunk in the completion string.
  # @return [String] the text associated with the chunk at index \c chunk_number.
  # @scope class
  #
  attach_function :get_completion_chunk_text, :clang_getCompletionChunkText, [:pointer, :uint], String.by_value

  # Retrieve the completion string associated with a particular chunk
  # within a completion string.
  #
  # @method get_completion_chunk_completion_string(completion_string, chunk_number)
  # @param [FFI::Pointer(CompletionString)] completion_string the completion string to query.
  # @param [Integer] chunk_number the 0-based index of the chunk in the completion string.
  # @return [FFI::Pointer(CompletionString)] the completion string associated with the chunk at index
  #   \c chunk_number.
  # @scope class
  #
  attach_function :get_completion_chunk_completion_string, :clang_getCompletionChunkCompletionString, [:pointer, :uint], :pointer

  # Retrieve the number of chunks in the given code-completion string.
  #
  # @method get_num_completion_chunks(completion_string)
  # @param [FFI::Pointer(CompletionString)] completion_string
  # @return [Integer]
  # @scope class
  #
  attach_function :get_num_completion_chunks, :clang_getNumCompletionChunks, [:pointer], :uint

  # Determine the priority of this code completion.
  #
  # The priority of a code completion indicates how likely it is that this
  # particular completion is the completion that the user will select. The
  # priority is selected by various internal heuristics.
  #
  # @method get_completion_priority(completion_string)
  # @param [FFI::Pointer(CompletionString)] completion_string The completion string to query.
  # @return [Integer] The priority of this completion string. Smaller values indicate
  #   higher-priority (more likely) completions.
  # @scope class
  #
  attach_function :get_completion_priority, :clang_getCompletionPriority, [:pointer], :uint

  # Determine the availability of the entity that this code-completion
  # string refers to.
  #
  # @method get_completion_availability(completion_string)
  # @param [FFI::Pointer(CompletionString)] completion_string The completion string to query.
  # @return [Symbol from `enum_availability_kind`] The availability of the completion string.
  # @scope class
  #
  attach_function :get_completion_availability, :clang_getCompletionAvailability, [:pointer], :availability_kind

  # Retrieve the number of annotations associated with the given
  # completion string.
  #
  # @method get_completion_num_annotations(completion_string)
  # @param [FFI::Pointer(CompletionString)] completion_string the completion string to query.
  # @return [Integer] the number of annotations associated with the given completion
  #   string.
  # @scope class
  #
  attach_function :get_completion_num_annotations, :clang_getCompletionNumAnnotations, [:pointer], :uint

  # Retrieve the annotation associated with the given completion string.
  #
  # @method get_completion_annotation(completion_string, annotation_number)
  # @param [FFI::Pointer(CompletionString)] completion_string the completion string to query.
  # @param [Integer] annotation_number the 0-based index of the annotation of the
  #   completion string.
  # @return [String] annotation string associated with the completion at index
  #   \c annotation_number, or a NULL string if that annotation is not available.
  # @scope class
  #
  attach_function :get_completion_annotation, :clang_getCompletionAnnotation, [:pointer, :uint], String.by_value

  # Retrieve the parent context of the given completion string.
  #
  # The parent context of a completion string is the semantic parent of
  # the declaration (if any) that the code completion represents. For example,
  # a code completion for an Objective-C method would have the method's class
  # or protocol as its context.
  #
  # @method get_completion_parent(completion_string, kind)
  # @param [FFI::Pointer(CompletionString)] completion_string The code completion string whose parent is
  #   being queried.
  # @param [FFI::Pointer(*CursorKind)] kind DEPRECATED: always set to CXCursor_NotImplemented if non-NULL.
  # @return [String] The name of the completion parent, e.g., "NSObject" if
  #   the completion string represents a method in the NSObject class.
  # @scope class
  #
  attach_function :get_completion_parent, :clang_getCompletionParent, [:pointer, :pointer], String.by_value

  # Retrieve the brief documentation comment attached to the declaration
  # that corresponds to the given completion string.
  #
  # @method get_completion_brief_comment(completion_string)
  # @param [FFI::Pointer(CompletionString)] completion_string
  # @return [String]
  # @scope class
  #
  attach_function :get_completion_brief_comment, :clang_getCompletionBriefComment, [:pointer], String.by_value

  # Retrieve a completion string for an arbitrary declaration or macro
  # definition cursor.
  #
  # @method get_cursor_completion_string(cursor)
  # @param [Cursor] cursor The cursor to query.
  # @return [FFI::Pointer(CompletionString)] A non-context-sensitive completion string for declaration and macro
  #   definition cursors, or NULL for other kinds of cursors.
  # @scope class
  #
  attach_function :get_cursor_completion_string, :clang_getCursorCompletionString, [Cursor.by_value], :pointer

  # Returns a default set of code-completion options that can be
  # passed to\c clang_codeCompleteAt().
  #
  # @method default_code_complete_options()
  # @return [Integer]
  # @scope class
  #
  attach_function :default_code_complete_options, :clang_defaultCodeCompleteOptions, [], :uint

  # Perform code completion at a given location in a translation unit.
  #
  # This function performs code completion at a particular file, line, and
  # column within source code, providing results that suggest potential
  # code snippets based on the context of the completion. The basic model
  # for code completion is that Clang will parse a complete source file,
  # performing syntax checking up to the location where code-completion has
  # been requested. At that point, a special code-completion token is passed
  # to the parser, which recognizes this token and determines, based on the
  # current location in the C/Objective-C/C++ grammar and the state of
  # semantic analysis, what completions to provide. These completions are
  # returned via a new \c CXCodeCompleteResults structure.
  #
  # Code completion itself is meant to be triggered by the client when the
  # user types punctuation characters or whitespace, at which point the
  # code-completion location will coincide with the cursor. For example, if \c p
  # is a pointer, code-completion might be triggered after the "-" and then
  # after the ">" in \c p->. When the code-completion location is afer the ">",
  # the completion results will provide, e.g., the members of the struct that
  # "p" points to. The client is responsible for placing the cursor at the
  # beginning of the token currently being typed, then filtering the results
  # based on the contents of the token. For example, when code-completing for
  # the expression \c p->get, the client should provide the location just after
  # the ">" (e.g., pointing at the "g") to this code-completion hook. Then, the
  # client can filter the results based on the current token text ("get"), only
  # showing those results that start with "get". The intent of this interface
  # is to separate the relatively high-latency acquisition of code-completion
  # results from the filtering of results on a per-character basis, which must
  # have a lower latency.
  #
  # @method code_complete_at(tu, complete_filename, complete_line, complete_column, unsaved_files, num_unsaved_files, options)
  # @param [TranslationUnit] tu The translation unit in which code-completion should
  #   occur. The source files for this translation unit need not be
  #   completely up-to-date (and the contents of those source files may
  #   be overridden via \p unsaved_files). Cursors referring into the
  #   translation unit may be invalidated by this invocation.
  # @param [String] complete_filename The name of the source file where code
  #   completion should be performed. This filename may be any file
  #   included in the translation unit.
  # @param [Integer] complete_line The line at which code-completion should occur.
  # @param [Integer] complete_column The column at which code-completion should occur.
  #   Note that the column should point just after the syntactic construct that
  #   initiated code completion, and not in the middle of a lexical token.
  # @param [UnsavedFile] unsaved_files the Tiles that have not yet been saved to disk
  #   but may be required for parsing or code completion, including the
  #   contents of those files.  The contents and name of these files (as
  #   specified by CXUnsavedFile) are copied when necessary, so the
  #   client only needs to guarantee their validity until the call to
  #   this function returns.
  # @param [Integer] num_unsaved_files The number of unsaved file entries in \p
  #   unsaved_files.
  # @param [Integer] options Extra options that control the behavior of code
  #   completion, expressed as a bitwise OR of the enumerators of the
  #   CXCodeComplete_Flags enumeration. The
  #   \c clang_defaultCodeCompleteOptions() function returns a default set
  #   of code-completion options.
  # @return [CodeCompleteResults] If successful, a new \c CXCodeCompleteResults structure
  #   containing code-completion results, which should eventually be
  #   freed with \c clang_disposeCodeCompleteResults(). If code
  #   completion fails, returns NULL.
  # @scope class
  #
  attach_function :code_complete_at, :clang_codeCompleteAt, [TranslationUnit.by_ref, :string, :uint, :uint, UnsavedFile.by_ref, :uint, :uint], CodeCompleteResults.by_ref

  # Sort the code-completion results in case-insensitive alphabetical
  # order.
  #
  # @method sort_code_completion_results(results, num_results)
  # @param [CompletionResult] results The set of results to sort.
  # @param [Integer] num_results The number of results in \p Results.
  # @return [nil]
  # @scope class
  #
  attach_function :sort_code_completion_results, :clang_sortCodeCompletionResults, [CompletionResult.by_ref, :uint], :void

  # Free the given set of code-completion results.
  #
  # @method dispose_code_complete_results(results)
  # @param [CodeCompleteResults] results
  # @return [nil]
  # @scope class
  #
  attach_function :dispose_code_complete_results, :clang_disposeCodeCompleteResults, [CodeCompleteResults.by_ref], :void

  # Determine the number of diagnostics produced prior to the
  # location where code completion was performed.
  #
  # @method code_complete_get_num_diagnostics(results)
  # @param [CodeCompleteResults] results
  # @return [Integer]
  # @scope class
  #
  attach_function :code_complete_get_num_diagnostics, :clang_codeCompleteGetNumDiagnostics, [CodeCompleteResults.by_ref], :uint

  # Retrieve a diagnostic associated with the given code completion.
  #
  # @method code_complete_get_diagnostic(results, index)
  # @param [CodeCompleteResults] results the code completion results to query.
  # @param [Integer] index the zero-based diagnostic number to retrieve.
  # @return [FFI::Pointer(Diagnostic)] the requested diagnostic. This diagnostic must be freed
  #   via a call to \c clang_disposeDiagnostic().
  # @scope class
  #
  attach_function :code_complete_get_diagnostic, :clang_codeCompleteGetDiagnostic, [CodeCompleteResults.by_ref, :uint], :pointer

  # Determines what compeltions are appropriate for the context
  # the given code completion.
  #
  # @method code_complete_get_contexts(results)
  # @param [CodeCompleteResults] results the code completion results to query
  # @return [Integer] the kinds of completions that are appropriate for use
  #   along with the given code completion results.
  # @scope class
  #
  attach_function :code_complete_get_contexts, :clang_codeCompleteGetContexts, [CodeCompleteResults.by_ref], :ulong_long

  # Returns the cursor kind for the container for the current code
  # completion context. The container is only guaranteed to be set for
  # contexts where a container exists (i.e. member accesses or Objective-C
  # message sends); if there is not a container, this function will return
  # CXCursor_InvalidCode.
  #
  # @method code_complete_get_container_kind(results, is_incomplete)
  # @param [CodeCompleteResults] results the code completion results to query
  # @param [FFI::Pointer(*UInt)] is_incomplete on return, this value will be false if Clang has complete
  #   information about the container. If Clang does not have complete
  #   information, this value will be true.
  # @return [Symbol from `enum_cursor_kind`] the container kind, or CXCursor_InvalidCode if there is not a
  #   container
  # @scope class
  #
  attach_function :code_complete_get_container_kind, :clang_codeCompleteGetContainerKind, [CodeCompleteResults.by_ref, :pointer], :cursor_kind

  # Returns the USR for the container for the current code completion
  # context. If there is not a container for the current context, this
  # function will return the empty string.
  #
  # @method code_complete_get_container_usr(results)
  # @param [CodeCompleteResults] results the code completion results to query
  # @return [String] the USR for the container
  # @scope class
  #
  attach_function :code_complete_get_container_usr, :clang_codeCompleteGetContainerUSR, [CodeCompleteResults.by_ref], String.by_value

  # Returns the currently-entered selector for an Objective-C message
  # send, formatted like "initWithFoo:bar:". Only guaranteed to return a
  # non-empty string for CXCompletionContext_ObjCInstanceMessage and
  # CXCompletionContext_ObjCClassMessage.
  #
  # @method code_complete_get_obj_c_selector(results)
  # @param [CodeCompleteResults] results the code completion results to query
  # @return [String] the selector (or partial selector) that has been entered thus far
  #   for an Objective-C message send.
  # @scope class
  #
  attach_function :code_complete_get_obj_c_selector, :clang_codeCompleteGetObjCSelector, [CodeCompleteResults.by_ref], String.by_value

  # Return a version string, suitable for showing to a user, but not
  #        intended to be parsed (the format is not guaranteed to be stable).
  #
  # @method get_clang_version()
  # @return [String]
  # @scope class
  #
  attach_function :get_clang_version, :clang_getClangVersion, [], String.by_value

  # Enable/disable crash recovery.
  #
  # @method toggle_crash_recovery(is_enabled)
  # @param [Integer] is_enabled Flag to indicate if crash recovery is enabled.  A non-zero
  #          value enables crash recovery, while 0 disables it.
  # @return [nil]
  # @scope class
  #
  attach_function :toggle_crash_recovery, :clang_toggleCrashRecovery, [:uint], :void

  # Visit the set of preprocessor inclusions in a translation unit.
  #   The visitor function is called with the provided data for every included
  #   file.  This does not include headers included by the PCH file (unless one
  #   is inspecting the inclusions in the PCH file itself).
  #
  # @method get_inclusions(tu, visitor, client_data)
  # @param [TranslationUnit] tu
  # @param [Proc(callback_inclusion_visitor)] visitor
  # @param [FFI::Pointer(ClientData)] client_data
  # @return [nil]
  # @scope class
  #
  attach_function :get_inclusions, :clang_getInclusions, [TranslationUnit.by_ref, :inclusion_visitor, :pointer], :void

  # Retrieve a remapping.
  #
  # @method get_remappings(path)
  # @param [String] path the path that contains metadata about remappings.
  # @return [FFI::Pointer(Remapping)] the requested remapping. This remapping must be freed
  #   via a call to \c clang_remap_dispose(). Can return NULL if an error occurred.
  # @scope class
  #
  attach_function :get_remappings, :clang_getRemappings, [:string], :pointer

  # Retrieve a remapping.
  #
  # @method get_remappings_from_file_list(file_paths, num_files)
  # @param [FFI::Pointer(**CharS)] file_paths pointer to an array of file paths containing remapping info.
  # @param [Integer] num_files number of file paths.
  # @return [FFI::Pointer(Remapping)] the requested remapping. This remapping must be freed
  #   via a call to \c clang_remap_dispose(). Can return NULL if an error occurred.
  # @scope class
  #
  attach_function :get_remappings_from_file_list, :clang_getRemappingsFromFileList, [:pointer, :uint], :pointer

  # Determine the number of remappings.
  #
  # @method remap_get_num_files(remapping)
  # @param [FFI::Pointer(Remapping)] remapping
  # @return [Integer]
  # @scope class
  #
  attach_function :remap_get_num_files, :clang_remap_getNumFiles, [:pointer], :uint

  # Get the original and the associated filename from the remapping.
  #
  # @method remap_get_filenames(remapping, index, original, transformed)
  # @param [FFI::Pointer(Remapping)] remapping
  # @param [Integer] index
  # @param [String] original If non-NULL, will be set to the original filename.
  # @param [String] transformed If non-NULL, will be set to the filename that the original
  #   is associated with.
  # @return [nil]
  # @scope class
  #
  attach_function :remap_get_filenames, :clang_remap_getFilenames, [:pointer, :uint, String.by_ref, String.by_ref], :void

  # Dispose the remapping.
  #
  # @method remap_dispose(remapping)
  # @param [FFI::Pointer(Remapping)] remapping
  # @return [nil]
  # @scope class
  #
  attach_function :remap_dispose, :clang_remap_dispose, [:pointer], :void

  # Find references of a declaration in a specific file.
  #
  # @method find_references_in_file(cursor, file, visitor)
  # @param [Cursor] cursor pointing to a declaration or a reference of one.
  # @param [FFI::Pointer(File)] file to search for references.
  # @param [CursorAndRangeVisitor] visitor callback that will receive pairs of CXCursor/CXSourceRange for
  #   each reference found.
  #   The CXSourceRange will point inside the file; if the reference is inside
  #   a macro (and not a macro argument) the CXSourceRange will be invalid.
  # @return [Symbol from `enum_result`] one of the CXResult enumerators.
  # @scope class
  #
  attach_function :find_references_in_file, :clang_findReferencesInFile, [Cursor.by_value, :pointer, CursorAndRangeVisitor.by_value], :result

  # Find #import/#include directives in a specific file.
  #
  # @method find_includes_in_file(tu, file, visitor)
  # @param [TranslationUnit] tu translation unit containing the file to query.
  # @param [FFI::Pointer(File)] file to search for #import/#include directives.
  # @param [CursorAndRangeVisitor] visitor callback that will receive pairs of CXCursor/CXSourceRange for
  #   each directive found.
  # @return [Symbol from `enum_result`] one of the CXResult enumerators.
  # @scope class
  #
  attach_function :find_includes_in_file, :clang_findIncludesInFile, [TranslationUnit.by_ref, :pointer, CursorAndRangeVisitor.by_value], :result

  # (Not documented)
  #
  # @method find_references_in_file_with_block(cursor, file, cursor_and_range_visitor_block)
  # @param [Cursor] cursor
  # @param [FFI::Pointer(File)] file
  # @param [Proc(callback_cursor_and_range_visitor_block)] cursor_and_range_visitor_block
  # @return [Symbol from `enum_result`]
  # @scope class
  #
  attach_function :find_references_in_file_with_block, :clang_findReferencesInFileWithBlock, [Cursor.by_value, :pointer, :cursor_and_range_visitor_block], :result

  # (Not documented)
  #
  # @method find_includes_in_file_with_block(translation_unit, file, cursor_and_range_visitor_block)
  # @param [TranslationUnit] translation_unit
  # @param [FFI::Pointer(File)] file
  # @param [Proc(callback_cursor_and_range_visitor_block)] cursor_and_range_visitor_block
  # @return [Symbol from `enum_result`]
  # @scope class
  #
  attach_function :find_includes_in_file_with_block, :clang_findIncludesInFileWithBlock, [TranslationUnit.by_ref, :pointer, :cursor_and_range_visitor_block], :result

  # (Not documented)
  #
  # @method index_is_entity_obj_c_container_kind(idx_entity_kind)
  # @param [Symbol from `enum_idx_entity_kind`] idx_entity_kind
  # @return [Integer]
  # @scope class
  #
  attach_function :index_is_entity_obj_c_container_kind, :clang_index_isEntityObjCContainerKind, [:idx_entity_kind], :int

  # (Not documented)
  #
  # @method index_get_obj_c_container_decl_info(idx_decl_info)
  # @param [IdxDeclInfo] idx_decl_info
  # @return [IdxObjCContainerDeclInfo]
  # @scope class
  #
  attach_function :index_get_obj_c_container_decl_info, :clang_index_getObjCContainerDeclInfo, [IdxDeclInfo.by_ref], IdxObjCContainerDeclInfo.by_ref

  # (Not documented)
  #
  # @method index_get_obj_c_interface_decl_info(idx_decl_info)
  # @param [IdxDeclInfo] idx_decl_info
  # @return [IdxObjCInterfaceDeclInfo]
  # @scope class
  #
  attach_function :index_get_obj_c_interface_decl_info, :clang_index_getObjCInterfaceDeclInfo, [IdxDeclInfo.by_ref], IdxObjCInterfaceDeclInfo.by_ref

  # (Not documented)
  #
  # @method index_get_obj_c_category_decl_info(idx_decl_info)
  # @param [IdxDeclInfo] idx_decl_info
  # @return [IdxObjCCategoryDeclInfo]
  # @scope class
  #
  attach_function :index_get_obj_c_category_decl_info, :clang_index_getObjCCategoryDeclInfo, [IdxDeclInfo.by_ref], IdxObjCCategoryDeclInfo.by_ref

  # (Not documented)
  #
  # @method index_get_obj_c_protocol_ref_list_info(idx_decl_info)
  # @param [IdxDeclInfo] idx_decl_info
  # @return [IdxObjCProtocolRefListInfo]
  # @scope class
  #
  attach_function :index_get_obj_c_protocol_ref_list_info, :clang_index_getObjCProtocolRefListInfo, [IdxDeclInfo.by_ref], IdxObjCProtocolRefListInfo.by_ref

  # (Not documented)
  #
  # @method index_get_obj_c_property_decl_info(idx_decl_info)
  # @param [IdxDeclInfo] idx_decl_info
  # @return [IdxObjCPropertyDeclInfo]
  # @scope class
  #
  attach_function :index_get_obj_c_property_decl_info, :clang_index_getObjCPropertyDeclInfo, [IdxDeclInfo.by_ref], IdxObjCPropertyDeclInfo.by_ref

  # (Not documented)
  #
  # @method index_get_ib_outlet_collection_attr_info(idx_attr_info)
  # @param [IdxAttrInfo] idx_attr_info
  # @return [IdxIBOutletCollectionAttrInfo]
  # @scope class
  #
  attach_function :index_get_ib_outlet_collection_attr_info, :clang_index_getIBOutletCollectionAttrInfo, [IdxAttrInfo.by_ref], IdxIBOutletCollectionAttrInfo.by_ref

  # (Not documented)
  #
  # @method index_get_cxx_class_decl_info(idx_decl_info)
  # @param [IdxDeclInfo] idx_decl_info
  # @return [IdxCXXClassDeclInfo]
  # @scope class
  #
  attach_function :index_get_cxx_class_decl_info, :clang_index_getCXXClassDeclInfo, [IdxDeclInfo.by_ref], IdxCXXClassDeclInfo.by_ref

  # For retrieving a custom CXIdxClientContainer attached to a
  # container.
  #
  # @method index_get_client_container(idx_container_info)
  # @param [IdxContainerInfo] idx_container_info
  # @return [FFI::Pointer(IdxClientContainer)]
  # @scope class
  #
  attach_function :index_get_client_container, :clang_index_getClientContainer, [IdxContainerInfo.by_ref], :pointer

  # For setting a custom CXIdxClientContainer attached to a
  # container.
  #
  # @method index_set_client_container(idx_container_info, idx_client_container)
  # @param [IdxContainerInfo] idx_container_info
  # @param [FFI::Pointer(IdxClientContainer)] idx_client_container
  # @return [nil]
  # @scope class
  #
  attach_function :index_set_client_container, :clang_index_setClientContainer, [IdxContainerInfo.by_ref, :pointer], :void

  # For retrieving a custom CXIdxClientEntity attached to an entity.
  #
  # @method index_get_client_entity(idx_entity_info)
  # @param [IdxEntityInfo] idx_entity_info
  # @return [FFI::Pointer(IdxClientEntity)]
  # @scope class
  #
  attach_function :index_get_client_entity, :clang_index_getClientEntity, [IdxEntityInfo.by_ref], :pointer

  # For setting a custom CXIdxClientEntity attached to an entity.
  #
  # @method index_set_client_entity(idx_entity_info, idx_client_entity)
  # @param [IdxEntityInfo] idx_entity_info
  # @param [FFI::Pointer(IdxClientEntity)] idx_client_entity
  # @return [nil]
  # @scope class
  #
  attach_function :index_set_client_entity, :clang_index_setClientEntity, [IdxEntityInfo.by_ref, :pointer], :void

  # An indexing action/session, to be applied to one or multiple
  # translation units.
  #
  # @method index_action_create(c_idx)
  # @param [FFI::Pointer(Index)] c_idx The index object with which the index action will be associated.
  # @return [FFI::Pointer(IndexAction)]
  # @scope class
  #
  attach_function :index_action_create, :clang_IndexAction_create, [:pointer], :pointer

  # Destroy the given index action.
  #
  # The index action must not be destroyed until all of the translation units
  # created within that index action have been destroyed.
  #
  # @method index_action_dispose(index_action)
  # @param [FFI::Pointer(IndexAction)] index_action
  # @return [nil]
  # @scope class
  #
  attach_function :index_action_dispose, :clang_IndexAction_dispose, [:pointer], :void

  # Index the given source file and the translation unit corresponding
  # to that file via callbacks implemented through #IndexerCallbacks.
  #
  # @method index_source_file(index_action, client_data, index_callbacks, index_callbacks_size, index_options, source_filename, command_line_args, num_command_line_args, unsaved_files, num_unsaved_files, out_tu, tu_options)
  # @param [FFI::Pointer(IndexAction)] index_action
  # @param [FFI::Pointer(ClientData)] client_data pointer data supplied by the client, which will
  #   be passed to the invoked callbacks.
  # @param [IndexerCallbacks] index_callbacks Pointer to indexing callbacks that the client
  #   implements.
  # @param [Integer] index_callbacks_size Size of #IndexerCallbacks structure that gets
  #   passed in index_callbacks.
  # @param [Integer] index_options A bitmask of options that affects how indexing is
  #   performed. This should be a bitwise OR of the CXIndexOpt_XXX flags.
  # @param [String] source_filename
  # @param [FFI::Pointer(**CharS)] command_line_args
  # @param [Integer] num_command_line_args
  # @param [UnsavedFile] unsaved_files
  # @param [Integer] num_unsaved_files
  # @param [FFI::Pointer(*TranslationUnit)] out_tu (out) pointer to store a CXTranslationUnit that can be reused
  #   after indexing is finished. Set to NULL if you do not require it.
  # @param [Integer] tu_options
  # @return [Integer] If there is a failure from which the there is no recovery, returns
  #   non-zero, otherwise returns 0.
  #
  #   The rest of the parameters are the same as #clang_parseTranslationUnit.
  # @scope class
  #
  attach_function :index_source_file, :clang_indexSourceFile, [:pointer, :pointer, IndexerCallbacks.by_ref, :uint, :uint, :string, :pointer, :int, UnsavedFile.by_ref, :uint, :pointer, :uint], :int

  # Index the given translation unit via callbacks implemented through
  # #IndexerCallbacks.
  #
  # The order of callback invocations is not guaranteed to be the same as
  # when indexing a source file. The high level order will be:
  #
  #   -Preprocessor callbacks invocations
  #   -Declaration/reference callbacks invocations
  #   -Diagnostic callback invocations
  #
  # The parameters are the same as #clang_indexSourceFile.
  #
  # @method index_translation_unit(index_action, client_data, index_callbacks, index_callbacks_size, index_options, translation_unit)
  # @param [FFI::Pointer(IndexAction)] index_action
  # @param [FFI::Pointer(ClientData)] client_data
  # @param [IndexerCallbacks] index_callbacks
  # @param [Integer] index_callbacks_size
  # @param [Integer] index_options
  # @param [TranslationUnit] translation_unit
  # @return [Integer] If there is a failure from which the there is no recovery, returns
  #   non-zero, otherwise returns 0.
  # @scope class
  #
  attach_function :index_translation_unit, :clang_indexTranslationUnit, [:pointer, :pointer, IndexerCallbacks.by_ref, :uint, :uint, TranslationUnit.by_ref], :int

  # Retrieve the CXIdxFile, file, line, column, and offset represented by
  # the given CXIdxLoc.
  #
  # If the location refers into a macro expansion, retrieves the
  # location of the macro expansion and if it refers into a macro argument
  # retrieves the location of the argument.
  #
  # @method index_loc_get_file_location(loc, index_file, file, line, column, offset)
  # @param [IdxLoc] loc
  # @param [FFI::Pointer(*IdxClientFile)] index_file
  # @param [FFI::Pointer(*File)] file
  # @param [FFI::Pointer(*UInt)] line
  # @param [FFI::Pointer(*UInt)] column
  # @param [FFI::Pointer(*UInt)] offset
  # @return [nil]
  # @scope class
  #
  attach_function :index_loc_get_file_location, :clang_indexLoc_getFileLocation, [IdxLoc.by_value, :pointer, :pointer, :pointer, :pointer, :pointer], :void

  # Retrieve the CXSourceLocation represented by the given CXIdxLoc.
  #
  # @method index_loc_get_cx_source_location(loc)
  # @param [IdxLoc] loc
  # @return [SourceLocation]
  # @scope class
  #
  attach_function :index_loc_get_cx_source_location, :clang_indexLoc_getCXSourceLocation, [IdxLoc.by_value], SourceLocation.by_value

end
