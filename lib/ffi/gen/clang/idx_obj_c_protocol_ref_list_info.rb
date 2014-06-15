module FFI::Gen::Clang
  # (Not documented)
  #
  # ## Fields:
  # :protocols ::
  #   (FFI::Pointer(**IdxObjCProtocolRefInfo))
  # :num_protocols ::
  #   (Integer)
  class IdxObjCProtocolRefListInfo < FFI::Struct
    layout :protocols, :pointer,
           :num_protocols, :uint
  end

end
