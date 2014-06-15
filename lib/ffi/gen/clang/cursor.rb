module FFI::Gen::Clang
  # A cursor representing some element in the abstract syntax tree for
  # a translation unit.
  #
  # The cursor abstraction unifies the different kinds of entities in a
  # program--declaration, statements, expressions, references to declarations,
  # etc.--under a single "cursor" abstraction with a common set of operations.
  # Common operation for a cursor include: getting the physical location in
  # a source file where the cursor points, getting the name associated with a
  # cursor, and retrieving cursors for any child nodes of a particular cursor.
  #
  # Cursors can be produced in two specific ways.
  # clang_getTranslationUnitCursor() produces a cursor for a translation unit,
  # from which one can use clang_visitChildren() to explore the rest of the
  # translation unit. clang_getCursor() maps from a physical source location
  # to the entity that resides at that location, allowing one to map from the
  # source code into the AST.
  #
  # ## Fields:
  # :kind ::
  #   (Symbol from `enum_cursor_kind`)
  # :xdata ::
  #   (Integer)
  # :data ::
  #   (Array<FFI::Pointer(*Void)>)
  class Cursor < FFI::Struct
    layout :kind, :cursor_kind,
           :xdata, :int,
           :data, [:pointer, 3]
  end

end
