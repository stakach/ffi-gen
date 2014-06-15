module FFI::Gen::Clang
  # (Not documented)
  #
  # ## Fields:
  # :entity_info ::
  #   (IdxEntityInfo)
  # :cursor ::
  #   (Cursor)
  # :loc ::
  #   (IdxLoc)
  # :semantic_container ::
  #   (IdxContainerInfo)
  # :lexical_container ::
  #   (IdxContainerInfo) Generally same as #semanticContainer but can be different in
  #   cases like out-of-line C++ member functions.
  # :is_redeclaration ::
  #   (Integer)
  # :is_definition ::
  #   (Integer)
  # :is_container ::
  #   (Integer)
  # :decl_as_container ::
  #   (IdxContainerInfo)
  # :is_implicit ::
  #   (Integer) Whether the declaration exists in code or was created implicitly
  #   by the compiler, e.g. implicit objc methods for properties.
  # :attributes ::
  #   (FFI::Pointer(**IdxAttrInfo))
  # :num_attributes ::
  #   (Integer)
  # :flags ::
  #   (Integer)
  class IdxDeclInfo < FFI::Struct
    layout :entity_info, IdxEntityInfo.by_ref,
           :cursor, Cursor.by_value,
           :loc, IdxLoc.by_value,
           :semantic_container, IdxContainerInfo.by_ref,
           :lexical_container, IdxContainerInfo.by_ref,
           :is_redeclaration, :int,
           :is_definition, :int,
           :is_container, :int,
           :decl_as_container, IdxContainerInfo.by_ref,
           :is_implicit, :int,
           :attributes, :pointer,
           :num_attributes, :uint,
           :flags, :uint
  end

end
