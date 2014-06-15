module FFI::Gen::Clang
  # (Not documented)
  #
  # ## Fields:
  # :kind ::
  #   (Symbol from `enum_idx_attr_kind`)
  # :cursor ::
  #   (Cursor)
  # :loc ::
  #   (IdxLoc)
  class IdxAttrInfo < FFI::Struct
    layout :kind, :idx_attr_kind,
           :cursor, Cursor.by_value,
           :loc, IdxLoc.by_value
  end

end
