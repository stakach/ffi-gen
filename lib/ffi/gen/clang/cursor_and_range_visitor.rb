module FFI::Gen::Clang
  # (Not documented)
  #
  # ## Fields:
  # :context ::
  #   (FFI::Pointer(*Void))
  # :visit ::
  #   (FFI::Pointer(*))
  class CursorAndRangeVisitor < FFI::Struct
    layout :context, :pointer,
           :visit, :pointer
  end

end
