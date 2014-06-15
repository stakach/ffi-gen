module FFI::Gen::Clang
  # A fast container representing a set of CXCursors.
  class CursorSet < FFI::Struct
    layout :dummy, :char
  end

end
