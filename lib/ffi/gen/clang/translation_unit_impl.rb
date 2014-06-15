module FFI::Gen::Clang
  # A single translation unit, which resides in an index.
  class TranslationUnitImpl < FFI::Struct
    layout :dummy, :char
  end

end
