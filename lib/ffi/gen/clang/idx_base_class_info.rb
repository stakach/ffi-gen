module FFI::Gen::Clang
  # (Not documented)
  #
  # ## Fields:
  # :base ::
  #   (IdxEntityInfo)
  # :cursor ::
  #   (Cursor)
  # :loc ::
  #   (IdxLoc)
  class IdxBaseClassInfo < FFI::Struct
    layout :base, IdxEntityInfo,
           :cursor, Cursor.by_value,
           :loc, IdxLoc.by_value
  end

end
