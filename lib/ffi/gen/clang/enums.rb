module FFI::Gen::Clang
  extend FFI::Library
  # Describes the availability of a particular entity, which indicates
  # whether the use of this entity will result in a warning or error due to
  # it being deprecated or unavailable.
  #
  # ## Options:
  # :available ::
  #   The entity is available.
  # :deprecated ::
  #   The entity is available, but has been deprecated (and its use is
  #   not recommended).
  # :not_available ::
  #   The entity is not available; any use of it will be an error.
  # :not_accessible ::
  #   The entity is available, but not accessible; any use of it will be
  #   an error.
  #
  # @method `enum_availability_kind`
  # @return [Symbol]
  # @scope class
  #
  enum :availability_kind, [
    :available, 0,
    :deprecated, 1,
    :not_available, 2,
    :not_accessible, 3
  ]

  # (Not documented)
  #
  # ## Options:
  # :none ::
  #   Used to indicate that no special CXIndex options are needed.
  # :thread_background_priority_for_indexing ::
  #   Used to indicate that threads that libclang creates for indexing
  #   purposes should use background priority.
  #
  #   Affects #clang_indexSourceFile, #clang_indexTranslationUnit,
  #   #clang_parseTranslationUnit, #clang_saveTranslationUnit.
  # :thread_background_priority_for_editing ::
  #   Used to indicate that threads that libclang creates for editing
  #   purposes should use background priority.
  #
  #   Affects #clang_reparseTranslationUnit, #clang_codeCompleteAt,
  #   #clang_annotateTokens
  #
  # @method `enum_global_opt_flags`
  # @return [Symbol]
  # @scope class
  #
  enum :global_opt_flags, [
    :none, 0,
    :thread_background_priority_for_indexing, 1,
    :thread_background_priority_for_editing, 2
  ]

  # Describes the severity of a particular diagnostic.
  #
  # ## Options:
  # :ignored ::
  #   A diagnostic that has been suppressed, e.g., by a command-line
  #   option.
  # :note ::
  #   This diagnostic is a note that should be attached to the
  #   previous (non-note) diagnostic.
  # :warning ::
  #   This diagnostic indicates suspicious code that may not be
  #   wrong.
  # :error ::
  #   This diagnostic indicates that the code is ill-formed.
  # :fatal ::
  #   This diagnostic indicates that the code is ill-formed such
  #   that future parser recovery is unlikely to produce useful
  #   results.
  #
  # @method `enum_diagnostic_severity`
  # @return [Symbol]
  # @scope class
  #
  enum :diagnostic_severity, [
    :ignored, 0,
    :note, 1,
    :warning, 2,
    :error, 3,
    :fatal, 4
  ]

  # Describes the kind of error that occurred (if any) in a call to
  # \c clang_loadDiagnostics.
  #
  # ## Options:
  # :none ::
  #   Indicates that no error occurred.
  # :unknown ::
  #   Indicates that an unknown error occurred while attempting to
  #   deserialize diagnostics.
  # :cannot_load ::
  #   Indicates that the file containing the serialized diagnostics
  #   could not be opened.
  # :invalid_file ::
  #   Indicates that the serialized diagnostics file is invalid or
  #   corrupt.
  #
  # @method `enum_load_diag_error`
  # @return [Symbol]
  # @scope class
  #
  enum :load_diag_error, [
    :none, 0,
    :unknown, 1,
    :cannot_load, 2,
    :invalid_file, 3
  ]

  # Options to control the display of diagnostics.
  #
  # The values in this enum are meant to be combined to customize the
  # behavior of \c clang_formatDiagnostic().
  #
  # ## Options:
  # :source_location ::
  #   Display the source-location information where the
  #   diagnostic was located.
  #
  #   When set, diagnostics will be prefixed by the file, line, and
  #   (optionally) column to which the diagnostic refers. For example,
  #
  #   \code
  #   test.c:28: warning: extra tokens at end of #endif directive
  #   \endcode
  #
  #   This option corresponds to the clang flag \c -fshow-source-location.
  # :column ::
  #   If displaying the source-location information of the
  #   diagnostic, also include the column number.
  #
  #   This option corresponds to the clang flag \c -fshow-column.
  # :source_ranges ::
  #   If displaying the source-location information of the
  #   diagnostic, also include information about source ranges in a
  #   machine-parsable format.
  #
  #   This option corresponds to the clang flag
  #   \c -fdiagnostics-print-source-range-info.
  # :option ::
  #   Display the option name associated with this diagnostic, if any.
  #
  #   The option name displayed (e.g., -Wconversion) will be placed in brackets
  #   after the diagnostic text. This option corresponds to the clang flag
  #   \c -fdiagnostics-show-option.
  # :category_id ::
  #   Display the category number associated with this diagnostic, if any.
  #
  #   The category number is displayed within brackets after the diagnostic text.
  #   This option corresponds to the clang flag
  #   \c -fdiagnostics-show-category=id.
  # :category_name ::
  #   Display the category name associated with this diagnostic, if any.
  #
  #   The category name is displayed within brackets after the diagnostic text.
  #   This option corresponds to the clang flag
  #   \c -fdiagnostics-show-category=name.
  #
  # @method `enum_diagnostic_display_options`
  # @return [Symbol]
  # @scope class
  #
  enum :diagnostic_display_options, [
    :source_location, 1,
    :column, 2,
    :source_ranges, 4,
    :option, 8,
    :category_id, 16,
    :category_name, 32
  ]

  # Flags that control the creation of translation units.
  #
  # The enumerators in this enumeration type are meant to be bitwise
  # ORed together to specify which options should be used when
  # constructing the translation unit.
  #
  # ## Options:
  # :none ::
  #   Used to indicate that no special translation-unit options are
  #   needed.
  # :detailed_preprocessing_record ::
  #   Used to indicate that the parser should construct a "detailed"
  #   preprocessing record, including all macro definitions and instantiations.
  #
  #   Constructing a detailed preprocessing record requires more memory
  #   and time to parse, since the information contained in the record
  #   is usually not retained. However, it can be useful for
  #   applications that require more detailed information about the
  #   behavior of the preprocessor.
  # :incomplete ::
  #   Used to indicate that the translation unit is incomplete.
  #
  #   When a translation unit is considered "incomplete", semantic
  #   analysis that is typically performed at the end of the
  #   translation unit will be suppressed. For example, this suppresses
  #   the completion of tentative declarations in C and of
  #   instantiation of implicitly-instantiation function templates in
  #   C++. This option is typically used when parsing a header with the
  #   intent of producing a precompiled header.
  # :precompiled_preamble ::
  #   Used to indicate that the translation unit should be built with an
  #   implicit precompiled header for the preamble.
  #
  #   An implicit precompiled header is used as an optimization when a
  #   particular translation unit is likely to be reparsed many times
  #   when the sources aren't changing that often. In this case, an
  #   implicit precompiled header will be built containing all of the
  #   initial includes at the top of the main file (what we refer to as
  #   the "preamble" of the file). In subsequent parses, if the
  #   preamble or the files in it have not changed, \c
  #   clang_reparseTranslationUnit() will re-use the implicit
  #   precompiled header to improve parsing performance.
  # :cache_completion_results ::
  #   Used to indicate that the translation unit should cache some
  #   code-completion results with each reparse of the source file.
  #
  #   Caching of code-completion results is a performance optimization that
  #   introduces some overhead to reparsing but improves the performance of
  #   code-completion operations.
  # :for_serialization ::
  #   Used to indicate that the translation unit will be serialized with
  #   \c clang_saveTranslationUnit.
  #
  #   This option is typically used when parsing a header with the intent of
  #   producing a precompiled header.
  # :cxx_chained_pch ::
  #   DEPRECATED: Enabled chained precompiled preambles in C++.
  #
  #   Note: this is a *temporary* option that is available only while
  #   we are testing C++ precompiled preamble support. It is deprecated.
  # :skip_function_bodies ::
  #   Used to indicate that function/method bodies should be skipped while
  #   parsing.
  #
  #   This option can be used to search for declarations/definitions while
  #   ignoring the usages.
  # :include_brief_comments_in_code_completion ::
  #   Used to indicate that brief documentation comments should be
  #   included into the set of code completions returned from this translation
  #   unit.
  #
  # @method `enum_translation_unit_flags`
  # @return [Symbol]
  # @scope class
  #
  enum :translation_unit_flags, [
    :none, 0,
    :detailed_preprocessing_record, 1,
    :incomplete, 2,
    :precompiled_preamble, 4,
    :cache_completion_results, 8,
    :for_serialization, 16,
    :cxx_chained_pch, 32,
    :skip_function_bodies, 64,
    :include_brief_comments_in_code_completion, 128
  ]

  # Flags that control how translation units are saved.
  #
  # The enumerators in this enumeration type are meant to be bitwise
  # ORed together to specify which options should be used when
  # saving the translation unit.
  #
  # ## Options:
  # :save_translation_unit_none ::
  #   Used to indicate that no special saving options are needed.
  #
  # @method `enum_save_translation_unit_flags`
  # @return [Symbol]
  # @scope class
  #
  enum :save_translation_unit_flags, [
    :save_translation_unit_none, 0
  ]

  # Describes the kind of error that occurred (if any) in a call to
  # \c clang_saveTranslationUnit().
  #
  # ## Options:
  # :none ::
  #   Indicates that no error occurred while saving a translation unit.
  # :unknown ::
  #   Indicates that an unknown error occurred while attempting to save
  #   the file.
  #
  #   This error typically indicates that file I/O failed when attempting to
  #   write the file.
  # :translation_errors ::
  #   Indicates that errors during translation prevented this attempt
  #   to save the translation unit.
  #
  #   Errors that prevent the translation unit from being saved can be
  #   extracted using \c clang_getNumDiagnostics() and \c clang_getDiagnostic().
  # :invalid_tu ::
  #   Indicates that the translation unit to be saved was somehow
  #   invalid (e.g., NULL).
  #
  # @method `enum_save_error`
  # @return [Symbol]
  # @scope class
  #
  enum :save_error, [
    :none, 0,
    :unknown, 1,
    :translation_errors, 2,
    :invalid_tu, 3
  ]

  # Flags that control the reparsing of translation units.
  #
  # The enumerators in this enumeration type are meant to be bitwise
  # ORed together to specify which options should be used when
  # reparsing the translation unit.
  #
  # ## Options:
  # :reparse_none ::
  #   Used to indicate that no special reparsing options are needed.
  #
  # @method `enum_reparse_flags`
  # @return [Symbol]
  # @scope class
  #
  enum :reparse_flags, [
    :reparse_none, 0
  ]

  # Categorizes how memory is being used by a translation unit.
  #
  # ## Options:
  # :ast ::
  #
  # :identifiers ::
  #
  # :selectors ::
  #
  # :global_completion_results ::
  #
  # :source_manager_content_cache ::
  #
  # :ast_side_tables ::
  #
  # :source_manager_membuffer_malloc ::
  #
  # :source_manager_membuffer_m_map ::
  #
  # :external_ast_source_membuffer_malloc ::
  #
  # :external_ast_source_membuffer_m_map ::
  #
  # :preprocessor ::
  #
  # :preprocessing_record ::
  #
  # :source_manager_data_structures ::
  #
  # :preprocessor_header_search ::
  #
  #
  # @method `enum_tu_resource_usage_kind`
  # @return [Symbol]
  # @scope class
  #
  enum :tu_resource_usage_kind, [
    :ast, 1,
    :identifiers, 2,
    :selectors, 3,
    :global_completion_results, 4,
    :source_manager_content_cache, 5,
    :ast_side_tables, 6,
    :source_manager_membuffer_malloc, 7,
    :source_manager_membuffer_m_map, 8,
    :external_ast_source_membuffer_malloc, 9,
    :external_ast_source_membuffer_m_map, 10,
    :preprocessor, 11,
    :preprocessing_record, 12,
    :source_manager_data_structures, 13,
    :preprocessor_header_search, 14
  ]

  # Describes the kind of entity that a cursor refers to.
  #
  # ## Options:
  # :unexposed_decl ::
  #   A declaration whose specific kind is not exposed via this
  #   interface.
  #
  #   Unexposed declarations have the same operations as any other kind
  #   of declaration; one can extract their location information,
  #   spelling, find their definitions, etc. However, the specific kind
  #   of the declaration is not reported.
  # :struct_decl ::
  #   A C or C++ struct.
  # :union_decl ::
  #   A C or C++ union.
  # :class_decl ::
  #   A C++ class.
  # :enum_decl ::
  #   An enumeration.
  # :field_decl ::
  #   A field (in C) or non-static data member (in C++) in a
  #   struct, union, or C++ class.
  # :enum_constant_decl ::
  #   An enumerator constant.
  # :function_decl ::
  #   A function.
  # :var_decl ::
  #   A variable.
  # :parm_decl ::
  #   A function or method parameter.
  # :obj_c_interface_decl ::
  #   An Objective-C \@interface.
  # :obj_c_category_decl ::
  #   An Objective-C \@interface for a category.
  # :obj_c_protocol_decl ::
  #   An Objective-C \@protocol declaration.
  # :obj_c_property_decl ::
  #   An Objective-C \@property declaration.
  # :obj_c_ivar_decl ::
  #   An Objective-C instance variable.
  # :obj_c_instance_method_decl ::
  #   An Objective-C instance method.
  # :obj_c_class_method_decl ::
  #   An Objective-C class method.
  # :obj_c_implementation_decl ::
  #   An Objective-C \@implementation.
  # :obj_c_category_impl_decl ::
  #   An Objective-C \@implementation for a category.
  # :typedef_decl ::
  #   A typedef
  # :cxx_method ::
  #   A C++ class method.
  # :namespace ::
  #   A C++ namespace.
  # :linkage_spec ::
  #   A linkage specification, e.g. 'extern "C"'.
  # :constructor ::
  #   A C++ constructor.
  # :destructor ::
  #   A C++ destructor.
  # :conversion_function ::
  #   A C++ conversion function.
  # :template_type_parameter ::
  #   A C++ template type parameter.
  # :non_type_template_parameter ::
  #   A C++ non-type template parameter.
  # :template_template_parameter ::
  #   A C++ template template parameter.
  # :function_template ::
  #   A C++ function template.
  # :class_template ::
  #   A C++ class template.
  # :class_template_partial_specialization ::
  #   A C++ class template partial specialization.
  # :namespace_alias ::
  #   A C++ namespace alias declaration.
  # :using_directive ::
  #   A C++ using directive.
  # :using_declaration ::
  #   A C++ using declaration.
  # :type_alias_decl ::
  #   A C++ alias declaration
  # :obj_c_synthesize_decl ::
  #   An Objective-C \@synthesize definition.
  # :obj_c_dynamic_decl ::
  #   An Objective-C \@dynamic definition.
  # :cxx_access_specifier ::
  #   An access specifier.
  # :first_ref ::
  #   References
  # :obj_c_super_class_ref ::
  #   Decl references
  # :obj_c_protocol_ref ::
  #
  # :obj_c_class_ref ::
  #
  # :type_ref ::
  #   A reference to a type declaration.
  #
  #   A type reference occurs anywhere where a type is named but not
  #   declared. For example, given:
  #
  #   \code
  #   typedef unsigned size_type;
  #   size_type size;
  #   \endcode
  #
  #   The typedef is a declaration of size_type (CXCursor_TypedefDecl),
  #   while the type of the variable "size" is referenced. The cursor
  #   referenced by the type of size is the typedef for size_type.
  # :cxx_base_specifier ::
  #
  # :template_ref ::
  #   A reference to a class template, function template, template
  #   template parameter, or class template partial specialization.
  # :namespace_ref ::
  #   A reference to a namespace or namespace alias.
  # :member_ref ::
  #   A reference to a member of a struct, union, or class that occurs in
  #   some non-expression context, e.g., a designated initializer.
  # :label_ref ::
  #   A reference to a labeled statement.
  #
  #   This cursor kind is used to describe the jump to "start_over" in the
  #   goto statement in the following example:
  #
  #   \code
  #     start_over:
  #       ++counter;
  #
  #       goto start_over;
  #   \endcode
  #
  #   A label reference cursor refers to a label statement.
  # :overloaded_decl_ref ::
  #   A reference to a set of overloaded functions or function templates
  #   that has not yet been resolved to a specific function or function template.
  #
  #   An overloaded declaration reference cursor occurs in C++ templates where
  #   a dependent name refers to a function. For example:
  #
  #   \code
  #   template<typename T> void swap(T&, T&);
  #
  #   struct X { ... };
  #   void swap(X&, X&);
  #
  #   template<typename T>
  #   void reverse(T* first, T* last) {
  #     while (first < last - 1) {
  #       swap(*first, *--last);
  #       ++first;
  #     }
  #   }
  #
  #   struct Y { };
  #   void swap(Y&, Y&);
  #   \endcode
  #
  #   Here, the identifier "swap" is associated with an overloaded declaration
  #   reference. In the template definition, "swap" refers to either of the two
  #   "swap" functions declared above, so both results will be available. At
  #   instantiation time, "swap" may also refer to other functions found via
  #   argument-dependent lookup (e.g., the "swap" function at the end of the
  #   example).
  #
  #   The functions \c clang_getNumOverloadedDecls() and
  #   \c clang_getOverloadedDecl() can be used to retrieve the definitions
  #   referenced by this cursor.
  # :variable_ref ::
  #   A reference to a variable that occurs in some non-expression
  #   context, e.g., a C++ lambda capture list.
  # :first_invalid ::
  #   Error conditions
  # :invalid_file ::
  #
  # :no_decl_found ::
  #
  # :not_implemented ::
  #
  # :invalid_code ::
  #
  # :first_expr ::
  #   Expressions
  # :unexposed_expr ::
  #   An expression whose specific kind is not exposed via this
  #   interface.
  #
  #   Unexposed expressions have the same operations as any other kind
  #   of expression; one can extract their location information,
  #   spelling, children, etc. However, the specific kind of the
  #   expression is not reported.
  # :decl_ref_expr ::
  #   An expression that refers to some value declaration, such
  #   as a function, varible, or enumerator.
  # :member_ref_expr ::
  #   An expression that refers to a member of a struct, union,
  #   class, Objective-C class, etc.
  # :call_expr ::
  #   An expression that calls a function.
  # :obj_c_message_expr ::
  #   An expression that sends a message to an Objective-C
  #      object or class.
  # :block_expr ::
  #   An expression that represents a block literal.
  # :integer_literal ::
  #   An integer literal.
  # :floating_literal ::
  #   A floating point number literal.
  # :imaginary_literal ::
  #   An imaginary number literal.
  # :string_literal ::
  #   A string literal.
  # :character_literal ::
  #   A character literal.
  # :paren_expr ::
  #   A parenthesized expression, e.g. "(1)".
  #
  #   This AST node is only formed if full location information is requested.
  # :unary_operator ::
  #   This represents the unary-expression's (except sizeof and
  #   alignof).
  # :array_subscript_expr ::
  #   (C99 6.5.2.1) Array Subscripting.
  # :binary_operator ::
  #   A builtin binary operation expression such as "x + y" or
  #   "x <= y".
  # :compound_assign_operator ::
  #   Compound assignment such as "+=".
  # :conditional_operator ::
  #   The ?: ternary operator.
  # :c_style_cast_expr ::
  #   An explicit cast in C (C99 6.5.4) or a C-style cast in C++
  #   (C++ (expr.cast)), which uses the syntax (Type)expr.
  #
  #   For example: (int)f.
  # :compound_literal_expr ::
  #   (C99 6.5.2.5)
  # :init_list_expr ::
  #   Describes an C or C++ initializer list.
  # :addr_label_expr ::
  #   The GNU address of label extension, representing &&label.
  # :stmt_expr ::
  #   This is the GNU Statement Expression extension: ({int X=4; X;})
  # :generic_selection_expr ::
  #   Represents a C11 generic selection.
  # :gnu_null_expr ::
  #   Implements the GNU __null extension, which is a name for a null
  #   pointer constant that has integral type (e.g., int or long) and is the same
  #   size and alignment as a pointer.
  #
  #   The __null extension is typically only used by system headers, which define
  #   NULL as __null in C++ rather than using 0 (which is an integer that may not
  #   match the size of a pointer).
  # :cxx_static_cast_expr ::
  #   C++'s static_cast<> expression.
  # :cxx_dynamic_cast_expr ::
  #   C++'s dynamic_cast<> expression.
  # :cxx_reinterpret_cast_expr ::
  #   C++'s reinterpret_cast<> expression.
  # :cxx_const_cast_expr ::
  #   C++'s const_cast<> expression.
  # :cxx_functional_cast_expr ::
  #   Represents an explicit C++ type conversion that uses "functional"
  #   notion (C++ (expr.type.conv)).
  #
  #   Example:
  #   \code
  #     x = int(0.5);
  #   \endcode
  # :cxx_typeid_expr ::
  #   A C++ typeid expression (C++ (expr.typeid)).
  # :cxx_bool_literal_expr ::
  #   (C++ 2.13.5) C++ Boolean Literal.
  # :cxx_null_ptr_literal_expr ::
  #   (C++0x 2.14.7) C++ Pointer Literal.
  # :cxx_this_expr ::
  #   Represents the "this" expression in C++
  # :cxx_throw_expr ::
  #   (C++ 15) C++ Throw Expression.
  #
  #   This handles 'throw' and 'throw' assignment-expression. When
  #   assignment-expression isn't present, Op will be null.
  # :cxx_new_expr ::
  #   A new expression for memory allocation and constructor calls, e.g:
  #   "new CXXNewExpr(foo)".
  # :cxx_delete_expr ::
  #   A delete expression for memory deallocation and destructor calls,
  #   e.g. "delete() pArray".
  # :unary_expr ::
  #   A unary expression.
  # :obj_c_string_literal ::
  #   An Objective-C string literal i.e. @"foo".
  # :obj_c_encode_expr ::
  #   An Objective-C \@encode expression.
  # :obj_c_selector_expr ::
  #   An Objective-C \@selector expression.
  # :obj_c_protocol_expr ::
  #   An Objective-C \@protocol expression.
  # :obj_c_bridged_cast_expr ::
  #   An Objective-C "bridged" cast expression, which casts between
  #   Objective-C pointers and C pointers, transferring ownership in the process.
  #
  #   \code
  #     NSString *str = (__bridge_transfer NSString *)CFCreateString();
  #   \endcode
  # :pack_expansion_expr ::
  #   Represents a C++0x pack expansion that produces a sequence of
  #   expressions.
  #
  #   A pack expansion expression contains a pattern (which itself is an
  #   expression) followed by an ellipsis. For example:
  #
  #   \code
  #   template<typename F, typename ...Types>
  #   void forward(F f, Types &&...args) {
  #    f(static_cast<Types&&>(args)...);
  #   }
  #   \endcode
  # :size_of_pack_expr ::
  #   Represents an expression that computes the length of a parameter
  #   pack.
  #
  #   \code
  #   template<typename ...Types>
  #   struct count {
  #     static const unsigned value = sizeof...(Types);
  #   };
  #   \endcode
  # :lambda_expr ::
  #   Represents a C++ lambda expression that produces a local function
  #   object.
  #
  #   \code
  #   void abssort(float *x, unsigned N) {
  #     std::sort(x, x + N,
  #               ()(float a, float b) {
  #                 return std::abs(a) < std::abs(b);
  #               });
  #   }
  #   \endcode
  # :obj_c_bool_literal_expr ::
  #   Objective-c Boolean Literal.
  # :obj_c_self_expr ::
  #   Represents the "self" expression in a ObjC method.
  # :first_stmt ::
  #   Statements
  # :unexposed_stmt ::
  #   A statement whose specific kind is not exposed via this
  #   interface.
  #
  #   Unexposed statements have the same operations as any other kind of
  #   statement; one can extract their location information, spelling,
  #   children, etc. However, the specific kind of the statement is not
  #   reported.
  # :label_stmt ::
  #   A labelled statement in a function.
  #
  #   This cursor kind is used to describe the "start_over:" label statement in
  #   the following example:
  #
  #   \code
  #     start_over:
  #       ++counter;
  #   \endcode
  # :compound_stmt ::
  #   A group of statements like { stmt stmt }.
  #
  #   This cursor kind is used to describe compound statements, e.g. function
  #   bodies.
  # :case_stmt ::
  #   A case statement.
  # :default_stmt ::
  #   A default statement.
  # :if_stmt ::
  #   An if statement
  # :switch_stmt ::
  #   A switch statement.
  # :while_stmt ::
  #   A while statement.
  # :do_stmt ::
  #   A do statement.
  # :for_stmt ::
  #   A for statement.
  # :goto_stmt ::
  #   A goto statement.
  # :indirect_goto_stmt ::
  #   An indirect goto statement.
  # :continue_stmt ::
  #   A continue statement.
  # :break_stmt ::
  #   A break statement.
  # :return_stmt ::
  #   A return statement.
  # :gcc_asm_stmt ::
  #   A GCC inline assembly statement extension.
  # :obj_c_at_try_stmt ::
  #   Objective-C's overall \@try-\@catch-\@finally statement.
  # :obj_c_at_catch_stmt ::
  #   Objective-C's \@catch statement.
  # :obj_c_at_finally_stmt ::
  #   Objective-C's \@finally statement.
  # :obj_c_at_throw_stmt ::
  #   Objective-C's \@throw statement.
  # :obj_c_at_synchronized_stmt ::
  #   Objective-C's \@synchronized statement.
  # :obj_c_autorelease_pool_stmt ::
  #   Objective-C's autorelease pool statement.
  # :obj_c_for_collection_stmt ::
  #   Objective-C's collection statement.
  # :cxx_catch_stmt ::
  #   C++'s catch statement.
  # :cxx_try_stmt ::
  #   C++'s try statement.
  # :cxx_for_range_stmt ::
  #   C++'s for (* : *) statement.
  # :seh_try_stmt ::
  #   Windows Structured Exception Handling's try statement.
  # :seh_except_stmt ::
  #   Windows Structured Exception Handling's except statement.
  # :seh_finally_stmt ::
  #   Windows Structured Exception Handling's finally statement.
  # :ms_asm_stmt ::
  #   A MS inline assembly statement extension.
  # :null_stmt ::
  #   The null satement ";": C99 6.8.3p3.
  #
  #   This cursor kind is used to describe the null statement.
  # :decl_stmt ::
  #   Adaptor class for mixing declarations with statements and
  #   expressions.
  # :omp_parallel_directive ::
  #   OpenMP parallel directive.
  # :translation_unit ::
  #   Cursor that represents the translation unit itself.
  #
  #   The translation unit cursor exists primarily to act as the root
  #   cursor for traversing the contents of a translation unit.
  # :first_attr ::
  #   Attributes
  # :unexposed_attr ::
  #   An attribute whose specific kind is not exposed via this
  #   interface.
  # :ib_action_attr ::
  #
  # :ib_outlet_attr ::
  #
  # :ib_outlet_collection_attr ::
  #
  # :cxx_final_attr ::
  #
  # :cxx_override_attr ::
  #
  # :annotate_attr ::
  #
  # :asm_label_attr ::
  #
  # :packed_attr ::
  #
  # :preprocessing_directive ::
  #   Preprocessing
  # :macro_definition ::
  #
  # :macro_expansion ::
  #
  # :inclusion_directive ::
  #
  # :module_import_decl ::
  #   A module import declaration.
  #
  # @method `enum_cursor_kind`
  # @return [Symbol]
  # @scope class
  #
  enum :cursor_kind, [
    :unexposed_decl, 1,
    :struct_decl, 2,
    :union_decl, 3,
    :class_decl, 4,
    :enum_decl, 5,
    :field_decl, 6,
    :enum_constant_decl, 7,
    :function_decl, 8,
    :var_decl, 9,
    :parm_decl, 10,
    :obj_c_interface_decl, 11,
    :obj_c_category_decl, 12,
    :obj_c_protocol_decl, 13,
    :obj_c_property_decl, 14,
    :obj_c_ivar_decl, 15,
    :obj_c_instance_method_decl, 16,
    :obj_c_class_method_decl, 17,
    :obj_c_implementation_decl, 18,
    :obj_c_category_impl_decl, 19,
    :typedef_decl, 20,
    :cxx_method, 21,
    :namespace, 22,
    :linkage_spec, 23,
    :constructor, 24,
    :destructor, 25,
    :conversion_function, 26,
    :template_type_parameter, 27,
    :non_type_template_parameter, 28,
    :template_template_parameter, 29,
    :function_template, 30,
    :class_template, 31,
    :class_template_partial_specialization, 32,
    :namespace_alias, 33,
    :using_directive, 34,
    :using_declaration, 35,
    :type_alias_decl, 36,
    :obj_c_synthesize_decl, 37,
    :obj_c_dynamic_decl, 38,
    :cxx_access_specifier, 39,
    :first_ref, 40,
    :obj_c_super_class_ref, 40,
    :obj_c_protocol_ref, 41,
    :obj_c_class_ref, 42,
    :type_ref, 43,
    :cxx_base_specifier, 44,
    :template_ref, 45,
    :namespace_ref, 46,
    :member_ref, 47,
    :label_ref, 48,
    :overloaded_decl_ref, 49,
    :variable_ref, 50,
    :first_invalid, 70,
    :invalid_file, 70,
    :no_decl_found, 71,
    :not_implemented, 72,
    :invalid_code, 73,
    :first_expr, 100,
    :unexposed_expr, 100,
    :decl_ref_expr, 101,
    :member_ref_expr, 102,
    :call_expr, 103,
    :obj_c_message_expr, 104,
    :block_expr, 105,
    :integer_literal, 106,
    :floating_literal, 107,
    :imaginary_literal, 108,
    :string_literal, 109,
    :character_literal, 110,
    :paren_expr, 111,
    :unary_operator, 112,
    :array_subscript_expr, 113,
    :binary_operator, 114,
    :compound_assign_operator, 115,
    :conditional_operator, 116,
    :c_style_cast_expr, 117,
    :compound_literal_expr, 118,
    :init_list_expr, 119,
    :addr_label_expr, 120,
    :stmt_expr, 121,
    :generic_selection_expr, 122,
    :gnu_null_expr, 123,
    :cxx_static_cast_expr, 124,
    :cxx_dynamic_cast_expr, 125,
    :cxx_reinterpret_cast_expr, 126,
    :cxx_const_cast_expr, 127,
    :cxx_functional_cast_expr, 128,
    :cxx_typeid_expr, 129,
    :cxx_bool_literal_expr, 130,
    :cxx_null_ptr_literal_expr, 131,
    :cxx_this_expr, 132,
    :cxx_throw_expr, 133,
    :cxx_new_expr, 134,
    :cxx_delete_expr, 135,
    :unary_expr, 136,
    :obj_c_string_literal, 137,
    :obj_c_encode_expr, 138,
    :obj_c_selector_expr, 139,
    :obj_c_protocol_expr, 140,
    :obj_c_bridged_cast_expr, 141,
    :pack_expansion_expr, 142,
    :size_of_pack_expr, 143,
    :lambda_expr, 144,
    :obj_c_bool_literal_expr, 145,
    :obj_c_self_expr, 146,
    :first_stmt, 200,
    :unexposed_stmt, 200,
    :label_stmt, 201,
    :compound_stmt, 202,
    :case_stmt, 203,
    :default_stmt, 204,
    :if_stmt, 205,
    :switch_stmt, 206,
    :while_stmt, 207,
    :do_stmt, 208,
    :for_stmt, 209,
    :goto_stmt, 210,
    :indirect_goto_stmt, 211,
    :continue_stmt, 212,
    :break_stmt, 213,
    :return_stmt, 214,
    :gcc_asm_stmt, 215,
    :obj_c_at_try_stmt, 216,
    :obj_c_at_catch_stmt, 217,
    :obj_c_at_finally_stmt, 218,
    :obj_c_at_throw_stmt, 219,
    :obj_c_at_synchronized_stmt, 220,
    :obj_c_autorelease_pool_stmt, 221,
    :obj_c_for_collection_stmt, 222,
    :cxx_catch_stmt, 223,
    :cxx_try_stmt, 224,
    :cxx_for_range_stmt, 225,
    :seh_try_stmt, 226,
    :seh_except_stmt, 227,
    :seh_finally_stmt, 228,
    :ms_asm_stmt, 229,
    :null_stmt, 230,
    :decl_stmt, 231,
    :omp_parallel_directive, 232,
    :translation_unit, 300,
    :first_attr, 400,
    :unexposed_attr, 400,
    :ib_action_attr, 401,
    :ib_outlet_attr, 402,
    :ib_outlet_collection_attr, 403,
    :cxx_final_attr, 404,
    :cxx_override_attr, 405,
    :annotate_attr, 406,
    :asm_label_attr, 407,
    :packed_attr, 408,
    :preprocessing_directive, 500,
    :macro_definition, 501,
    :macro_expansion, 502,
    :inclusion_directive, 503,
    :module_import_decl, 600
  ]

  # Describe the linkage of the entity referred to by a cursor.
  #
  # ## Options:
  # :invalid ::
  #   This value indicates that no linkage information is available
  #   for a provided CXCursor.
  # :no_linkage ::
  #   This is the linkage for variables, parameters, and so on that
  #    have automatic storage.  This covers normal (non-extern) local variables.
  # :internal ::
  #   This is the linkage for static variables and static functions.
  # :unique_external ::
  #   This is the linkage for entities with external linkage that live
  #   in C++ anonymous namespaces.
  # :external ::
  #   This is the linkage for entities with true, external linkage.
  #
  # @method `enum_linkage_kind`
  # @return [Symbol]
  # @scope class
  #
  enum :linkage_kind, [
    :invalid, 0,
    :no_linkage, 1,
    :internal, 2,
    :unique_external, 3,
    :external, 4
  ]

  # Describe the "language" of the entity referred to by a cursor.
  #
  # ## Options:
  # :invalid ::
  #
  # :c ::
  #
  # :obj_c ::
  #
  # :c_plus_plus ::
  #
  #
  # @method `enum_language_kind`
  # @return [Symbol]
  # @scope class
  #
  enum :language_kind, [
    :invalid, 0,
    :c, 1,
    :obj_c, 2,
    :c_plus_plus, 3
  ]

  # Describes the kind of type
  #
  # ## Options:
  # :invalid ::
  #   Reprents an invalid type (e.g., where no type is available).
  # :unexposed ::
  #   A type whose specific kind is not exposed via this
  #   interface.
  # :void ::
  #   Builtin types
  # :bool ::
  #
  # :char_u ::
  #
  # :u_char ::
  #
  # :char16 ::
  #
  # :char32 ::
  #
  # :u_short ::
  #
  # :u_int ::
  #
  # :u_long ::
  #
  # :u_long_long ::
  #
  # :u_int128 ::
  #
  # :char_s ::
  #
  # :s_char ::
  #
  # :w_char ::
  #
  # :short ::
  #
  # :int ::
  #
  # :long ::
  #
  # :long_long ::
  #
  # :int128 ::
  #
  # :float ::
  #
  # :double ::
  #
  # :long_double ::
  #
  # :null_ptr ::
  #
  # :overload ::
  #
  # :dependent ::
  #
  # :obj_c_id ::
  #
  # :obj_c_class ::
  #
  # :obj_c_sel ::
  #
  # :complex ::
  #
  # :pointer ::
  #
  # :block_pointer ::
  #
  # :l_value_reference ::
  #
  # :r_value_reference ::
  #
  # :record ::
  #
  # :enum ::
  #
  # :typedef ::
  #
  # :obj_c_interface ::
  #
  # :obj_c_object_pointer ::
  #
  # :function_no_proto ::
  #
  # :function_proto ::
  #
  # :constant_array ::
  #
  # :vector ::
  #
  # :incomplete_array ::
  #
  # :variable_array ::
  #
  # :dependent_sized_array ::
  #
  # :member_pointer ::
  #
  #
  # @method `enum_type_kind`
  # @return [Symbol]
  # @scope class
  #
  enum :type_kind, [
    :invalid, 0,
    :unexposed, 1,
    :void, 2,
    :bool, 3,
    :char_u, 4,
    :u_char, 5,
    :char16, 6,
    :char32, 7,
    :u_short, 8,
    :u_int, 9,
    :u_long, 10,
    :u_long_long, 11,
    :u_int128, 12,
    :char_s, 13,
    :s_char, 14,
    :w_char, 15,
    :short, 16,
    :int, 17,
    :long, 18,
    :long_long, 19,
    :int128, 20,
    :float, 21,
    :double, 22,
    :long_double, 23,
    :null_ptr, 24,
    :overload, 25,
    :dependent, 26,
    :obj_c_id, 27,
    :obj_c_class, 28,
    :obj_c_sel, 29,
    :complex, 100,
    :pointer, 101,
    :block_pointer, 102,
    :l_value_reference, 103,
    :r_value_reference, 104,
    :record, 105,
    :enum, 106,
    :typedef, 107,
    :obj_c_interface, 108,
    :obj_c_object_pointer, 109,
    :function_no_proto, 110,
    :function_proto, 111,
    :constant_array, 112,
    :vector, 113,
    :incomplete_array, 114,
    :variable_array, 115,
    :dependent_sized_array, 116,
    :member_pointer, 117
  ]

  # List the possible error codes for \c clang_Type_getSizeOf,
  #   \c clang_Type_getAlignOf, \c clang_Type_getOffsetOf and
  #   \c clang_Cursor_getOffsetOf.
  #
  # A value of this enumeration type can be returned if the target type is not
  # a valid argument to sizeof, alignof or offsetof.
  #
  # ## Options:
  # :invalid ::
  #   Type is of kind CXType_Invalid.
  # :incomplete ::
  #   The type is an incomplete Type.
  # :dependent ::
  #   The type is a dependent Type.
  # :not_constant_size ::
  #   The type is not a constant size type.
  # :invalid_field_name ::
  #   The Field name is not valid for this record.
  #
  # @method `enum_type_layout_error`
  # @return [Symbol]
  # @scope class
  #
  enum :type_layout_error, [
    :invalid, -1,
    :incomplete, -2,
    :dependent, -3,
    :not_constant_size, -4,
    :invalid_field_name, -5
  ]

  # (Not documented)
  #
  # ## Options:
  # :none ::
  #   No ref-qualifier was provided.
  # :l_value ::
  #   An lvalue ref-qualifier was provided (\c &).
  # :r_value ::
  #   An rvalue ref-qualifier was provided (\c &&).
  #
  # @method `enum_ref_qualifier_kind`
  # @return [Symbol]
  # @scope class
  #
  enum :ref_qualifier_kind, [
    :none, 0,
    :l_value, 1,
    :r_value, 2
  ]

  # Represents the C++ access control level to a base class for a
  # cursor with kind CX_CXXBaseSpecifier.
  #
  # ## Options:
  # :invalid_access_specifier ::
  #
  # :public ::
  #
  # :protected ::
  #
  # :private ::
  #
  #
  # @method `enum_cxx_access_specifier`
  # @return [Symbol]
  # @scope class
  #
  enum :cxx_access_specifier, [
    :invalid_access_specifier, 0,
    :public, 1,
    :protected, 2,
    :private, 3
  ]

  # Describes how the traversal of the children of a particular
  # cursor should proceed after visiting a particular child cursor.
  #
  # A value of this enumeration type should be returned by each
  # \c CXCursorVisitor to indicate how clang_visitChildren() proceed.
  #
  # ## Options:
  # :break_ ::
  #   Terminates the cursor traversal.
  # :continue ::
  #   Continues the cursor traversal with the next sibling of
  #   the cursor just visited, without visiting its children.
  # :recurse ::
  #   Recursively traverse the children of this cursor, using
  #   the same visitor and client data.
  #
  # @method `enum_child_visit_result`
  # @return [Symbol]
  # @scope class
  #
  enum :child_visit_result, [
    :break_, 0,
    :continue, 1,
    :recurse, 2
  ]

  # Property attributes for a \c CXCursor_ObjCPropertyDecl.
  #
  # ## Options:
  # :noattr ::
  #
  # :readonly ::
  #
  # :getter ::
  #
  # :assign ::
  #
  # :readwrite ::
  #
  # :retain ::
  #
  # :copy ::
  #
  # :nonatomic ::
  #
  # :setter ::
  #
  # :atomic ::
  #
  # :weak ::
  #
  # :strong ::
  #
  # :unsafe_unretained ::
  #
  #
  # @method `enum_obj_c_property_attr_kind`
  # @return [Symbol]
  # @scope class
  #
  enum :obj_c_property_attr_kind, [
    :noattr, 0,
    :readonly, 1,
    :getter, 2,
    :assign, 4,
    :readwrite, 8,
    :retain, 16,
    :copy, 32,
    :nonatomic, 64,
    :setter, 128,
    :atomic, 256,
    :weak, 512,
    :strong, 1024,
    :unsafe_unretained, 2048
  ]

  # 'Qualifiers' written next to the return and parameter types in
  # ObjC method declarations.
  #
  # ## Options:
  # :none ::
  #
  # :in_ ::
  #
  # :inout ::
  #
  # :out ::
  #
  # :bycopy ::
  #
  # :byref ::
  #
  # :oneway ::
  #
  #
  # @method `enum_obj_c_decl_qualifier_kind`
  # @return [Symbol]
  # @scope class
  #
  enum :obj_c_decl_qualifier_kind, [
    :none, 0,
    :in_, 1,
    :inout, 2,
    :out, 4,
    :bycopy, 8,
    :byref, 16,
    :oneway, 32
  ]

  # Describes the type of the comment AST node (\c CXComment).  A comment
  # node can be considered block content (e. g., paragraph), inline content
  # (plain text) or neither (the root AST node).
  #
  # ## Options:
  # :null ::
  #   Null comment.  No AST node is constructed at the requested location
  #   because there is no text or a syntax error.
  # :text ::
  #   Plain text.  Inline content.
  # :inline_command ::
  #   A command with word-like arguments that is considered inline content.
  #
  #   For example: \\c command.
  # :html_start_tag ::
  #   HTML start tag with attributes (name-value pairs).  Considered
  #   inline content.
  #
  #   For example:
  #   \verbatim
  #   <br> <br /> <a href="http://example.org/">
  #   \endverbatim
  # :html_end_tag ::
  #   HTML end tag.  Considered inline content.
  #
  #   For example:
  #   \verbatim
  #   </a>
  #   \endverbatim
  # :paragraph ::
  #   A paragraph, contains inline comment.  The paragraph itself is
  #   block content.
  # :block_command ::
  #   A command that has zero or more word-like arguments (number of
  #   word-like arguments depends on command name) and a paragraph as an
  #   argument.  Block command is block content.
  #
  #   Paragraph argument is also a child of the block command.
  #
  #   For example: \has 0 word-like arguments and a paragraph argument.
  #
  #   AST nodes of special kinds that parser knows about (e. g., \\param
  #   command) have their own node kinds.
  # :param_command ::
  #   A \\param or \\arg command that describes the function parameter
  #   (name, passing direction, description).
  #
  #   For example: \\param (in) ParamName description.
  # :t_param_command ::
  #   A \\tparam command that describes a template parameter (name and
  #   description).
  #
  #   For example: \\tparam T description.
  # :verbatim_block_command ::
  #   A verbatim block command (e. g., preformatted code).  Verbatim
  #   block has an opening and a closing command and contains multiple lines of
  #   text (\c CXComment_VerbatimBlockLine child nodes).
  #
  #   For example:
  #   \\verbatim
  #   aaa
  #   \\endverbatim
  # :verbatim_block_line ::
  #   A line of text that is contained within a
  #   CXComment_VerbatimBlockCommand node.
  # :verbatim_line ::
  #   A verbatim line command.  Verbatim line has an opening command,
  #   a single line of text (up to the newline after the opening command) and
  #   has no closing command.
  # :full_comment ::
  #   A full comment attached to a declaration, contains block content.
  #
  # @method `enum_comment_kind`
  # @return [Symbol]
  # @scope class
  #
  enum :comment_kind, [
    :null, 0,
    :text, 1,
    :inline_command, 2,
    :html_start_tag, 3,
    :html_end_tag, 4,
    :paragraph, 5,
    :block_command, 6,
    :param_command, 7,
    :t_param_command, 8,
    :verbatim_block_command, 9,
    :verbatim_block_line, 10,
    :verbatim_line, 11,
    :full_comment, 12
  ]

  # Describes parameter passing direction for \\param or \\arg command.
  #
  # ## Options:
  # :in_ ::
  #   The parameter is an input parameter.
  # :out ::
  #   The parameter is an output parameter.
  # :in_out ::
  #   The parameter is an input and output parameter.
  #
  # @method `enum_comment_param_pass_direction`
  # @return [Symbol]
  # @scope class
  #
  enum :comment_param_pass_direction, [
    :in_, 0,
    :out, 1,
    :in_out, 2
  ]

  # (Not documented)
  #
  # ## Options:
  # :range_want_qualifier ::
  #   Include the nested-name-specifier, e.g. Foo:: in x.Foo::y, in the
  #   range.
  # :range_want_template_args ::
  #   Include the explicit template arguments, e.g. \<int> in x.f<int>,
  #   in the range.
  # :range_want_single_piece ::
  #   If the name is non-contiguous, return the full spanning range.
  #
  #   Non-contiguous names occur in Objective-C when a selector with two or more
  #   parameters is used, or in C++ when using an operator:
  #   \code
  #   (object doSomething:here withValue:there); // ObjC
  #   return some_vector(1); // C++
  #   \endcode
  #
  # @method `enum_name_ref_flags`
  # @return [Symbol]
  # @scope class
  #
  enum :name_ref_flags, [
    :range_want_qualifier, 1,
    :range_want_template_args, 2,
    :range_want_single_piece, 4
  ]

  # Describes a single piece of text within a code-completion string.
  #
  # Each "chunk" within a code-completion string (\c CXCompletionString) is
  # either a piece of text with a specific "kind" that describes how that text
  # should be interpreted by the client or is another completion string.
  #
  # ## Options:
  # :optional ::
  #   A code-completion string that describes "optional" text that
  #   could be a part of the template (but is not required).
  #
  #   The Optional chunk is the only kind of chunk that has a code-completion
  #   string for its representation, which is accessible via
  #   \c clang_getCompletionChunkCompletionString(). The code-completion string
  #   describes an additional part of the template that is completely optional.
  #   For example, optional chunks can be used to describe the placeholders for
  #   arguments that match up with defaulted function parameters, e.g. given:
  #
  #   \code
  #   void f(int x, float y = 3.14, double z = 2.71828);
  #   \endcode
  #
  #   The code-completion string for this function would contain:
  #     - a TypedText chunk for "f".
  #     - a LeftParen chunk for "(".
  #     - a Placeholder chunk for "int x"
  #     - an Optional chunk containing the remaining defaulted arguments, e.g.,
  #         - a Comma chunk for ","
  #         - a Placeholder chunk for "float y"
  #         - an Optional chunk containing the last defaulted argument:
  #             - a Comma chunk for ","
  #             - a Placeholder chunk for "double z"
  #     - a RightParen chunk for ")"
  #
  #   There are many ways to handle Optional chunks. Two simple approaches are:
  #     - Completely ignore optional chunks, in which case the template for the
  #       function "f" would only include the first parameter ("int x").
  #     - Fully expand all optional chunks, in which case the template for the
  #       function "f" would have all of the parameters.
  # :typed_text ::
  #   Text that a user would be expected to type to get this
  #   code-completion result.
  #
  #   There will be exactly one "typed text" chunk in a semantic string, which
  #   will typically provide the spelling of a keyword or the name of a
  #   declaration that could be used at the current code point. Clients are
  #   expected to filter the code-completion results based on the text in this
  #   chunk.
  # :text ::
  #   Text that should be inserted as part of a code-completion result.
  #
  #   A "text" chunk represents text that is part of the template to be
  #   inserted into user code should this particular code-completion result
  #   be selected.
  # :placeholder ::
  #   Placeholder text that should be replaced by the user.
  #
  #   A "placeholder" chunk marks a place where the user should insert text
  #   into the code-completion template. For example, placeholders might mark
  #   the function parameters for a function declaration, to indicate that the
  #   user should provide arguments for each of those parameters. The actual
  #   text in a placeholder is a suggestion for the text to display before
  #   the user replaces the placeholder with real code.
  # :informative ::
  #   Informative text that should be displayed but never inserted as
  #   part of the template.
  #
  #   An "informative" chunk contains annotations that can be displayed to
  #   help the user decide whether a particular code-completion result is the
  #   right option, but which is not part of the actual template to be inserted
  #   by code completion.
  # :current_parameter ::
  #   Text that describes the current parameter when code-completion is
  #   referring to function call, message send, or template specialization.
  #
  #   A "current parameter" chunk occurs when code-completion is providing
  #   information about a parameter corresponding to the argument at the
  #   code-completion point. For example, given a function
  #
  #   \code
  #   int add(int x, int y);
  #   \endcode
  #
  #   and the source code \c add(, where the code-completion point is after the
  #   "(", the code-completion string will contain a "current parameter" chunk
  #   for "int x", indicating that the current argument will initialize that
  #   parameter. After typing further, to \c add(17, (where the code-completion
  #   point is after the ","), the code-completion string will contain a
  #   "current paremeter" chunk to "int y".
  # :left_paren ::
  #   A left parenthesis ('('), used to initiate a function call or
  #   signal the beginning of a function parameter list.
  # :right_paren ::
  #   A right parenthesis (')'), used to finish a function call or
  #   signal the end of a function parameter list.
  # :left_bracket ::
  #   A left bracket ('(').
  # :right_bracket ::
  #   A right bracket (')').
  # :left_brace ::
  #   A left brace ('{').
  # :right_brace ::
  #   A right brace ('}').
  # :left_angle ::
  #   A left angle bracket ('<').
  # :right_angle ::
  #   A right angle bracket ('>').
  # :comma ::
  #   A comma separator (',').
  # :result_type ::
  #   Text that specifies the result type of a given result.
  #
  #   This special kind of informative chunk is not meant to be inserted into
  #   the text buffer. Rather, it is meant to illustrate the type that an
  #   expression using the given completion string would have.
  # :colon ::
  #   A colon (':').
  # :semi_colon ::
  #   A semicolon (';').
  # :equal ::
  #   An '=' sign.
  # :horizontal_space ::
  #   Horizontal space (' ').
  # :vertical_space ::
  #   Vertical space ('\n'), after which it is generally a good idea to
  #   perform indentation.
  #
  # @method `enum_completion_chunk_kind`
  # @return [Symbol]
  # @scope class
  #
  enum :completion_chunk_kind, [
    :optional, 0,
    :typed_text, 1,
    :text, 2,
    :placeholder, 3,
    :informative, 4,
    :current_parameter, 5,
    :left_paren, 6,
    :right_paren, 7,
    :left_bracket, 8,
    :right_bracket, 9,
    :left_brace, 10,
    :right_brace, 11,
    :left_angle, 12,
    :right_angle, 13,
    :comma, 14,
    :result_type, 15,
    :colon, 16,
    :semi_colon, 17,
    :equal, 18,
    :horizontal_space, 19,
    :vertical_space, 20
  ]

  # Flags that can be passed to \c clang_codeCompleteAt() to
  # modify its behavior.
  #
  # The enumerators in this enumeration can be bitwise-OR'd together to
  # provide multiple options to \c clang_codeCompleteAt().
  #
  # ## Options:
  # :include_macros ::
  #   Whether to include macros within the set of code
  #   completions returned.
  # :include_code_patterns ::
  #   Whether to include code patterns for language constructs
  #   within the set of code completions, e.g., for loops.
  # :include_brief_comments ::
  #   Whether to include brief documentation within the set of code
  #   completions returned.
  #
  # @method `enum_code_complete_flags`
  # @return [Symbol]
  # @scope class
  #
  enum :code_complete_flags, [
    :include_macros, 1,
    :include_code_patterns, 2,
    :include_brief_comments, 4
  ]

  # \defgroup CINDEX_HIGH Higher level API functions
  #
  # @{
  #
  # ## Options:
  # :visit_break ::
  #
  # :visit_continue ::
  #
  #
  # @method `enum_visitor_result`
  # @return [Symbol]
  # @scope class
  #
  enum :visitor_result, [
    :visit_break, 0,
    :visit_continue, 1
  ]

  # (Not documented)
  #
  # ## Options:
  # :unexposed ::
  #
  # :typedef ::
  #
  # :function ::
  #
  # :variable ::
  #
  # :field ::
  #
  # :enum_constant ::
  #
  # :obj_c_class ::
  #
  # :obj_c_protocol ::
  #
  # :obj_c_category ::
  #
  # :obj_c_instance_method ::
  #
  # :obj_c_class_method ::
  #
  # :obj_c_property ::
  #
  # :obj_c_ivar ::
  #
  # :enum ::
  #
  # :struct ::
  #
  # :union ::
  #
  # :cxx_class ::
  #
  # :cxx_namespace ::
  #
  # :cxx_namespace_alias ::
  #
  # :cxx_static_variable ::
  #
  # :cxx_static_method ::
  #
  # :cxx_instance_method ::
  #
  # :cxx_constructor ::
  #
  # :cxx_destructor ::
  #
  # :cxx_conversion_function ::
  #
  # :cxx_type_alias ::
  #
  # :cxx_interface ::
  #
  #
  # @method `enum_idx_entity_kind`
  # @return [Symbol]
  # @scope class
  #
  enum :idx_entity_kind, [
    :unexposed, 0,
    :typedef, 1,
    :function, 2,
    :variable, 3,
    :field, 4,
    :enum_constant, 5,
    :obj_c_class, 6,
    :obj_c_protocol, 7,
    :obj_c_category, 8,
    :obj_c_instance_method, 9,
    :obj_c_class_method, 10,
    :obj_c_property, 11,
    :obj_c_ivar, 12,
    :enum, 13,
    :struct, 14,
    :union, 15,
    :cxx_class, 16,
    :cxx_namespace, 17,
    :cxx_namespace_alias, 18,
    :cxx_static_variable, 19,
    :cxx_static_method, 20,
    :cxx_instance_method, 21,
    :cxx_constructor, 22,
    :cxx_destructor, 23,
    :cxx_conversion_function, 24,
    :cxx_type_alias, 25,
    :cxx_interface, 26
  ]

  # Extra C++ template information for an entity. This can apply to:
  # CXIdxEntity_Function
  # CXIdxEntity_CXXClass
  # CXIdxEntity_CXXStaticMethod
  # CXIdxEntity_CXXInstanceMethod
  # CXIdxEntity_CXXConstructor
  # CXIdxEntity_CXXConversionFunction
  # CXIdxEntity_CXXTypeAlias
  #
  # ## Options:
  # :non_template ::
  #
  # :template ::
  #
  # :template_partial_specialization ::
  #
  # :template_specialization ::
  #
  #
  # @method `enum_idx_entity_cxx_template_kind`
  # @return [Symbol]
  # @scope class
  #
  enum :idx_entity_cxx_template_kind, [
    :non_template, 0,
    :template, 1,
    :template_partial_specialization, 2,
    :template_specialization, 3
  ]

  # (Not documented)
  #
  # ## Options:
  # :idx_decl_flag_skipped ::
  #
  #
  # @method `enum_idx_decl_info_flags`
  # @return [Symbol]
  # @scope class
  #
  enum :idx_decl_info_flags, [
    :idx_decl_flag_skipped, 1
  ]

  # Data for IndexerCallbacks#indexEntityReference.
  #
  # ## Options:
  # :direct ::
  #   The entity is referenced directly in user's code.
  # :implicit ::
  #   An implicit reference, e.g. a reference of an ObjC method via the
  #   dot syntax.
  #
  # @method `enum_idx_entity_ref_kind`
  # @return [Symbol]
  # @scope class
  #
  enum :idx_entity_ref_kind, [
    :direct, 1,
    :implicit, 2
  ]

  # (Not documented)
  #
  # ## Options:
  # :none ::
  #   Used to indicate that no special indexing options are needed.
  # :suppress_redundant_refs ::
  #   Used to indicate that IndexerCallbacks#indexEntityReference should
  #   be invoked for only one reference of an entity per source file that does
  #   not also include a declaration/definition of the entity.
  # :index_function_local_symbols ::
  #   Function-local symbols should be indexed. If this is not set
  #   function-local symbols will be ignored.
  # :index_implicit_template_instantiations ::
  #   Implicit function/class template instantiations should be indexed.
  #   If this is not set, implicit instantiations will be ignored.
  # :suppress_warnings ::
  #   Suppress all compiler warnings when parsing for indexing.
  # :skip_parsed_bodies_in_session ::
  #   Skip a function/method body that was already parsed during an
  #   indexing session assosiated with a \c CXIndexAction object.
  #   Bodies in system headers are always skipped.
  #
  # @method `enum_index_opt_flags`
  # @return [Symbol]
  # @scope class
  #
  enum :index_opt_flags, [
    :none, 0,
    :suppress_redundant_refs, 1,
    :index_function_local_symbols, 2,
    :index_implicit_template_instantiations, 4,
    :suppress_warnings, 8,
    :skip_parsed_bodies_in_session, 16
  ]

  # Describes the calling convention of a function type
  #
  # ## Options:
  # :default ::
  #
  # :c ::
  #
  # :x86_std_call ::
  #
  # :x86_fast_call ::
  #
  # :x86_this_call ::
  #
  # :x86_pascal ::
  #
  # :aapcs ::
  #
  # :aapcs_vfp ::
  #
  # :pnacl_call ::
  #
  # :intel_ocl_bicc ::
  #
  # :x86_64_win64 ::
  #
  # :x86_64_sys_v ::
  #
  # :invalid ::
  #
  # :unexposed ::
  #
  #
  # @method `enum_calling_conv`
  # @return [Symbol]
  # @scope class
  #
  enum :calling_conv, [
    :default, 0,
    :c, 1,
    :x86_std_call, 2,
    :x86_fast_call, 3,
    :x86_this_call, 4,
    :x86_pascal, 5,
    :aapcs, 6,
    :aapcs_vfp, 7,
    :pnacl_call, 8,
    :intel_ocl_bicc, 9,
    :x86_64_win64, 10,
    :x86_64_sys_v, 11,
    :invalid, 100,
    :unexposed, 200
  ]

  # The most appropriate rendering mode for an inline command, chosen on
  # command semantics in Doxygen.
  #
  # ## Options:
  # :normal ::
  #   Command argument should be rendered in a normal font.
  # :bold ::
  #   Command argument should be rendered in a bold font.
  # :monospaced ::
  #   Command argument should be rendered in a monospaced font.
  # :emphasized ::
  #   Command argument should be rendered emphasized (typically italic
  #   font).
  #
  # @method `enum_comment_inline_command_render_kind`
  # @return [Symbol]
  # @scope class
  #
  enum :comment_inline_command_render_kind, [
    :normal, 0,
    :bold, 1,
    :monospaced, 2,
    :emphasized, 3
  ]

  # Describes a kind of token.
  #
  # ## Options:
  # :punctuation ::
  #   A token that contains some kind of punctuation.
  # :keyword ::
  #   A language keyword.
  # :identifier ::
  #   An identifier (that is not a keyword).
  # :literal ::
  #   A numeric, string, or character literal.
  # :comment ::
  #   A comment.
  #
  # @method `enum_token_kind`
  # @return [Symbol]
  # @scope class
  #
  enum :token_kind, [
    :punctuation, 0,
    :keyword, 1,
    :identifier, 2,
    :literal, 3,
    :comment, 4
  ]

  # Bits that represent the context under which completion is occurring.
  #
  # The enumerators in this enumeration may be bitwise-OR'd together if multiple
  # contexts are occurring simultaneously.
  #
  # ## Options:
  # :unexposed ::
  #   The context for completions is unexposed, as only Clang results
  #   should be included. (This is equivalent to having no context bits set.)
  # :any_type ::
  #   Completions for any possible type should be included in the results.
  # :any_value ::
  #   Completions for any possible value (variables, function calls, etc.)
  #   should be included in the results.
  # :obj_c_object_value ::
  #   Completions for values that resolve to an Objective-C object should
  #   be included in the results.
  # :obj_c_selector_value ::
  #   Completions for values that resolve to an Objective-C selector
  #   should be included in the results.
  # :cxx_class_type_value ::
  #   Completions for values that resolve to a C++ class type should be
  #   included in the results.
  # :dot_member_access ::
  #   Completions for fields of the member being accessed using the dot
  #   operator should be included in the results.
  # :arrow_member_access ::
  #   Completions for fields of the member being accessed using the arrow
  #   operator should be included in the results.
  # :obj_c_property_access ::
  #   Completions for properties of the Objective-C object being accessed
  #   using the dot operator should be included in the results.
  # :enum_tag ::
  #   Completions for enum tags should be included in the results.
  # :union_tag ::
  #   Completions for union tags should be included in the results.
  # :struct_tag ::
  #   Completions for struct tags should be included in the results.
  # :class_tag ::
  #   Completions for C++ class names should be included in the results.
  # :namespace ::
  #   Completions for C++ namespaces and namespace aliases should be
  #   included in the results.
  # :nested_name_specifier ::
  #   Completions for C++ nested name specifiers should be included in
  #   the results.
  # :obj_c_interface ::
  #   Completions for Objective-C interfaces (classes) should be included
  #   in the results.
  # :obj_c_protocol ::
  #   Completions for Objective-C protocols should be included in
  #   the results.
  # :obj_c_category ::
  #   Completions for Objective-C categories should be included in
  #   the results.
  # :obj_c_instance_message ::
  #   Completions for Objective-C instance messages should be included
  #   in the results.
  # :obj_c_class_message ::
  #   Completions for Objective-C class messages should be included in
  #   the results.
  # :obj_c_selector_name ::
  #   Completions for Objective-C selector names should be included in
  #   the results.
  # :macro_name ::
  #   Completions for preprocessor macro names should be included in
  #   the results.
  # :natural_language ::
  #   Natural language completions should be included in the results.
  # :unknown ::
  #   The current context is unknown, so set all contexts.
  #
  # @method `enum_completion_context`
  # @return [Symbol]
  # @scope class
  #
  enum :completion_context, [
    :unexposed, 0,
    :any_type, 1,
    :any_value, 2,
    :obj_c_object_value, 4,
    :obj_c_selector_value, 8,
    :cxx_class_type_value, 16,
    :dot_member_access, 32,
    :arrow_member_access, 64,
    :obj_c_property_access, 128,
    :enum_tag, 256,
    :union_tag, 512,
    :struct_tag, 1024,
    :class_tag, 2048,
    :namespace, 4096,
    :nested_name_specifier, 8192,
    :obj_c_interface, 16384,
    :obj_c_protocol, 32768,
    :obj_c_category, 65536,
    :obj_c_instance_message, 131072,
    :obj_c_class_message, 262144,
    :obj_c_selector_name, 524288,
    :macro_name, 1048576,
    :natural_language, 2097152,
    :unknown, 4194303
  ]

  # (Not documented)
  #
  # ## Options:
  # :success ::
  #   Function returned successfully.
  # :invalid ::
  #   One of the parameters was invalid for the function.
  # :visit_break ::
  #   The function was terminated by a callback (e.g. it returned
  #   CXVisit_Break)
  #
  # @method `enum_result`
  # @return [Symbol]
  # @scope class
  #
  enum :result, [
    :success, 0,
    :invalid, 1,
    :visit_break, 2
  ]

  # (Not documented)
  #
  # ## Options:
  # :lang_none ::
  #
  # :lang_c ::
  #
  # :lang_obj_c ::
  #
  # :lang_cxx ::
  #
  #
  # @method `enum_idx_entity_language`
  # @return [Symbol]
  # @scope class
  #
  enum :idx_entity_language, [
    :lang_none, 0,
    :lang_c, 1,
    :lang_obj_c, 2,
    :lang_cxx, 3
  ]

  # (Not documented)
  #
  # ## Options:
  # :forward_ref ::
  #
  # :interface ::
  #
  # :implementation ::
  #
  #
  # @method `enum_idx_obj_c_container_kind`
  # @return [Symbol]
  # @scope class
  #
  enum :idx_obj_c_container_kind, [
    :forward_ref, 0,
    :interface, 1,
    :implementation, 2
  ]

  # (Not documented)
  #
  # ## Options:
  # :unexposed ::
  #
  # :ib_action ::
  #
  # :ib_outlet ::
  #
  # :ib_outlet_collection ::
  #
  #
  # @method `enum_idx_attr_kind`
  # @return [Symbol]
  # @scope class
  #
  enum :idx_attr_kind, [
    :unexposed, 0,
    :ib_action, 1,
    :ib_outlet, 2,
    :ib_outlet_collection, 3
  ]

end
