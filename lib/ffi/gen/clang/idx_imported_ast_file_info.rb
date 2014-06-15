module FFI::Gen::Clang
  # Data for IndexerCallbacks#importedASTFile.
  #
  # ## Fields:
  # :file ::
  #   (FFI::Pointer(File)) Top level AST file containing the imported PCH, module or submodule.
  # :module_ ::
  #   (FFI::Pointer(Module)) The imported module or NULL if the AST file is a PCH.
  # :loc ::
  #   (IdxLoc) Location where the file is imported. Applicable only for modules.
  # :is_implicit ::
  #   (Integer) Non-zero if an inclusion directive was automatically turned into
  #   a module import. Applicable only for modules.
  class IdxImportedASTFileInfo < FFI::Struct
    layout :file, :pointer,
           :module_, :pointer,
           :loc, IdxLoc.by_value,
           :is_implicit, :int
  end

end
