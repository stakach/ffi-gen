module FFI::Gen::Clang
  # Identifies a specific source location within a translation
  # unit.
  #
  # Use clang_getExpansionLocation() or clang_getSpellingLocation()
  # to map a source location to a particular file, line, and column.
  #
  # ## Fields:
  # :ptr_data ::
  #   (Array<FFI::Pointer(*Void)>)
  # :int_data ::
  #   (Integer)
  class SourceLocation < FFI::Struct
    layout :ptr_data, [:pointer, 2],
           :int_data, :uint
  end

end
