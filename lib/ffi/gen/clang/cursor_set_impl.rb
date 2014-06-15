module FFI::Gen::Clang
  # A fast container representing a set of CXCursors.
  class CursorSetImpl < FFI::Struct
    layout :dummy, :char
  end

end
