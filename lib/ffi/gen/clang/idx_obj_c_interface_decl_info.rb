module FFI::Gen::Clang
  # (Not documented)
  #
  # ## Fields:
  # :container_info ::
  #   (IdxObjCContainerDeclInfo)
  # :super_info ::
  #   (IdxBaseClassInfo)
  # :protocols ::
  #   (IdxObjCProtocolRefListInfo)
  class IdxObjCInterfaceDeclInfo < FFI::Struct
    layout :container_info, IdxObjCContainerDeclInfo.by_ref,
           :super_info, IdxBaseClassInfo.by_ref,
           :protocols, IdxObjCProtocolRefListInfo.by_ref
  end

end
