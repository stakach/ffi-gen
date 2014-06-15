module FFI::Gen::Clang
  # (Not documented)
  #
  # ## Fields:
  # :container_info ::
  #   (IdxObjCContainerDeclInfo)
  # :objc_class ::
  #   (IdxEntityInfo)
  # :class_cursor ::
  #   (Cursor)
  # :class_loc ::
  #   (IdxLoc)
  # :protocols ::
  #   (IdxObjCProtocolRefListInfo)
  class IdxObjCCategoryDeclInfo < FFI::Struct
    layout :container_info, IdxObjCContainerDeclInfo,
           :objc_class, IdxEntityInfo,
           :class_cursor, Cursor.by_value,
           :class_loc, IdxLoc.by_value,
           :protocols, IdxObjCProtocolRefListInfo
  end

end
