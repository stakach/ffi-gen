module FFI::Gen::Clang
  # Describes a single preprocessing token.
  #
  # ## Fields:
  # :int_data ::
  #   (Array<Integer>)
  # :ptr_data ::
  #   (FFI::Pointer(*Void))
  class Token < FFI::Struct
    layout :int_data, [:uint, 4],
           :ptr_data, :pointer
  end

end
