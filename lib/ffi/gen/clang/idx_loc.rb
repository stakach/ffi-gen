module FFI::Gen::Clang
  # Source location passed to index callbacks.
  #
  # ## Fields:
  # :ptr_data ::
  #   (Array<FFI::Pointer(*Void)>)
  # :int_data ::
  #   (Integer)
  class IdxLoc < FFI::Struct
    layout :ptr_data, [:pointer, 2],
           :int_data, :uint
  end

end
