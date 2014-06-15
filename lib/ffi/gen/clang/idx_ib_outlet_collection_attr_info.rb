module FFI::Gen::Clang
  # (Not documented)
  #
  # ## Fields:
  # :attr_info ::
  #   (IdxAttrInfo)
  # :objc_class ::
  #   (IdxEntityInfo)
  # :class_cursor ::
  #   (Cursor)
  # :class_loc ::
  #   (IdxLoc)
  class IdxIBOutletCollectionAttrInfo < FFI::Struct
    layout :attr_info, IdxAttrInfo,
           :objc_class, IdxEntityInfo,
           :class_cursor, Cursor.by_value,
           :class_loc, IdxLoc.by_value
  end

end
