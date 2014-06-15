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
    layout :decl_info, IdxDeclInfo.by_ref,
           :getter, IdxEntityInfo.by_ref,
           :setter, IdxEntityInfo.by_ref
  end

end
