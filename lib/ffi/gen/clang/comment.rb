module FFI::Gen::Clang
  # A comment AST node.
  #
  # ## Fields:
  # :ast_node ::
  #   (FFI::Pointer(*Void))
  # :translation_unit ::
  #   (TranslationUnit)
  class Comment < FFI::Struct
    layout :ast_node, :pointer,
           :translation_unit, TranslationUnit.by_ref
  end

end
