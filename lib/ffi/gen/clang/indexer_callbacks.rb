module FFI::Gen::Clang
  # A group of callbacks used by #clang_indexSourceFile and
  # #clang_indexTranslationUnit.
  #
  # ## Fields:
  # :abort_query ::
  #   (FFI::Pointer(*)) Called periodically to check whether indexing should be aborted.
  #   Should return 0 to continue, and non-zero to abort.
  # :diagnostic ::
  #   (FFI::Pointer(*)) Called at the end of indexing; passes the complete diagnostic set.
  # :entered_main_file ::
  #   (FFI::Pointer(*))
  # :pp_included_file ::
  #   (FFI::Pointer(*)) Called when a file gets \#included/\#imported.
  # :imported_ast_file ::
  #   (FFI::Pointer(*)) Called when a AST file (PCH or module) gets imported.
  #
  #   AST files will not get indexed (there will not be callbacks to index all
  #   the entities in an AST file). The recommended action is that, if the AST
  #   file is not already indexed, to initiate a new indexing job specific to
  #   the AST file.
  # :started_translation_unit ::
  #   (FFI::Pointer(*)) Called at the beginning of indexing a translation unit.
  # :index_declaration ::
  #   (FFI::Pointer(*))
  # :index_entity_reference ::
  #   (FFI::Pointer(*)) Called to index a reference of an entity.
  class IndexerCallbacks < FFI::Struct
    layout :abort_query, :pointer,
           :diagnostic, :pointer,
           :entered_main_file, :pointer,
           :pp_included_file, :pointer,
           :imported_ast_file, :pointer,
           :started_translation_unit, :pointer,
           :index_declaration, :pointer,
           :index_entity_reference, :pointer
  end

end
