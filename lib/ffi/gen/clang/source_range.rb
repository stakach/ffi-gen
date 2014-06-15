module FFI::Gen::Clang
  # Identifies a half-open character range in the source code.
  #
  # Use clang_getRangeStart() and clang_getRangeEnd() to retrieve the
  # starting and end locations from a source range, respectively.
  #
  # ## Fields:
  # :ptr_data ::
  #   (Array<FFI::Pointer(*Void)>)
  # :begin_int_data ::
  #   (Integer)
  # :end_int_data ::
  #   (Integer)
  class SourceRange < FFI::Struct
    layout :ptr_data, [:pointer, 2],
           :begin_int_data, :uint,
           :end_int_data, :uint
  end

end
