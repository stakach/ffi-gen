module FFI::Gen::Clang
  # (Not documented)
  #
  # ## Fields:
  # :data ::
  #   (FFI::Pointer(*Void))
  # :private_flags ::
  #   (Integer)
  class String < FFI::Struct
    layout :data, :pointer,
           :private_flags, :uint
  end

end
