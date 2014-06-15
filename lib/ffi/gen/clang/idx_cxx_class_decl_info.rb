module FFI::Gen::Clang
  # (Not documented)
  #
  # ## Fields:
  # :decl_info ::
  #   (IdxDeclInfo)
  # :bases ::
  #   (FFI::Pointer(**IdxBaseClassInfo))
  # :num_bases ::
  #   (Integer)
  class IdxCXXClassDeclInfo < FFI::Struct
    layout :decl_info, IdxDeclInfo,
           :bases, :pointer,
           :num_bases, :uint
  end

end
