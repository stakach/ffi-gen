module FFI::Gen::Clang
  # A single translation unit, which resides in an index.
  class TranslationUnit < FFI::Struct
    layout :dummy, :char
  end

end
