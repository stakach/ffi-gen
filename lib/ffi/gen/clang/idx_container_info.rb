module FFI::Gen::Clang
  # (Not documented)
  #
  # ## Fields:
  # :cursor ::
  #   (Cursor)
  class IdxContainerInfo < FFI::Struct
    layout :cursor, Cursor.by_value
  end

end
