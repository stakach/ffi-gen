module FFI::Gen::Clang
  # (Not documented)
  #
  # ## Fields:
  # :decl_info ::
  #   (IdxDeclInfo)
  # :kind ::
  #   (Symbol from `enum_idx_obj_c_container_kind`)
  class IdxObjCContainerDeclInfo < FFI::Struct
    layout :decl_info, IdxDeclInfo.by_ref,
           :kind, :idx_obj_c_container_kind
  end

end
