module FFI::Gen::Clang
  # (Not documented)
  #
  # ## Fields:
  # :decl_info ::
  #   (IdxDeclInfo)
  # :getter ::
  #   (IdxEntityInfo)
  # :setter ::
  #   (IdxEntityInfo)
  class IdxObjCPropertyDeclInfo < FFI::Struct
    layout :decl_info, IdxDeclInfo,
           :getter, IdxEntityInfo,
           :setter, IdxEntityInfo
  end

end
