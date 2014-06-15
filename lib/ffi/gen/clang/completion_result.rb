module FFI::Gen::Clang
  # A single result of code completion.
  #
  # ## Fields:
  # :cursor_kind ::
  #   (Symbol from `enum_cursor_kind`) The kind of entity that this completion refers to.
  #
  #   The cursor kind will be a macro, keyword, or a declaration (one of the
  #   *Decl cursor kinds), describing the entity that the completion is
  #   referring to.
  #
  #   \todo In the future, we would like to provide a full cursor, to allow
  #   the client to extract additional information from declaration.
  # :completion_string ::
  #   (FFI::Pointer(CompletionString)) The code-completion string that describes how to insert this
  #   code-completion result into the editing buffer.
  class CompletionResult < FFI::Struct
    layout :cursor_kind, :cursor_kind,
           :completion_string, :pointer
  end

end
